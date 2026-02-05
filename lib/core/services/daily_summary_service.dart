import 'package:sqflite/sqflite.dart';
import '../database/database_service.dart';
import '../database/models/daily_summary_model.dart';
import '../database/models/user_model.dart';
import '../database/daos/daily_summary_dao.dart';
import '../database/daos/diet_entry_dao.dart';
import '../database/daos/health_log_dao.dart';
import '../database/daos/user_dao.dart';

/// Service for calculating and managing daily summaries
class DailySummaryService {
  final DatabaseService _dbService = DatabaseService();
  final DailySummaryDao _summaryDao = DailySummaryDao();
  final DietEntryDao _dietEntryDao = DietEntryDao();
  final HealthLogDao _healthLogDao = HealthLogDao();
  final UserDao _userDao = UserDao();

  /// Calculate and upsert daily summary for a user and date
  /// Includes caching to avoid unnecessary recalculations
  Future<DailySummaryModel> calculateDailySummary({
    required int userId,
    required String date,
  }) async {
    // Check if already calculated recently (within last hour)
    final existing = await _summaryDao.getDailySummary(userId, date);
    if (existing != null) {
      final lastCalc = DateTime.parse(existing.lastCalculatedAt);
      if (DateTime.now().difference(lastCalc).inHours < 1) {
        // Return cached version if calculated within last hour
        return existing;
      }
    }

    final db = await _dbService.database;
    final user = await _userDao.getUserById(userId);
    if (user == null) {
      throw Exception('User not found');
    }

    // Get diet totals
    final dietTotals = await _dietEntryDao.getDailyTotals(userId, date);

    // Get health log averages
    final healthLogs = await _healthLogDao.getHealthLogsByDate(userId, date);

    // Calculate averages
    double? avgGlucose;
    double? avgKetones;
    double? avgGki;
    double? minGki;
    double? maxGki;
    double? weightKg;

    if (healthLogs.isNotEmpty) {
      final glucoseValues = healthLogs
          .where((log) => log.bloodGlucoseMgDl != null)
          .map((log) => log.bloodGlucoseMgDl!)
          .toList();
      final ketoneValues = healthLogs
          .where((log) => log.bloodKetonesMmolL != null)
          .map((log) => log.bloodKetonesMmolL!)
          .toList();
      final gkiValues = healthLogs
          .where((log) => log.gkiScore != null)
          .map((log) => log.gkiScore!)
          .toList();

      if (glucoseValues.isNotEmpty) {
        avgGlucose = glucoseValues.reduce((a, b) => a + b) / glucoseValues.length;
      }
      if (ketoneValues.isNotEmpty) {
        avgKetones = ketoneValues.reduce((a, b) => a + b) / ketoneValues.length;
      }
      if (gkiValues.isNotEmpty) {
        avgGki = gkiValues.reduce((a, b) => a + b) / gkiValues.length;
        minGki = gkiValues.reduce((a, b) => a < b ? a : b);
        maxGki = gkiValues.reduce((a, b) => a > b ? a : b);
      }

      // Get latest weight
      final weightLogs = healthLogs
          .where((log) => log.weightKg != null)
          .toList();
      if (weightLogs.isNotEmpty) {
        weightLogs.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
        weightKg = weightLogs.first.weightKg;
      }
    }

    // Calculate ketosis status
    final inKetosis = avgGki != null && avgGki < 9 ? 1 : 0;
    final inTherapeuticKetosis = avgGki != null && avgGki < 3 ? 1 : 0;

    // Calculate goal adherence
    final carbGoalMet = dietTotals['total_net_carbs_g']! <= (user.targetNetCarbs) ? 1 : 0;
    final proteinGoalMet = user.targetProtein != null
        ? (dietTotals['total_protein_g']! >= user.targetProtein!) ? 1 : 0
        : 0;
    final fatGoalMet = user.targetFat != null
        ? (dietTotals['total_fat_g']! >= user.targetFat!) ? 1 : 0
        : 0;

    // Get entry counts
    final dietEntries = await _dietEntryDao.getDietEntriesByDate(userId, date);
    final dietEntriesCount = dietEntries.length;
    final healthLogsCount = healthLogs.length;

    // Calculate weight change from start
    double? weightChangeFromStart;
    if (weightKg != null && user.initialWeightKg != null) {
      weightChangeFromStart = weightKg - user.initialWeightKg!;
    }

    // Get symptom averages if available
    // (Would need to query symptoms table if needed)

    final summary = DailySummaryModel(
      userId: userId,
      date: date,
      totalEnergyKcal: dietTotals['total_energy_kcal']!,
      totalProteinG: dietTotals['total_protein_g']!,
      totalFatG: dietTotals['total_fat_g']!,
      totalCarbohydrateG: dietTotals['total_carbohydrate_g']!,
      totalNetCarbsG: dietTotals['total_net_carbs_g']!,
      totalFiberG: dietTotals['total_fiber_g']!,
      totalSodiumMg: dietTotals['total_sodium_mg']!,
      avgGlucoseMgDl: avgGlucose,
      avgKetonesMmolL: avgKetones,
      avgGkiScore: avgGki,
      minGkiScore: minGki,
      maxGkiScore: maxGki,
      inKetosis: inKetosis,
      inTherapeuticKetosis: inTherapeuticKetosis,
      weightKg: weightKg,
      weightChangeFromStartKg: weightChangeFromStart,
      carbGoalMet: carbGoalMet,
      proteinGoalMet: proteinGoalMet,
      fatGoalMet: fatGoalMet,
      dietEntriesCount: dietEntriesCount,
      healthLogsCount: healthLogsCount,
    );

    await _summaryDao.upsertDailySummary(summary);
    return summary;
  }

  /// Calculate summaries for a date range
  Future<List<DailySummaryModel>> calculateSummariesForRange({
    required int userId,
    required String startDate,
    required String endDate,
  }) async {
    final summaries = <DailySummaryModel>[];
    
    // Parse dates and iterate
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);
    
    var current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      final dateStr = current.toIso8601String().split('T')[0];
      final summary = await calculateDailySummary(userId: userId, date: dateStr);
      summaries.add(summary);
      current = current.add(const Duration(days: 1));
    }
    
    return summaries;
  }
}

