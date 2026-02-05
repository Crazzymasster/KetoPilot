/// Database model for tb_user table
class UserModel {
  final int? userId;
  final String email;
  final String passwordHash;
  final int emailVerified;
  final String? fullName;
  final String? dateOfBirth;
  final String? gender;
  final double? heightCm;
  final double? initialWeightKg;
  final double targetNetCarbs;
  final double? targetProtein;
  final double? targetFat;
  final double? targetCalories;
  final String? ketoStartDate;
  final String? medicalConditions; // JSON string
  final String? goals; // JSON string
  final String? iotDevices; // JSON string
  final int foodCreationCount;
  final String? foodCreationWindowStart;
  final int maxFoodsPerWindow;
  final int windowDurationDays;
  final int researchConsent;
  final int dataSharingConsent;
  final String? anonymousId;
  final String createdAt;
  final String updatedAt;
  final String? lastLogin;

  UserModel({
    this.userId,
    required this.email,
    required this.passwordHash,
    this.emailVerified = 0,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.heightCm,
    this.initialWeightKg,
    this.targetNetCarbs = 20.0,
    this.targetProtein,
    this.targetFat,
    this.targetCalories,
    this.ketoStartDate,
    this.medicalConditions,
    this.goals,
    this.iotDevices,
    this.foodCreationCount = 0,
    this.foodCreationWindowStart,
    this.maxFoodsPerWindow = 50,
    this.windowDurationDays = 21,
    this.researchConsent = 0,
    this.dataSharingConsent = 0,
    this.anonymousId,
    String? createdAt,
    String? updatedAt,
    this.lastLogin,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (userId != null) 'user_id': userId,
      'email': email,
      'password_hash': passwordHash,
      'email_verified': emailVerified,
      'full_name': fullName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'height_cm': heightCm,
      'initial_weight_kg': initialWeightKg,
      'target_net_carbs': targetNetCarbs,
      'target_protein': targetProtein,
      'target_fat': targetFat,
      'target_calories': targetCalories,
      'keto_start_date': ketoStartDate,
      'medical_conditions': medicalConditions,
      'goals': goals,
      'iot_devices': iotDevices,
      'food_creation_count': foodCreationCount,
      'food_creation_window_start': foodCreationWindowStart,
      'max_foods_per_window': maxFoodsPerWindow,
      'window_duration_days': windowDurationDays,
      'research_consent': researchConsent,
      'data_sharing_consent': dataSharingConsent,
      'anonymous_id': anonymousId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'last_login': lastLogin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] as int?,
      email: map['email'] as String,
      passwordHash: map['password_hash'] as String,
      emailVerified: map['email_verified'] as int? ?? 0,
      fullName: map['full_name'] as String?,
      dateOfBirth: map['date_of_birth'] as String?,
      gender: map['gender'] as String?,
      heightCm: map['height_cm'] as double?,
      initialWeightKg: map['initial_weight_kg'] as double?,
      targetNetCarbs: map['target_net_carbs'] as double? ?? 20.0,
      targetProtein: map['target_protein'] as double?,
      targetFat: map['target_fat'] as double?,
      targetCalories: map['target_calories'] as double?,
      ketoStartDate: map['keto_start_date'] as String?,
      medicalConditions: map['medical_conditions'] as String?,
      goals: map['goals'] as String?,
      iotDevices: map['iot_devices'] as String?,
      foodCreationCount: map['food_creation_count'] as int? ?? 0,
      foodCreationWindowStart: map['food_creation_window_start'] as String?,
      maxFoodsPerWindow: map['max_foods_per_window'] as int? ?? 50,
      windowDurationDays: map['window_duration_days'] as int? ?? 21,
      researchConsent: map['research_consent'] as int? ?? 0,
      dataSharingConsent: map['data_sharing_consent'] as int? ?? 0,
      anonymousId: map['anonymous_id'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      lastLogin: map['last_login'] as String?,
    );
  }

  UserModel copyWith({
    int? userId,
    String? email,
    String? passwordHash,
    int? emailVerified,
    String? fullName,
    String? dateOfBirth,
    String? gender,
    double? heightCm,
    double? initialWeightKg,
    double? targetNetCarbs,
    double? targetProtein,
    double? targetFat,
    double? targetCalories,
    String? ketoStartDate,
    String? medicalConditions,
    String? goals,
    String? iotDevices,
    int? foodCreationCount,
    String? foodCreationWindowStart,
    int? maxFoodsPerWindow,
    int? windowDurationDays,
    int? researchConsent,
    int? dataSharingConsent,
    String? anonymousId,
    String? createdAt,
    String? updatedAt,
    String? lastLogin,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      emailVerified: emailVerified ?? this.emailVerified,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      heightCm: heightCm ?? this.heightCm,
      initialWeightKg: initialWeightKg ?? this.initialWeightKg,
      targetNetCarbs: targetNetCarbs ?? this.targetNetCarbs,
      targetProtein: targetProtein ?? this.targetProtein,
      targetFat: targetFat ?? this.targetFat,
      targetCalories: targetCalories ?? this.targetCalories,
      ketoStartDate: ketoStartDate ?? this.ketoStartDate,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      goals: goals ?? this.goals,
      iotDevices: iotDevices ?? this.iotDevices,
      foodCreationCount: foodCreationCount ?? this.foodCreationCount,
      foodCreationWindowStart: foodCreationWindowStart ?? this.foodCreationWindowStart,
      maxFoodsPerWindow: maxFoodsPerWindow ?? this.maxFoodsPerWindow,
      windowDurationDays: windowDurationDays ?? this.windowDurationDays,
      researchConsent: researchConsent ?? this.researchConsent,
      dataSharingConsent: dataSharingConsent ?? this.dataSharingConsent,
      anonymousId: anonymousId ?? this.anonymousId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}

