/// Database model for tb_medications table
class MedicationModel {
  final int? medicationId;
  final int userId;
  final String medicationName;
  final String? dosage;
  final String? frequency;
  final String startDate;
  final String? endDate;
  final String? purpose;
  final String? sideEffects;
  final String createdAt;
  final String updatedAt;

  MedicationModel({
    this.medicationId,
    required this.userId,
    required this.medicationName,
    this.dosage,
    this.frequency,
    required this.startDate,
    this.endDate,
    this.purpose,
    this.sideEffects,
    String? createdAt,
    String? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (medicationId != null) 'medication_id': medicationId,
      'user_id': userId,
      'medication_name': medicationName,
      'dosage': dosage,
      'frequency': frequency,
      'start_date': startDate,
      'end_date': endDate,
      'purpose': purpose,
      'side_effects': sideEffects,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    return MedicationModel(
      medicationId: map['medication_id'] as int?,
      userId: map['user_id'] as int,
      medicationName: map['medication_name'] as String,
      dosage: map['dosage'] as String?,
      frequency: map['frequency'] as String?,
      startDate: map['start_date'] as String,
      endDate: map['end_date'] as String?,
      purpose: map['purpose'] as String?,
      sideEffects: map['side_effects'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }
}

