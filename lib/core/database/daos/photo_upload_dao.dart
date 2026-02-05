import '../database_service.dart';
import '../models/photo_upload_model.dart';

/// Data Access Object for tb_photo_uploads table
class PhotoUploadDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert a new photo upload
  Future<int> insertPhotoUpload(PhotoUploadModel photo) async {
    final db = await _dbService.database;
    return await db.insert('tb_photo_uploads', photo.toMap());
  }

  /// Get photo by ID
  Future<PhotoUploadModel?> getPhotoById(int photoId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_photo_uploads',
      where: 'photo_id = ?',
      whereArgs: [photoId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return PhotoUploadModel.fromMap(maps.first);
  }

  /// Get photos for a user
  Future<List<PhotoUploadModel>> getPhotosByUserId(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_photo_uploads',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'uploaded_at DESC',
    );
    return maps.map((map) => PhotoUploadModel.fromMap(map)).toList();
  }

  /// Get photos linked to a diet entry
  Future<List<PhotoUploadModel>> getPhotosByEntryId(int entryId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_photo_uploads',
      where: 'linked_entry_id = ?',
      whereArgs: [entryId],
      orderBy: 'uploaded_at DESC',
    );
    return maps.map((map) => PhotoUploadModel.fromMap(map)).toList();
  }

  /// Update photo upload (e.g., after AI recognition)
  Future<int> updatePhotoUpload(PhotoUploadModel photo) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_photo_uploads',
      photo.toMap(),
      where: 'photo_id = ?',
      whereArgs: [photo.photoId],
    );
  }

  /// Link photo to a diet entry
  Future<int> linkPhotoToEntry(int photoId, int entryId) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_photo_uploads',
      {'linked_entry_id': entryId},
      where: 'photo_id = ?',
      whereArgs: [photoId],
    );
  }

  /// Update detected foods from AI recognition
  Future<int> updateDetectedFoods(
    int photoId,
    List<int> foodIds,
    double confidence,
  ) async {
    final db = await _dbService.database;
    final foodIdsJson = foodIds.toString(); // Simple JSON array representation
    return await db.update(
      'tb_photo_uploads',
      {
        'detected_food_ids': foodIdsJson,
        'recognition_confidence': confidence,
      },
      where: 'photo_id = ?',
      whereArgs: [photoId],
    );
  }

  /// Get unsynced photos
  Future<List<PhotoUploadModel>> getUnsyncedPhotos(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_photo_uploads',
      where: 'user_id = ? AND synced = 0',
      whereArgs: [userId],
      orderBy: 'uploaded_at ASC',
    );
    return maps.map((map) => PhotoUploadModel.fromMap(map)).toList();
  }

  /// Mark photos as synced
  Future<int> markAsSynced(List<int> photoIds) async {
    if (photoIds.isEmpty) return 0;
    final db = await _dbService.database;
    final placeholders = photoIds.map((_) => '?').join(',');
    return await db.rawUpdate(
      'UPDATE tb_photo_uploads SET synced = 1 WHERE photo_id IN ($placeholders)',
      photoIds,
    );
  }

  /// Delete photo upload
  Future<int> deletePhotoUpload(int photoId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_photo_uploads',
      where: 'photo_id = ?',
      whereArgs: [photoId],
    );
  }
}

