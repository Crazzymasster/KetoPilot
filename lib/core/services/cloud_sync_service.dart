import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database_service.dart';
import '../database/daos/diet_entry_dao.dart';
import '../database/daos/health_log_dao.dart';
import '../database/daos/daily_summary_dao.dart';
import '../api/api_client.dart';

/// Service for cloud synchronization
class CloudSyncService {
  final DatabaseService _dbService;
  final ApiClient _apiClient;
  final DietEntryDao _dietEntryDao = DietEntryDao();
  final HealthLogDao _healthLogDao = HealthLogDao();
  final DailySummaryDao _summaryDao = DailySummaryDao();
  StreamSubscription? _connectivitySubscription;

  CloudSyncService(this._dbService, this._apiClient);

  /// Sync local changes to cloud
  Future<void> syncToCloud(int userId) async {
    try {
      // Get unsynced diet entries
      final unsyncedEntries = await _dietEntryDao.getUnsyncedDietEntries(userId);
      
      if (unsyncedEntries.isNotEmpty) {
        final entriesData = unsyncedEntries.map((e) => e.toMap()).toList();
        
        final response = await _apiClient.dio.post(
          '/api/sync/diet-entries',
          data: {'entries': entriesData},
        );

        if (response.statusCode == 200) {
          final entryIds = unsyncedEntries
              .where((e) => e.entryId != null)
              .map((e) => e.entryId!)
              .toList();
          await _dietEntryDao.markAsSynced(entryIds);
        }
      }

      // Get unsynced health logs
      final unsyncedLogs = await _healthLogDao.getUnsyncedHealthLogs(userId);
      
      if (unsyncedLogs.isNotEmpty) {
        final logsData = unsyncedLogs.map((l) => l.toMap()).toList();
        
        final response = await _apiClient.dio.post(
          '/api/sync/health-logs',
          data: {'logs': logsData},
        );

        if (response.statusCode == 200) {
          final logIds = unsyncedLogs
              .where((l) => l.logId != null)
              .map((l) => l.logId!)
              .toList();
          await _healthLogDao.markAsSynced(logIds);
        }
      }

      // Get unsynced daily summaries
      final unsyncedSummaries = await _summaryDao.getUnsyncedDailySummaries(userId);
      
      if (unsyncedSummaries.isNotEmpty) {
        final summariesData = unsyncedSummaries.map((s) => s.toMap()).toList();
        
        await _apiClient.dio.post(
          '/api/sync/daily-summaries',
          data: {'summaries': summariesData},
        );
      }

      // Update last sync time
      await _updateLastSyncTime();
    } catch (e) {
      print('Error syncing to cloud: $e');
      rethrow;
    }
  }

  /// Download cloud changes (with conflict resolution)
  Future<void> syncFromCloud(int userId, DateTime lastSyncTime) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/sync/changes?since=${lastSyncTime.toIso8601String()}',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final db = await _dbService.database;

        // Handle diet entries
        if (data['diet_entries'] != null) {
          for (final entryData in data['diet_entries']) {
            await _handleDietEntryConflict(db, entryData);
          }
        }

        // Handle health logs
        if (data['health_logs'] != null) {
          for (final logData in data['health_logs']) {
            await _handleHealthLogConflict(db, logData);
          }
        }

        // Handle daily summaries
        if (data['daily_summaries'] != null) {
          for (final summaryData in data['daily_summaries']) {
            await _handleDailySummaryConflict(db, summaryData);
          }
        }

        await _updateLastSyncTime();
      }
    } catch (e) {
      print('Error syncing from cloud: $e');
      rethrow;
    }
  }

  /// Handle conflict resolution for diet entries (last-write-wins)
  Future<void> _handleDietEntryConflict(
    dynamic db,
    Map<String, dynamic> cloudEntry,
  ) async {
    final entryId = cloudEntry['entry_id'] as int?;
    if (entryId == null) return;

    final existing = await db.query(
      'tb_diet_entries',
      where: 'entry_id = ?',
      whereArgs: [entryId],
    );

    if (existing.isEmpty) {
      // New entry from cloud
      await db.insert('tb_diet_entries', {
        ...cloudEntry,
        'synced': 1,
      });
    } else {
      // Conflict - compare timestamps
      final localUpdated = DateTime.parse(existing[0]['updated_at'] as String);
      final cloudUpdated = DateTime.parse(cloudEntry['updated_at'] as String);

      if (cloudUpdated.isAfter(localUpdated)) {
        // Cloud version is newer
        await db.update(
          'tb_diet_entries',
          {
            ...cloudEntry,
            'synced': 1,
          },
          where: 'entry_id = ?',
          whereArgs: [entryId],
        );
      }
    }
  }

  /// Handle conflict resolution for health logs
  Future<void> _handleHealthLogConflict(
    dynamic db,
    Map<String, dynamic> cloudLog,
  ) async {
    final logId = cloudLog['log_id'] as int?;
    if (logId == null) return;

    final existing = await db.query(
      'tb_health_log',
      where: 'log_id = ?',
      whereArgs: [logId],
    );

    if (existing.isEmpty) {
      await db.insert('tb_health_log', {
        ...cloudLog,
        'synced': 1,
      });
    } else {
      final localCreated = DateTime.parse(existing[0]['created_at'] as String);
      final cloudCreated = DateTime.parse(cloudLog['created_at'] as String);

      if (cloudCreated.isAfter(localCreated)) {
        await db.update(
          'tb_health_log',
          {
            ...cloudLog,
            'synced': 1,
          },
          where: 'log_id = ?',
          whereArgs: [logId],
        );
      }
    }
  }

  /// Handle conflict resolution for daily summaries
  Future<void> _handleDailySummaryConflict(
    dynamic db,
    Map<String, dynamic> cloudSummary,
  ) async {
    final userId = cloudSummary['user_id'] as int;
    final date = cloudSummary['date'] as String;

    final existing = await db.query(
      'tb_daily_summary',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
    );

    if (existing.isEmpty) {
      await db.insert('tb_daily_summary', {
        ...cloudSummary,
        'synced': 1,
      });
    } else {
      final localCalculated = DateTime.parse(
        existing[0]['last_calculated_at'] as String,
      );
      final cloudCalculated = DateTime.parse(
        cloudSummary['last_calculated_at'] as String,
      );

      if (cloudCalculated.isAfter(localCalculated)) {
        await db.update(
          'tb_daily_summary',
          {
            ...cloudSummary,
            'synced': 1,
          },
          where: 'user_id = ? AND date = ?',
          whereArgs: [userId, date],
        );
      }
    }
  }

  /// Enable auto-sync on network connectivity change
  /// Note: Requires connectivity_plus package
  void enableAutoSync(int userId) {
    // Uncomment when connectivity_plus is added:
    /*
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (result) async {
        if (result != ConnectivityResult.none) {
          try {
            await syncToCloud(userId);
            final lastSync = await _getLastSyncTime();
            await syncFromCloud(userId, lastSync);
          } catch (e) {
            print('Error in auto-sync: $e');
          }
        }
      },
    );
    */
  }

  /// Disable auto-sync
  void disableAutoSync() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }

  /// Get last sync time
  Future<DateTime> _getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString('last_sync_time');
    return timestamp != null
        ? DateTime.parse(timestamp)
        : DateTime.now().subtract(const Duration(days: 30));
  }

  /// Update last sync time
  Future<void> _updateLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_sync_time', DateTime.now().toIso8601String());
  }
}

