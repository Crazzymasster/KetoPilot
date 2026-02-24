import 'package:flutter/foundation.dart' show debugPrint;
import '../services/supabase_service.dart';
import '../database/daos/drift_diet_entry_dao.dart';
import '../database/daos/drift_user_dao.dart';
import '../database/models/diet_entry_model.dart';

/// Sync service for diet entries between local DB and Supabase
/// Local-first approach: log locally, sync in background
class DietEntrySyncService {
  static DietEntrySyncService? _instance;
  final DriftDietEntryDao _dietEntryDao = DriftDietEntryDao();
  final DriftUserDao _userDao = DriftUserDao();
  
  bool _isSyncing = false;
  
  DietEntrySyncService._internal();
  
  factory DietEntrySyncService() {
    _instance ??= DietEntrySyncService._internal();
    return _instance!;
  }

  /// Push unsynced local entries to Supabase
  /// OPTIMIZED: Uses batch upsert instead of individual inserts
  Future<void> pushToCloud(String supabaseUserId, int localUserId) async {
    if (_isSyncing) {
      debugPrint('[SYNC] Already syncing, skipping push');
      return;
    }
    _isSyncing = true;
    
    try {
      final client = SupabaseService().client;
      final unsynced = await _dietEntryDao.getUnsyncedEntries(localUserId);
      
      if (unsynced.isEmpty) {
        debugPrint('[SYNC] No entries to push');
        return;
      }
      
      debugPrint('[SYNC] Pushing ${unsynced.length} entries to cloud...');
      
      // Batch entries for upsert (chunks of 50 for safety)
      const batchSize = 50;
      for (var i = 0; i < unsynced.length; i += batchSize) {
        final batch = unsynced.skip(i).take(batchSize).toList();
        final payloads = batch.map((e) => _entryToSupabasePayload(e, supabaseUserId)).toList();
        
        try {
          // Batch upsert - much faster than individual inserts
          final results = await client
              .from('diet_entries')
              .upsert(
                payloads,
                onConflict: 'user_id,local_entry_id',
              )
              .select('id,local_entry_id');
          
          // Mark batch as synced
          for (final result in results) {
            final localId = result['local_entry_id'] as int?;
            final cloudId = result['id'] as String;
            if (localId != null) {
              await _dietEntryDao.markAsSynced(localId, cloudId);
            }
          }
          
          debugPrint('[SYNC] ✅ Pushed batch of ${batch.length} entries');
        } catch (e) {
          debugPrint('[SYNC] ⚠️ Batch push failed, falling back to individual: $e');
          // Fallback to individual inserts for this batch
          await _pushBatchIndividually(batch, supabaseUserId, client);
        }
      }
      
      debugPrint('[SYNC] Push complete');
    } catch (e) {
      debugPrint('[SYNC] ❌ Push error: $e');
    } finally {
      _isSyncing = false;
    }
  }
  
  /// Fallback: push entries individually if batch fails
  Future<void> _pushBatchIndividually(
    List<DietEntryModel> entries,
    String supabaseUserId,
    dynamic client,
  ) async {
    for (final entry in entries) {
      try {
        final existing = await client
            .from('diet_entries')
            .select('id')
            .eq('user_id', supabaseUserId)
            .eq('local_entry_id', entry.entryId!)
            .maybeSingle();
        
        if (existing != null) {
          await _dietEntryDao.markAsSynced(entry.entryId!, existing['id']);
          continue;
        }
        
        final payload = _entryToSupabasePayload(entry, supabaseUserId);
        final result = await client
            .from('diet_entries')
            .insert(payload)
            .select('id')
            .single();
        
        await _dietEntryDao.markAsSynced(entry.entryId!, result['id']);
      } catch (e) {
        debugPrint('[SYNC] ⚠️ Failed to push entry ${entry.entryId}: $e');
      }
    }
  }

  /// Pull entries from Supabase and merge into local DB
  Future<void> pullFromCloud(String supabaseUserId, int localUserId) async {
    if (_isSyncing) {
      debugPrint('[SYNC] Already syncing, skipping pull');
      return;
    }
    _isSyncing = true;
    
    try {
      final client = SupabaseService().client;
      
      debugPrint('[SYNC] Pulling entries from cloud...');
      
      //get all cloud entries for this user (not deleted)
      final cloudEntries = await client
          .from('diet_entries')
          .select()
          .eq('user_id', supabaseUserId)
          .isFilter('deleted_at', null)
          .order('recorded_at', ascending: false);
      
      debugPrint('[SYNC] Found ${cloudEntries.length} cloud entries');
      
      int imported = 0;
      for (final cloudEntry in cloudEntries) {
        try {
          final cloudId = cloudEntry['id'] as String;
          
          //check if already exists locally
          final existing = await _dietEntryDao.getByCloudId(cloudId);
          if (existing != null) {
            continue; //already have this entry
          }
          
          //create local entry from cloud data
          final localEntry = _cloudEntryToModel(cloudEntry, localUserId);
          await _dietEntryDao.insertFromCloud(localEntry);
          imported++;
        } catch (e) {
          debugPrint('[SYNC] ⚠️ Failed to import cloud entry: $e');
        }
      }
      
      debugPrint('[SYNC] ✅ Imported $imported new entries from cloud');
    } catch (e) {
      debugPrint('[SYNC] ❌ Pull error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  /// Full sync: push local changes then pull cloud changes
  Future<void> fullSync(String supabaseUserId, int localUserId) async {
    debugPrint('[SYNC] Starting full sync...');
    
    //push first so we don't overwrite local with stale cloud data
    await pushToCloud(supabaseUserId, localUserId);
    
    //wait a moment for any cloud writes to settle
    await Future.delayed(const Duration(milliseconds: 500));
    
    //then pull any entries from other devices
    await pullFromCloud(supabaseUserId, localUserId);
    
    debugPrint('[SYNC] Full sync complete');
  }

  /// Push a single entry immediately after insert
  Future<void> pushSingleEntry(
    DietEntryModel entry,
    String supabaseUserId,
  ) async {
    try {
      final client = SupabaseService().client;
      
      final payload = _entryToSupabasePayload(entry, supabaseUserId);
      final result = await client
          .from('diet_entries')
          .insert(payload)
          .select('id')
          .single();
      
      if (entry.entryId != null) {
        await _dietEntryDao.markAsSynced(entry.entryId!, result['id']);
      }
      
      debugPrint('[SYNC] ✅ Entry synced immediately');
    } catch (e) {
      debugPrint('[SYNC] ⚠️ Immediate sync failed (will retry): $e');
      //entry remains unsynced, will be pushed on next sync
    }
  }

  /// Convert local entry to Supabase payload
  Map<String, dynamic> _entryToSupabasePayload(
    DietEntryModel entry,
    String supabaseUserId,
  ) {
    return {
      'user_id': supabaseUserId,
      'local_entry_id': entry.entryId,
      'food_id': entry.foodId,
      'recorded_at': entry.recordedAt,
      'date': entry.date,
      'portion_id': entry.portionId,
      'custom_portion_grams': entry.customPortionGrams,
      'serving_size_multiplier': entry.servingSizeMultiplier,
      'total_energy_kcal': entry.totalEnergyKcal,
      'total_protein_g': entry.totalProteinG,
      'total_fat_g': entry.totalFatG,
      'total_carbohydrate_g': entry.totalCarbohydrateG,
      'total_net_carbs_g': entry.totalNetCarbsG,
      'total_fiber_g': entry.totalFiberG,
      'total_sodium_mg': entry.totalSodiumMg,
      'meal_context': entry.mealContext,
      'location': entry.location,
      'notes': entry.notes,
      'food_photo_url': entry.foodPhotoUrl,
      'created_at': entry.createdAt,
    };
  }

  /// Convert cloud entry to local model
  DietEntryModel _cloudEntryToModel(
    Map<String, dynamic> cloudEntry,
    int localUserId,
  ) {
    return DietEntryModel(
      userId: localUserId,
      foodId: cloudEntry['food_id'] as int,
      recordedAt: cloudEntry['recorded_at'] as String,
      date: cloudEntry['date'] as String,
      portionId: cloudEntry['portion_id'] as int?,
      customPortionGrams: (cloudEntry['custom_portion_grams'] as num?)?.toDouble(),
      servingSizeMultiplier: (cloudEntry['serving_size_multiplier'] as num?)?.toDouble() ?? 1.0,
      totalEnergyKcal: (cloudEntry['total_energy_kcal'] as num).toDouble(),
      totalProteinG: (cloudEntry['total_protein_g'] as num).toDouble(),
      totalFatG: (cloudEntry['total_fat_g'] as num).toDouble(),
      totalCarbohydrateG: (cloudEntry['total_carbohydrate_g'] as num).toDouble(),
      totalNetCarbsG: (cloudEntry['total_net_carbs_g'] as num).toDouble(),
      totalFiberG: (cloudEntry['total_fiber_g'] as num?)?.toDouble(),
      totalSodiumMg: (cloudEntry['total_sodium_mg'] as num?)?.toDouble(),
      mealContext: cloudEntry['meal_context'] as String?,
      location: cloudEntry['location'] as String?,
      notes: cloudEntry['notes'] as String?,
      foodPhotoUrl: cloudEntry['food_photo_url'] as String?,
      synced: 1, //from cloud, already synced
      cloudId: cloudEntry['id'] as String,
      createdAt: cloudEntry['created_at'] as String?,
      updatedAt: cloudEntry['updated_at'] as String?,
    );
  }
}
