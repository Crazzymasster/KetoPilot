/// Database model for tb_photo_uploads table
class PhotoUploadModel {
  final int? photoId;
  final int userId;
  final String filePath;
  final int? fileSizeBytes;
  final String? mimeType;
  final String? detectedFoodIds; // JSON array string
  final double? recognitionConfidence;
  final int? linkedEntryId;
  final String uploadedAt;
  final int synced;

  PhotoUploadModel({
    this.photoId,
    required this.userId,
    required this.filePath,
    this.fileSizeBytes,
    this.mimeType,
    this.detectedFoodIds,
    this.recognitionConfidence,
    this.linkedEntryId,
    String? uploadedAt,
    this.synced = 0,
  }) : uploadedAt = uploadedAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (photoId != null) 'photo_id': photoId,
      'user_id': userId,
      'file_path': filePath,
      'file_size_bytes': fileSizeBytes,
      'mime_type': mimeType,
      'detected_food_ids': detectedFoodIds,
      'recognition_confidence': recognitionConfidence,
      'linked_entry_id': linkedEntryId,
      'uploaded_at': uploadedAt,
      'synced': synced,
    };
  }

  factory PhotoUploadModel.fromMap(Map<String, dynamic> map) {
    return PhotoUploadModel(
      photoId: map['photo_id'] as int?,
      userId: map['user_id'] as int,
      filePath: map['file_path'] as String,
      fileSizeBytes: map['file_size_bytes'] as int?,
      mimeType: map['mime_type'] as String?,
      detectedFoodIds: map['detected_food_ids'] as String?,
      recognitionConfidence: map['recognition_confidence'] as double?,
      linkedEntryId: map['linked_entry_id'] as int?,
      uploadedAt: map['uploaded_at'] as String?,
      synced: map['synced'] as int? ?? 0,
    );
  }
}

