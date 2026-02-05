/// Database model for tb_medication_logs table
class MedicationLogModel {
  final int? logId;
  final int medicationId;
  final int userId;
  final String scheduledAt;
  final String? takenAt;
  final int taken;
  final String? skippedReason;
  final String createdAt;

  MedicationLogModel({
    this.logId,
    required this.medicationId,
    required this.userId,
    required this.scheduledAt,
    this.takenAt,
    this.taken = 0,
    this.skippedReason,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (logId != null) 'log_id': logId,
      'medication_id': medicationId,
      'user_id': userId,
      'scheduled_at': scheduledAt,
      'taken_at': takenAt,
      'taken': taken,
      'skipped_reason': skippedReason,
      'created_at': createdAt,
    };
  }

  factory MedicationLogModel.fromMap(Map<String, dynamic> map) {
    return MedicationLogModel(
      logId: map['log_id'] as int?,
      medicationId: map['medication_id'] as int,
      userId: map['user_id'] as int,
      scheduledAt: map['scheduled_at'] as String,
      takenAt: map['taken_at'] as String?,
      taken: map['taken'] as int? ?? 0,
      skippedReason: map['skipped_reason'] as String?,
      createdAt: map['created_at'] as String?,
    );
  }
}

