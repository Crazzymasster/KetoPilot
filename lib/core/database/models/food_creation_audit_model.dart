/// Database model for tb_food_creation_audit table
class FoodCreationAuditModel {
  final int? auditId;
  final int userId;
  final int foodId;
  final String createdAt;
  final int isFlagged;
  final String? flagReason;

  FoodCreationAuditModel({
    this.auditId,
    required this.userId,
    required this.foodId,
    String? createdAt,
    this.isFlagged = 0,
    this.flagReason,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (auditId != null) 'audit_id': auditId,
      'user_id': userId,
      'food_id': foodId,
      'created_at': createdAt,
      'is_flagged': isFlagged,
      'flag_reason': flagReason,
    };
  }

  factory FoodCreationAuditModel.fromMap(Map<String, dynamic> map) {
    return FoodCreationAuditModel(
      auditId: map['audit_id'] as int?,
      userId: map['user_id'] as int,
      foodId: map['food_id'] as int,
      createdAt: map['created_at'] as String?,
      isFlagged: map['is_flagged'] as int? ?? 0,
      flagReason: map['flag_reason'] as String?,
    );
  }
}

