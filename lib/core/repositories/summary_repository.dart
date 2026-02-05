import '../database/database_service.dart';
import '../database/models/daily_summary_model.dart';
import '../database/daos/daily_summary_dao.dart';
import '../services/daily_summary_service.dart';

/// Repository for daily summary data access
class SummaryRepository {
  final DatabaseService _dbService = DatabaseService();
  final DailySummaryDao _summaryDao = DailySummaryDao();
  final DailySummaryService _summaryService = DailySummaryService();

  /// Get daily summary (calculates if doesn't exist)
  Future<DailySummaryModel> getDailySummary(int userId, DateTime date) async {
    final dateStr = date.toIso8601String().split('T')[0];
    
    // Try to get existing summary
    var summary = await _summaryDao.getDailySummary(userId, dateStr);
    
    // If doesn't exist, calculate it
    if (summary == null) {
      summary = await _summaryService.calculateDailySummary(
        userId: userId,
        date: dateStr,
      );
    }
    
    return summary;
  }

  /// Get weekly summaries
  Future<List<DailySummaryModel>> getWeeklySummaries(
    int userId,
    DateTime weekStart,
  ) async {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final startStr = weekStart.toIso8601String().split('T')[0];
    final endStr = weekEnd.toIso8601String().split('T')[0];
    
    return await _summaryDao.getDailySummariesByDateRange(
      userId,
      startStr,
      endStr,
    );
  }

  /// Calculate and refresh daily summary
  Future<DailySummaryModel> refreshDailySummary(int userId, DateTime date) async {
    final dateStr = date.toIso8601String().split('T')[0];
    return await _summaryService.calculateDailySummary(
      userId: userId,
      date: dateStr,
    );
  }
}

