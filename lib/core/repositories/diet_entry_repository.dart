import '../database/database_service.dart';
import '../database/models/diet_entry_model.dart';
import '../database/daos/diet_entry_dao.dart';
import '../database/daos/user_food_history_dao.dart';
import '../services/daily_summary_service.dart';

/// Repository for diet entry data access
class DietEntryRepository {
  final DatabaseService _dbService = DatabaseService();
  final DietEntryDao _dietEntryDao = DietEntryDao();
  final UserFoodHistoryDao _foodHistoryDao = UserFoodHistoryDao();
  final DailySummaryService _summaryService = DailySummaryService();

  /// Get diet entries for a date
  Future<List<DietEntryModel>> getEntriesByDate(int userId, DateTime date) async {
    final dateStr = date.toIso8601String().split('T')[0];
    return await _dietEntryDao.getDietEntriesByDate(userId, dateStr);
  }

  /// Get diet entries for a date range
  Future<List<DietEntryModel>> getEntriesByDateRange(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final startStr = startDate.toIso8601String().split('T')[0];
    final endStr = endDate.toIso8601String().split('T')[0];
    return await _dietEntryDao.getDietEntriesByDateRange(userId, startStr, endStr);
  }

  /// Add diet entry
  Future<int> addEntry({
    required DietEntryModel entry,
    required int userId,
  }) async {
    final entryId = await _dietEntryDao.insertDietEntry(entry);
    
    // Update food history
    if (entry.foodId != null) {
      final recordedAt = DateTime.parse(entry.recordedAt);
      await _foodHistoryDao.recordConsumption(
        userId: userId,
        foodId: entry.foodId!,
        consumedAt: recordedAt,
      );
    }

    // Recalculate daily summary
    final dateStr = entry.date;
    await _summaryService.calculateDailySummary(
      userId: userId,
      date: dateStr,
    );

    return entryId;
  }

  /// Delete diet entry
  Future<void> deleteEntry(int entryId, int userId) async {
    // Get entry to get date for summary recalculation
    final entry = await _dietEntryDao.getDietEntryById(entryId);
    if (entry == null) {
      throw Exception('Entry not found');
    }

    await _dietEntryDao.deleteDietEntry(entryId);

    // Recalculate daily summary
    await _summaryService.calculateDailySummary(
      userId: userId,
      date: entry.date,
    );
  }

  /// Get daily totals
  Future<Map<String, double>> getDailyTotals(int userId, DateTime date) async {
    final dateStr = date.toIso8601String().split('T')[0];
    return await _dietEntryDao.getDailyTotals(userId, dateStr);
  }
}

