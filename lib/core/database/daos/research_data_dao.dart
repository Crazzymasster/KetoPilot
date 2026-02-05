import '../database_service.dart';
import '../models/research_data_model.dart';

/// Data Access Object for tb_research_data table
class ResearchDataDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert research data
  Future<int> insertResearchData(ResearchDataModel data) async {
    final db = await _dbService.database;
    return await db.insert('tb_research_data', data.toMap());
  }

  /// Get research data by ID
  Future<ResearchDataModel?> getResearchDataById(int researchId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_research_data',
      where: 'research_id = ?',
      whereArgs: [researchId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return ResearchDataModel.fromMap(maps.first);
  }

  /// Get research data by anonymous ID
  Future<List<ResearchDataModel>> getResearchDataByAnonymousId(
    String anonymousId,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_research_data',
      where: 'anonymous_id = ?',
      whereArgs: [anonymousId],
      orderBy: 'study_day ASC',
    );
    return maps.map((map) => ResearchDataModel.fromMap(map)).toList();
  }

  /// Get research data by condition
  Future<List<ResearchDataModel>> getResearchDataByCondition(
    String condition,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_research_data',
      where: 'primary_condition = ?',
      whereArgs: [condition],
      orderBy: 'study_day ASC',
    );
    return maps.map((map) => ResearchDataModel.fromMap(map)).toList();
  }

  /// Update research data
  Future<int> updateResearchData(ResearchDataModel data) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_research_data',
      data.toMap(),
      where: 'research_id = ?',
      whereArgs: [data.researchId],
    );
  }

  /// Delete research data
  Future<int> deleteResearchData(int researchId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_research_data',
      where: 'research_id = ?',
      whereArgs: [researchId],
    );
  }
}

