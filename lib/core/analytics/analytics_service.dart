import 'package:sqflite/sqflite.dart';
import '../database/database_service.dart';
import 'models/weekly_progress_report.dart';
import 'models/food_ketosis_correlation.dart';
import 'models/macro_ratio_analysis.dart';
import 'models/time_to_ketosis.dart';
import 'models/symptom_progression.dart';
import 'models/most_consumed_food.dart';

/// Service for advanced analytics and reporting
class AnalyticsService {
  final DatabaseService _dbService = DatabaseService();

  /// Get weekly progress report
  Future<List<WeeklyProgressReport>> getWeeklyProgressReport({
    required int userId,
    int weeks = 12,
  }) async {
    final db = await _dbService.database;
    final results = await db.rawQuery('''
      SELECT 
        strftime('%Y-W%W', date) as week,
        AVG(total_net_carbs_g) as avg_net_carbs,
        AVG(avg_gki_score) as avg_gki,
        SUM(CASE WHEN carb_goal_met = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) as adherence_rate,
        AVG(weight_kg) as avg_weight,
        MIN(weight_kg) as min_weight,
        MAX(weight_kg) as max_weight,
        AVG(avg_energy_level) as avg_energy,
        AVG(avg_mental_clarity) as avg_clarity
      FROM tb_daily_summary
      WHERE user_id = ?
        AND date >= date('now', '-$weeks weeks')
      GROUP BY week
      ORDER BY week
    ''', [userId]);

    return results.map((map) => WeeklyProgressReport.fromMap(map)).toList();
  }

  /// Get food correlation with ketosis
  Future<List<FoodKetosisCorrelation>> getFoodKetosisCorrelation({
    required int userId,
    int minObservations = 3,
  }) async {
    final db = await _dbService.database;
    final results = await db.rawQuery('''
      WITH food_gki_pairs AS (
        SELECT 
          de.food_id,
          f.food_description,
          de.date,
          de.recorded_at,
          de.total_net_carbs_g,
          hl.gki_score,
          hl.recorded_at as gki_time,
          (julianday(hl.recorded_at) - julianday(de.recorded_at)) * 24 as hours_after_meal
        FROM tb_diet_entries de
        JOIN tb_food f ON de.food_id = f.food_id
        JOIN tb_health_log hl ON de.user_id = hl.user_id AND de.date = hl.date
        WHERE de.user_id = ?
          AND (julianday(hl.recorded_at) - julianday(de.recorded_at)) * 24 BETWEEN 0 AND 4
      )
      SELECT 
        food_id,
        food_description,
        COUNT(*) as consumption_count,
        AVG(gki_score) as avg_gki_after,
        AVG(total_net_carbs_g) as avg_net_carbs
      FROM food_gki_pairs
      GROUP BY food_id, food_description
      HAVING consumption_count >= ?
      ORDER BY avg_gki_after ASC
    ''', [userId, minObservations]);

    return results.map((map) => FoodKetosisCorrelation.fromMap(map)).toList();
  }

  /// Get macronutrient ratio analysis
  Future<List<MacroRatioAnalysis>> getMacroRatioAnalysis({
    required int userId,
    int days = 90,
  }) async {
    final db = await _dbService.database;
    final results = await db.rawQuery('''
      WITH daily_ratios AS (
        SELECT 
          date,
          total_net_carbs_g,
          total_protein_g,
          total_fat_g,
          total_energy_kcal,
          (total_net_carbs_g * 4) * 100.0 / NULLIF(total_energy_kcal, 0) as carb_percentage,
          (total_protein_g * 4) * 100.0 / NULLIF(total_energy_kcal, 0) as protein_percentage,
          (total_fat_g * 9) * 100.0 / NULLIF(total_energy_kcal, 0) as fat_percentage,
          avg_gki_score,
          avg_energy_level,
          weight_kg
        FROM tb_daily_summary
        WHERE user_id = ?
          AND date >= date('now', '-$days days')
      )
      SELECT 
        CASE 
          WHEN carb_percentage < 5 THEN '0-5%'
          WHEN carb_percentage < 10 THEN '5-10%'
          ELSE '10%+'
        END as carb_ratio_bucket,
        COUNT(*) as days_count,
        AVG(avg_gki_score) as avg_gki,
        AVG(avg_energy_level) as avg_energy,
        AVG(weight_kg) as avg_weight
      FROM daily_ratios
      GROUP BY carb_ratio_bucket
      ORDER BY carb_ratio_bucket
    ''', [userId]);

    return results.map((map) => MacroRatioAnalysis.fromMap(map)).toList();
  }

  /// Get time-to-ketosis analysis
  Future<List<TimeToKetosis>> getTimeToKetosis(int userId) async {
    final db = await _dbService.database;
    final results = await db.rawQuery('''
      SELECT 
        CAST(julianday(ds.date) - julianday(u.keto_start_date) AS INTEGER) as day_number,
        ds.avg_gki_score,
        ds.in_ketosis,
        ds.in_therapeutic_ketosis,
        ds.total_net_carbs_g,
        ds.avg_energy_level
      FROM tb_user u
      JOIN tb_daily_summary ds ON u.user_id = ds.user_id
      WHERE u.user_id = ?
        AND ds.avg_gki_score IS NOT NULL
        AND u.keto_start_date IS NOT NULL
      ORDER BY day_number
    ''', [userId]);

    return results.map((map) => TimeToKetosis.fromMap(map)).toList();
  }

  /// Get symptom progression over time
  Future<List<SymptomProgression>> getSymptomProgression(int userId) async {
    final db = await _dbService.database;
    final results = await db.rawQuery('''
      SELECT 
        strftime('%Y-%m', s.date) as month,
        AVG(s.headache_severity) as avg_headache,
        AVG(s.fatigue_severity) as avg_fatigue,
        AVG(s.brain_fog_severity) as avg_brain_fog,
        AVG(s.energy_level) as avg_energy,
        AVG(s.mental_clarity) as avg_clarity,
        AVG(s.mood_rating) as avg_mood,
        AVG(ds.avg_gki_score) as avg_gki
      FROM tb_symptoms s
      JOIN tb_daily_summary ds ON s.user_id = ds.user_id AND s.date = ds.date
      WHERE s.user_id = ?
      GROUP BY month
      ORDER BY month
    ''', [userId]);

    return results.map((map) => SymptomProgression.fromMap(map)).toList();
  }

  /// Get most consumed keto foods
  Future<List<MostConsumedFood>> getMostConsumedKetoFoods({
    required int userId,
    int limit = 20,
  }) async {
    final db = await _dbService.database;
    final results = await db.rawQuery('''
      SELECT 
        f.food_id,
        f.food_description,
        COUNT(de.entry_id) as times_consumed,
        AVG(de.total_net_carbs_g) as avg_net_carbs_per_serving,
        SUM(de.total_net_carbs_g) as total_net_carbs_consumed,
        MIN(de.recorded_at) as first_consumed,
        MAX(de.recorded_at) as last_consumed
      FROM tb_diet_entries de
      JOIN tb_food f ON de.food_id = f.food_id
      WHERE de.user_id = ?
        AND f.is_keto_friendly = 1
      GROUP BY f.food_id, f.food_description
      ORDER BY times_consumed DESC
      LIMIT ?
    ''', [userId, limit]);

    return results.map((map) => MostConsumedFood.fromMap(map)).toList();
  }
}

