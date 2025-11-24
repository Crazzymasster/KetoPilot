// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailVerifiedMeta =
      const VerificationMeta('emailVerified');
  @override
  late final GeneratedColumn<int> emailVerified = GeneratedColumn<int>(
      'email_verified', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _heightCmMeta =
      const VerificationMeta('heightCm');
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
      'height_cm', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _initialWeightKgMeta =
      const VerificationMeta('initialWeightKg');
  @override
  late final GeneratedColumn<double> initialWeightKg = GeneratedColumn<double>(
      'initial_weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetNetCarbsMeta =
      const VerificationMeta('targetNetCarbs');
  @override
  late final GeneratedColumn<double> targetNetCarbs = GeneratedColumn<double>(
      'target_net_carbs', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(20.0));
  static const VerificationMeta _targetProteinMeta =
      const VerificationMeta('targetProtein');
  @override
  late final GeneratedColumn<double> targetProtein = GeneratedColumn<double>(
      'target_protein', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetFatMeta =
      const VerificationMeta('targetFat');
  @override
  late final GeneratedColumn<double> targetFat = GeneratedColumn<double>(
      'target_fat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetCaloriesMeta =
      const VerificationMeta('targetCalories');
  @override
  late final GeneratedColumn<double> targetCalories = GeneratedColumn<double>(
      'target_calories', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _ketoStartDateMeta =
      const VerificationMeta('ketoStartDate');
  @override
  late final GeneratedColumn<String> ketoStartDate = GeneratedColumn<String>(
      'keto_start_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _medicalConditionsMeta =
      const VerificationMeta('medicalConditions');
  @override
  late final GeneratedColumn<String> medicalConditions =
      GeneratedColumn<String>('medical_conditions', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _goalsMeta = const VerificationMeta('goals');
  @override
  late final GeneratedColumn<String> goals = GeneratedColumn<String>(
      'goals', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iotDevicesMeta =
      const VerificationMeta('iotDevices');
  @override
  late final GeneratedColumn<String> iotDevices = GeneratedColumn<String>(
      'iot_devices', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _foodCreationCountMeta =
      const VerificationMeta('foodCreationCount');
  @override
  late final GeneratedColumn<int> foodCreationCount = GeneratedColumn<int>(
      'food_creation_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _foodCreationWindowStartMeta =
      const VerificationMeta('foodCreationWindowStart');
  @override
  late final GeneratedColumn<String> foodCreationWindowStart =
      GeneratedColumn<String>('food_creation_window_start', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maxFoodsPerWindowMeta =
      const VerificationMeta('maxFoodsPerWindow');
  @override
  late final GeneratedColumn<int> maxFoodsPerWindow = GeneratedColumn<int>(
      'max_foods_per_window', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(50));
  static const VerificationMeta _windowDurationDaysMeta =
      const VerificationMeta('windowDurationDays');
  @override
  late final GeneratedColumn<int> windowDurationDays = GeneratedColumn<int>(
      'window_duration_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(21));
  static const VerificationMeta _researchConsentMeta =
      const VerificationMeta('researchConsent');
  @override
  late final GeneratedColumn<int> researchConsent = GeneratedColumn<int>(
      'research_consent', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dataSharingConsentMeta =
      const VerificationMeta('dataSharingConsent');
  @override
  late final GeneratedColumn<int> dataSharingConsent = GeneratedColumn<int>(
      'data_sharing_consent', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _anonymousIdMeta =
      const VerificationMeta('anonymousId');
  @override
  late final GeneratedColumn<String> anonymousId = GeneratedColumn<String>(
      'anonymous_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  static const VerificationMeta _lastLoginMeta =
      const VerificationMeta('lastLogin');
  @override
  late final GeneratedColumn<String> lastLogin = GeneratedColumn<String>(
      'last_login', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        email,
        passwordHash,
        emailVerified,
        fullName,
        dateOfBirth,
        gender,
        heightCm,
        initialWeightKg,
        targetNetCarbs,
        targetProtein,
        targetFat,
        targetCalories,
        ketoStartDate,
        medicalConditions,
        goals,
        iotDevices,
        foodCreationCount,
        foodCreationWindowStart,
        maxFoodsPerWindow,
        windowDurationDays,
        researchConsent,
        dataSharingConsent,
        anonymousId,
        createdAt,
        updatedAt,
        lastLogin
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('email_verified')) {
      context.handle(
          _emailVerifiedMeta,
          emailVerified.isAcceptableOrUnknown(
              data['email_verified']!, _emailVerifiedMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('height_cm')) {
      context.handle(_heightCmMeta,
          heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta));
    }
    if (data.containsKey('initial_weight_kg')) {
      context.handle(
          _initialWeightKgMeta,
          initialWeightKg.isAcceptableOrUnknown(
              data['initial_weight_kg']!, _initialWeightKgMeta));
    }
    if (data.containsKey('target_net_carbs')) {
      context.handle(
          _targetNetCarbsMeta,
          targetNetCarbs.isAcceptableOrUnknown(
              data['target_net_carbs']!, _targetNetCarbsMeta));
    }
    if (data.containsKey('target_protein')) {
      context.handle(
          _targetProteinMeta,
          targetProtein.isAcceptableOrUnknown(
              data['target_protein']!, _targetProteinMeta));
    }
    if (data.containsKey('target_fat')) {
      context.handle(_targetFatMeta,
          targetFat.isAcceptableOrUnknown(data['target_fat']!, _targetFatMeta));
    }
    if (data.containsKey('target_calories')) {
      context.handle(
          _targetCaloriesMeta,
          targetCalories.isAcceptableOrUnknown(
              data['target_calories']!, _targetCaloriesMeta));
    }
    if (data.containsKey('keto_start_date')) {
      context.handle(
          _ketoStartDateMeta,
          ketoStartDate.isAcceptableOrUnknown(
              data['keto_start_date']!, _ketoStartDateMeta));
    }
    if (data.containsKey('medical_conditions')) {
      context.handle(
          _medicalConditionsMeta,
          medicalConditions.isAcceptableOrUnknown(
              data['medical_conditions']!, _medicalConditionsMeta));
    }
    if (data.containsKey('goals')) {
      context.handle(
          _goalsMeta, goals.isAcceptableOrUnknown(data['goals']!, _goalsMeta));
    }
    if (data.containsKey('iot_devices')) {
      context.handle(
          _iotDevicesMeta,
          iotDevices.isAcceptableOrUnknown(
              data['iot_devices']!, _iotDevicesMeta));
    }
    if (data.containsKey('food_creation_count')) {
      context.handle(
          _foodCreationCountMeta,
          foodCreationCount.isAcceptableOrUnknown(
              data['food_creation_count']!, _foodCreationCountMeta));
    }
    if (data.containsKey('food_creation_window_start')) {
      context.handle(
          _foodCreationWindowStartMeta,
          foodCreationWindowStart.isAcceptableOrUnknown(
              data['food_creation_window_start']!,
              _foodCreationWindowStartMeta));
    }
    if (data.containsKey('max_foods_per_window')) {
      context.handle(
          _maxFoodsPerWindowMeta,
          maxFoodsPerWindow.isAcceptableOrUnknown(
              data['max_foods_per_window']!, _maxFoodsPerWindowMeta));
    }
    if (data.containsKey('window_duration_days')) {
      context.handle(
          _windowDurationDaysMeta,
          windowDurationDays.isAcceptableOrUnknown(
              data['window_duration_days']!, _windowDurationDaysMeta));
    }
    if (data.containsKey('research_consent')) {
      context.handle(
          _researchConsentMeta,
          researchConsent.isAcceptableOrUnknown(
              data['research_consent']!, _researchConsentMeta));
    }
    if (data.containsKey('data_sharing_consent')) {
      context.handle(
          _dataSharingConsentMeta,
          dataSharingConsent.isAcceptableOrUnknown(
              data['data_sharing_consent']!, _dataSharingConsentMeta));
    }
    if (data.containsKey('anonymous_id')) {
      context.handle(
          _anonymousIdMeta,
          anonymousId.isAcceptableOrUnknown(
              data['anonymous_id']!, _anonymousIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('last_login')) {
      context.handle(_lastLoginMeta,
          lastLogin.isAcceptableOrUnknown(data['last_login']!, _lastLoginMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      emailVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}email_verified'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name']),
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_of_birth']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      heightCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height_cm']),
      initialWeightKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}initial_weight_kg']),
      targetNetCarbs: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}target_net_carbs'])!,
      targetProtein: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_protein']),
      targetFat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_fat']),
      targetCalories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_calories']),
      ketoStartDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}keto_start_date']),
      medicalConditions: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}medical_conditions']),
      goals: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goals']),
      iotDevices: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iot_devices']),
      foodCreationCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}food_creation_count'])!,
      foodCreationWindowStart: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}food_creation_window_start']),
      maxFoodsPerWindow: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}max_foods_per_window'])!,
      windowDurationDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}window_duration_days'])!,
      researchConsent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}research_consent'])!,
      dataSharingConsent: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}data_sharing_consent'])!,
      anonymousId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}anonymous_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      lastLogin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_login']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int userId;
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
  final String? medicalConditions;
  final String? goals;
  final String? iotDevices;
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
  const User(
      {required this.userId,
      required this.email,
      required this.passwordHash,
      required this.emailVerified,
      this.fullName,
      this.dateOfBirth,
      this.gender,
      this.heightCm,
      this.initialWeightKg,
      required this.targetNetCarbs,
      this.targetProtein,
      this.targetFat,
      this.targetCalories,
      this.ketoStartDate,
      this.medicalConditions,
      this.goals,
      this.iotDevices,
      required this.foodCreationCount,
      this.foodCreationWindowStart,
      required this.maxFoodsPerWindow,
      required this.windowDurationDays,
      required this.researchConsent,
      required this.dataSharingConsent,
      this.anonymousId,
      required this.createdAt,
      required this.updatedAt,
      this.lastLogin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['email_verified'] = Variable<int>(emailVerified);
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || initialWeightKg != null) {
      map['initial_weight_kg'] = Variable<double>(initialWeightKg);
    }
    map['target_net_carbs'] = Variable<double>(targetNetCarbs);
    if (!nullToAbsent || targetProtein != null) {
      map['target_protein'] = Variable<double>(targetProtein);
    }
    if (!nullToAbsent || targetFat != null) {
      map['target_fat'] = Variable<double>(targetFat);
    }
    if (!nullToAbsent || targetCalories != null) {
      map['target_calories'] = Variable<double>(targetCalories);
    }
    if (!nullToAbsent || ketoStartDate != null) {
      map['keto_start_date'] = Variable<String>(ketoStartDate);
    }
    if (!nullToAbsent || medicalConditions != null) {
      map['medical_conditions'] = Variable<String>(medicalConditions);
    }
    if (!nullToAbsent || goals != null) {
      map['goals'] = Variable<String>(goals);
    }
    if (!nullToAbsent || iotDevices != null) {
      map['iot_devices'] = Variable<String>(iotDevices);
    }
    map['food_creation_count'] = Variable<int>(foodCreationCount);
    if (!nullToAbsent || foodCreationWindowStart != null) {
      map['food_creation_window_start'] =
          Variable<String>(foodCreationWindowStart);
    }
    map['max_foods_per_window'] = Variable<int>(maxFoodsPerWindow);
    map['window_duration_days'] = Variable<int>(windowDurationDays);
    map['research_consent'] = Variable<int>(researchConsent);
    map['data_sharing_consent'] = Variable<int>(dataSharingConsent);
    if (!nullToAbsent || anonymousId != null) {
      map['anonymous_id'] = Variable<String>(anonymousId);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<String>(lastLogin);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      userId: Value(userId),
      email: Value(email),
      passwordHash: Value(passwordHash),
      emailVerified: Value(emailVerified),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      initialWeightKg: initialWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(initialWeightKg),
      targetNetCarbs: Value(targetNetCarbs),
      targetProtein: targetProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(targetProtein),
      targetFat: targetFat == null && nullToAbsent
          ? const Value.absent()
          : Value(targetFat),
      targetCalories: targetCalories == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCalories),
      ketoStartDate: ketoStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(ketoStartDate),
      medicalConditions: medicalConditions == null && nullToAbsent
          ? const Value.absent()
          : Value(medicalConditions),
      goals:
          goals == null && nullToAbsent ? const Value.absent() : Value(goals),
      iotDevices: iotDevices == null && nullToAbsent
          ? const Value.absent()
          : Value(iotDevices),
      foodCreationCount: Value(foodCreationCount),
      foodCreationWindowStart: foodCreationWindowStart == null && nullToAbsent
          ? const Value.absent()
          : Value(foodCreationWindowStart),
      maxFoodsPerWindow: Value(maxFoodsPerWindow),
      windowDurationDays: Value(windowDurationDays),
      researchConsent: Value(researchConsent),
      dataSharingConsent: Value(dataSharingConsent),
      anonymousId: anonymousId == null && nullToAbsent
          ? const Value.absent()
          : Value(anonymousId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastLogin: lastLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLogin),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      userId: serializer.fromJson<int>(json['userId']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      emailVerified: serializer.fromJson<int>(json['emailVerified']),
      fullName: serializer.fromJson<String?>(json['fullName']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      gender: serializer.fromJson<String?>(json['gender']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      initialWeightKg: serializer.fromJson<double?>(json['initialWeightKg']),
      targetNetCarbs: serializer.fromJson<double>(json['targetNetCarbs']),
      targetProtein: serializer.fromJson<double?>(json['targetProtein']),
      targetFat: serializer.fromJson<double?>(json['targetFat']),
      targetCalories: serializer.fromJson<double?>(json['targetCalories']),
      ketoStartDate: serializer.fromJson<String?>(json['ketoStartDate']),
      medicalConditions:
          serializer.fromJson<String?>(json['medicalConditions']),
      goals: serializer.fromJson<String?>(json['goals']),
      iotDevices: serializer.fromJson<String?>(json['iotDevices']),
      foodCreationCount: serializer.fromJson<int>(json['foodCreationCount']),
      foodCreationWindowStart:
          serializer.fromJson<String?>(json['foodCreationWindowStart']),
      maxFoodsPerWindow: serializer.fromJson<int>(json['maxFoodsPerWindow']),
      windowDurationDays: serializer.fromJson<int>(json['windowDurationDays']),
      researchConsent: serializer.fromJson<int>(json['researchConsent']),
      dataSharingConsent: serializer.fromJson<int>(json['dataSharingConsent']),
      anonymousId: serializer.fromJson<String?>(json['anonymousId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      lastLogin: serializer.fromJson<String?>(json['lastLogin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int>(userId),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'emailVerified': serializer.toJson<int>(emailVerified),
      'fullName': serializer.toJson<String?>(fullName),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'gender': serializer.toJson<String?>(gender),
      'heightCm': serializer.toJson<double?>(heightCm),
      'initialWeightKg': serializer.toJson<double?>(initialWeightKg),
      'targetNetCarbs': serializer.toJson<double>(targetNetCarbs),
      'targetProtein': serializer.toJson<double?>(targetProtein),
      'targetFat': serializer.toJson<double?>(targetFat),
      'targetCalories': serializer.toJson<double?>(targetCalories),
      'ketoStartDate': serializer.toJson<String?>(ketoStartDate),
      'medicalConditions': serializer.toJson<String?>(medicalConditions),
      'goals': serializer.toJson<String?>(goals),
      'iotDevices': serializer.toJson<String?>(iotDevices),
      'foodCreationCount': serializer.toJson<int>(foodCreationCount),
      'foodCreationWindowStart':
          serializer.toJson<String?>(foodCreationWindowStart),
      'maxFoodsPerWindow': serializer.toJson<int>(maxFoodsPerWindow),
      'windowDurationDays': serializer.toJson<int>(windowDurationDays),
      'researchConsent': serializer.toJson<int>(researchConsent),
      'dataSharingConsent': serializer.toJson<int>(dataSharingConsent),
      'anonymousId': serializer.toJson<String?>(anonymousId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'lastLogin': serializer.toJson<String?>(lastLogin),
    };
  }

  User copyWith(
          {int? userId,
          String? email,
          String? passwordHash,
          int? emailVerified,
          Value<String?> fullName = const Value.absent(),
          Value<String?> dateOfBirth = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<double?> heightCm = const Value.absent(),
          Value<double?> initialWeightKg = const Value.absent(),
          double? targetNetCarbs,
          Value<double?> targetProtein = const Value.absent(),
          Value<double?> targetFat = const Value.absent(),
          Value<double?> targetCalories = const Value.absent(),
          Value<String?> ketoStartDate = const Value.absent(),
          Value<String?> medicalConditions = const Value.absent(),
          Value<String?> goals = const Value.absent(),
          Value<String?> iotDevices = const Value.absent(),
          int? foodCreationCount,
          Value<String?> foodCreationWindowStart = const Value.absent(),
          int? maxFoodsPerWindow,
          int? windowDurationDays,
          int? researchConsent,
          int? dataSharingConsent,
          Value<String?> anonymousId = const Value.absent(),
          String? createdAt,
          String? updatedAt,
          Value<String?> lastLogin = const Value.absent()}) =>
      User(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        emailVerified: emailVerified ?? this.emailVerified,
        fullName: fullName.present ? fullName.value : this.fullName,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        gender: gender.present ? gender.value : this.gender,
        heightCm: heightCm.present ? heightCm.value : this.heightCm,
        initialWeightKg: initialWeightKg.present
            ? initialWeightKg.value
            : this.initialWeightKg,
        targetNetCarbs: targetNetCarbs ?? this.targetNetCarbs,
        targetProtein:
            targetProtein.present ? targetProtein.value : this.targetProtein,
        targetFat: targetFat.present ? targetFat.value : this.targetFat,
        targetCalories:
            targetCalories.present ? targetCalories.value : this.targetCalories,
        ketoStartDate:
            ketoStartDate.present ? ketoStartDate.value : this.ketoStartDate,
        medicalConditions: medicalConditions.present
            ? medicalConditions.value
            : this.medicalConditions,
        goals: goals.present ? goals.value : this.goals,
        iotDevices: iotDevices.present ? iotDevices.value : this.iotDevices,
        foodCreationCount: foodCreationCount ?? this.foodCreationCount,
        foodCreationWindowStart: foodCreationWindowStart.present
            ? foodCreationWindowStart.value
            : this.foodCreationWindowStart,
        maxFoodsPerWindow: maxFoodsPerWindow ?? this.maxFoodsPerWindow,
        windowDurationDays: windowDurationDays ?? this.windowDurationDays,
        researchConsent: researchConsent ?? this.researchConsent,
        dataSharingConsent: dataSharingConsent ?? this.dataSharingConsent,
        anonymousId: anonymousId.present ? anonymousId.value : this.anonymousId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastLogin: lastLogin.present ? lastLogin.value : this.lastLogin,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      userId: data.userId.present ? data.userId.value : this.userId,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      emailVerified: data.emailVerified.present
          ? data.emailVerified.value
          : this.emailVerified,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      gender: data.gender.present ? data.gender.value : this.gender,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      initialWeightKg: data.initialWeightKg.present
          ? data.initialWeightKg.value
          : this.initialWeightKg,
      targetNetCarbs: data.targetNetCarbs.present
          ? data.targetNetCarbs.value
          : this.targetNetCarbs,
      targetProtein: data.targetProtein.present
          ? data.targetProtein.value
          : this.targetProtein,
      targetFat: data.targetFat.present ? data.targetFat.value : this.targetFat,
      targetCalories: data.targetCalories.present
          ? data.targetCalories.value
          : this.targetCalories,
      ketoStartDate: data.ketoStartDate.present
          ? data.ketoStartDate.value
          : this.ketoStartDate,
      medicalConditions: data.medicalConditions.present
          ? data.medicalConditions.value
          : this.medicalConditions,
      goals: data.goals.present ? data.goals.value : this.goals,
      iotDevices:
          data.iotDevices.present ? data.iotDevices.value : this.iotDevices,
      foodCreationCount: data.foodCreationCount.present
          ? data.foodCreationCount.value
          : this.foodCreationCount,
      foodCreationWindowStart: data.foodCreationWindowStart.present
          ? data.foodCreationWindowStart.value
          : this.foodCreationWindowStart,
      maxFoodsPerWindow: data.maxFoodsPerWindow.present
          ? data.maxFoodsPerWindow.value
          : this.maxFoodsPerWindow,
      windowDurationDays: data.windowDurationDays.present
          ? data.windowDurationDays.value
          : this.windowDurationDays,
      researchConsent: data.researchConsent.present
          ? data.researchConsent.value
          : this.researchConsent,
      dataSharingConsent: data.dataSharingConsent.present
          ? data.dataSharingConsent.value
          : this.dataSharingConsent,
      anonymousId:
          data.anonymousId.present ? data.anonymousId.value : this.anonymousId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastLogin: data.lastLogin.present ? data.lastLogin.value : this.lastLogin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('emailVerified: $emailVerified, ')
          ..write('fullName: $fullName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('heightCm: $heightCm, ')
          ..write('initialWeightKg: $initialWeightKg, ')
          ..write('targetNetCarbs: $targetNetCarbs, ')
          ..write('targetProtein: $targetProtein, ')
          ..write('targetFat: $targetFat, ')
          ..write('targetCalories: $targetCalories, ')
          ..write('ketoStartDate: $ketoStartDate, ')
          ..write('medicalConditions: $medicalConditions, ')
          ..write('goals: $goals, ')
          ..write('iotDevices: $iotDevices, ')
          ..write('foodCreationCount: $foodCreationCount, ')
          ..write('foodCreationWindowStart: $foodCreationWindowStart, ')
          ..write('maxFoodsPerWindow: $maxFoodsPerWindow, ')
          ..write('windowDurationDays: $windowDurationDays, ')
          ..write('researchConsent: $researchConsent, ')
          ..write('dataSharingConsent: $dataSharingConsent, ')
          ..write('anonymousId: $anonymousId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastLogin: $lastLogin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        userId,
        email,
        passwordHash,
        emailVerified,
        fullName,
        dateOfBirth,
        gender,
        heightCm,
        initialWeightKg,
        targetNetCarbs,
        targetProtein,
        targetFat,
        targetCalories,
        ketoStartDate,
        medicalConditions,
        goals,
        iotDevices,
        foodCreationCount,
        foodCreationWindowStart,
        maxFoodsPerWindow,
        windowDurationDays,
        researchConsent,
        dataSharingConsent,
        anonymousId,
        createdAt,
        updatedAt,
        lastLogin
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.userId == this.userId &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.emailVerified == this.emailVerified &&
          other.fullName == this.fullName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.gender == this.gender &&
          other.heightCm == this.heightCm &&
          other.initialWeightKg == this.initialWeightKg &&
          other.targetNetCarbs == this.targetNetCarbs &&
          other.targetProtein == this.targetProtein &&
          other.targetFat == this.targetFat &&
          other.targetCalories == this.targetCalories &&
          other.ketoStartDate == this.ketoStartDate &&
          other.medicalConditions == this.medicalConditions &&
          other.goals == this.goals &&
          other.iotDevices == this.iotDevices &&
          other.foodCreationCount == this.foodCreationCount &&
          other.foodCreationWindowStart == this.foodCreationWindowStart &&
          other.maxFoodsPerWindow == this.maxFoodsPerWindow &&
          other.windowDurationDays == this.windowDurationDays &&
          other.researchConsent == this.researchConsent &&
          other.dataSharingConsent == this.dataSharingConsent &&
          other.anonymousId == this.anonymousId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastLogin == this.lastLogin);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> userId;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<int> emailVerified;
  final Value<String?> fullName;
  final Value<String?> dateOfBirth;
  final Value<String?> gender;
  final Value<double?> heightCm;
  final Value<double?> initialWeightKg;
  final Value<double> targetNetCarbs;
  final Value<double?> targetProtein;
  final Value<double?> targetFat;
  final Value<double?> targetCalories;
  final Value<String?> ketoStartDate;
  final Value<String?> medicalConditions;
  final Value<String?> goals;
  final Value<String?> iotDevices;
  final Value<int> foodCreationCount;
  final Value<String?> foodCreationWindowStart;
  final Value<int> maxFoodsPerWindow;
  final Value<int> windowDurationDays;
  final Value<int> researchConsent;
  final Value<int> dataSharingConsent;
  final Value<String?> anonymousId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> lastLogin;
  const UsersCompanion({
    this.userId = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.emailVerified = const Value.absent(),
    this.fullName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.initialWeightKg = const Value.absent(),
    this.targetNetCarbs = const Value.absent(),
    this.targetProtein = const Value.absent(),
    this.targetFat = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.ketoStartDate = const Value.absent(),
    this.medicalConditions = const Value.absent(),
    this.goals = const Value.absent(),
    this.iotDevices = const Value.absent(),
    this.foodCreationCount = const Value.absent(),
    this.foodCreationWindowStart = const Value.absent(),
    this.maxFoodsPerWindow = const Value.absent(),
    this.windowDurationDays = const Value.absent(),
    this.researchConsent = const Value.absent(),
    this.dataSharingConsent = const Value.absent(),
    this.anonymousId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastLogin = const Value.absent(),
  });
  UsersCompanion.insert({
    this.userId = const Value.absent(),
    required String email,
    required String passwordHash,
    this.emailVerified = const Value.absent(),
    this.fullName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.initialWeightKg = const Value.absent(),
    this.targetNetCarbs = const Value.absent(),
    this.targetProtein = const Value.absent(),
    this.targetFat = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.ketoStartDate = const Value.absent(),
    this.medicalConditions = const Value.absent(),
    this.goals = const Value.absent(),
    this.iotDevices = const Value.absent(),
    this.foodCreationCount = const Value.absent(),
    this.foodCreationWindowStart = const Value.absent(),
    this.maxFoodsPerWindow = const Value.absent(),
    this.windowDurationDays = const Value.absent(),
    this.researchConsent = const Value.absent(),
    this.dataSharingConsent = const Value.absent(),
    this.anonymousId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastLogin = const Value.absent(),
  })  : email = Value(email),
        passwordHash = Value(passwordHash);
  static Insertable<User> custom({
    Expression<int>? userId,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<int>? emailVerified,
    Expression<String>? fullName,
    Expression<String>? dateOfBirth,
    Expression<String>? gender,
    Expression<double>? heightCm,
    Expression<double>? initialWeightKg,
    Expression<double>? targetNetCarbs,
    Expression<double>? targetProtein,
    Expression<double>? targetFat,
    Expression<double>? targetCalories,
    Expression<String>? ketoStartDate,
    Expression<String>? medicalConditions,
    Expression<String>? goals,
    Expression<String>? iotDevices,
    Expression<int>? foodCreationCount,
    Expression<String>? foodCreationWindowStart,
    Expression<int>? maxFoodsPerWindow,
    Expression<int>? windowDurationDays,
    Expression<int>? researchConsent,
    Expression<int>? dataSharingConsent,
    Expression<String>? anonymousId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? lastLogin,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (emailVerified != null) 'email_verified': emailVerified,
      if (fullName != null) 'full_name': fullName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (gender != null) 'gender': gender,
      if (heightCm != null) 'height_cm': heightCm,
      if (initialWeightKg != null) 'initial_weight_kg': initialWeightKg,
      if (targetNetCarbs != null) 'target_net_carbs': targetNetCarbs,
      if (targetProtein != null) 'target_protein': targetProtein,
      if (targetFat != null) 'target_fat': targetFat,
      if (targetCalories != null) 'target_calories': targetCalories,
      if (ketoStartDate != null) 'keto_start_date': ketoStartDate,
      if (medicalConditions != null) 'medical_conditions': medicalConditions,
      if (goals != null) 'goals': goals,
      if (iotDevices != null) 'iot_devices': iotDevices,
      if (foodCreationCount != null) 'food_creation_count': foodCreationCount,
      if (foodCreationWindowStart != null)
        'food_creation_window_start': foodCreationWindowStart,
      if (maxFoodsPerWindow != null) 'max_foods_per_window': maxFoodsPerWindow,
      if (windowDurationDays != null)
        'window_duration_days': windowDurationDays,
      if (researchConsent != null) 'research_consent': researchConsent,
      if (dataSharingConsent != null)
        'data_sharing_consent': dataSharingConsent,
      if (anonymousId != null) 'anonymous_id': anonymousId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastLogin != null) 'last_login': lastLogin,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? userId,
      Value<String>? email,
      Value<String>? passwordHash,
      Value<int>? emailVerified,
      Value<String?>? fullName,
      Value<String?>? dateOfBirth,
      Value<String?>? gender,
      Value<double?>? heightCm,
      Value<double?>? initialWeightKg,
      Value<double>? targetNetCarbs,
      Value<double?>? targetProtein,
      Value<double?>? targetFat,
      Value<double?>? targetCalories,
      Value<String?>? ketoStartDate,
      Value<String?>? medicalConditions,
      Value<String?>? goals,
      Value<String?>? iotDevices,
      Value<int>? foodCreationCount,
      Value<String?>? foodCreationWindowStart,
      Value<int>? maxFoodsPerWindow,
      Value<int>? windowDurationDays,
      Value<int>? researchConsent,
      Value<int>? dataSharingConsent,
      Value<String?>? anonymousId,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String?>? lastLogin}) {
    return UsersCompanion(
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
      foodCreationWindowStart:
          foodCreationWindowStart ?? this.foodCreationWindowStart,
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (emailVerified.present) {
      map['email_verified'] = Variable<int>(emailVerified.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (initialWeightKg.present) {
      map['initial_weight_kg'] = Variable<double>(initialWeightKg.value);
    }
    if (targetNetCarbs.present) {
      map['target_net_carbs'] = Variable<double>(targetNetCarbs.value);
    }
    if (targetProtein.present) {
      map['target_protein'] = Variable<double>(targetProtein.value);
    }
    if (targetFat.present) {
      map['target_fat'] = Variable<double>(targetFat.value);
    }
    if (targetCalories.present) {
      map['target_calories'] = Variable<double>(targetCalories.value);
    }
    if (ketoStartDate.present) {
      map['keto_start_date'] = Variable<String>(ketoStartDate.value);
    }
    if (medicalConditions.present) {
      map['medical_conditions'] = Variable<String>(medicalConditions.value);
    }
    if (goals.present) {
      map['goals'] = Variable<String>(goals.value);
    }
    if (iotDevices.present) {
      map['iot_devices'] = Variable<String>(iotDevices.value);
    }
    if (foodCreationCount.present) {
      map['food_creation_count'] = Variable<int>(foodCreationCount.value);
    }
    if (foodCreationWindowStart.present) {
      map['food_creation_window_start'] =
          Variable<String>(foodCreationWindowStart.value);
    }
    if (maxFoodsPerWindow.present) {
      map['max_foods_per_window'] = Variable<int>(maxFoodsPerWindow.value);
    }
    if (windowDurationDays.present) {
      map['window_duration_days'] = Variable<int>(windowDurationDays.value);
    }
    if (researchConsent.present) {
      map['research_consent'] = Variable<int>(researchConsent.value);
    }
    if (dataSharingConsent.present) {
      map['data_sharing_consent'] = Variable<int>(dataSharingConsent.value);
    }
    if (anonymousId.present) {
      map['anonymous_id'] = Variable<String>(anonymousId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (lastLogin.present) {
      map['last_login'] = Variable<String>(lastLogin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('emailVerified: $emailVerified, ')
          ..write('fullName: $fullName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('heightCm: $heightCm, ')
          ..write('initialWeightKg: $initialWeightKg, ')
          ..write('targetNetCarbs: $targetNetCarbs, ')
          ..write('targetProtein: $targetProtein, ')
          ..write('targetFat: $targetFat, ')
          ..write('targetCalories: $targetCalories, ')
          ..write('ketoStartDate: $ketoStartDate, ')
          ..write('medicalConditions: $medicalConditions, ')
          ..write('goals: $goals, ')
          ..write('iotDevices: $iotDevices, ')
          ..write('foodCreationCount: $foodCreationCount, ')
          ..write('foodCreationWindowStart: $foodCreationWindowStart, ')
          ..write('maxFoodsPerWindow: $maxFoodsPerWindow, ')
          ..write('windowDurationDays: $windowDurationDays, ')
          ..write('researchConsent: $researchConsent, ')
          ..write('dataSharingConsent: $dataSharingConsent, ')
          ..write('anonymousId: $anonymousId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastLogin: $lastLogin')
          ..write(')'))
        .toString();
  }
}

class $FoodsTable extends Foods with TableInfo<$FoodsTable, Food> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _keylistMeta =
      const VerificationMeta('keylist');
  @override
  late final GeneratedColumn<String> keylist = GeneratedColumn<String>(
      'keylist', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _foodDescriptionMeta =
      const VerificationMeta('foodDescription');
  @override
  late final GeneratedColumn<String> foodDescription = GeneratedColumn<String>(
      'food_description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ncc'));
  static const VerificationMeta _createdByUserIdMeta =
      const VerificationMeta('createdByUserId');
  @override
  late final GeneratedColumn<int> createdByUserId = GeneratedColumn<int>(
      'created_by_user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isVerifiedMeta =
      const VerificationMeta('isVerified');
  @override
  late final GeneratedColumn<int> isVerified = GeneratedColumn<int>(
      'is_verified', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isKetoFriendlyMeta =
      const VerificationMeta('isKetoFriendly');
  @override
  late final GeneratedColumn<int> isKetoFriendly = GeneratedColumn<int>(
      'is_keto_friendly', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _energyKcalMeta =
      const VerificationMeta('energyKcal');
  @override
  late final GeneratedColumn<double> energyKcal = GeneratedColumn<double>(
      'energy_kcal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalProteinGMeta =
      const VerificationMeta('totalProteinG');
  @override
  late final GeneratedColumn<double> totalProteinG = GeneratedColumn<double>(
      'total_protein_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalFatGMeta =
      const VerificationMeta('totalFatG');
  @override
  late final GeneratedColumn<double> totalFatG = GeneratedColumn<double>(
      'total_fat_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalCarbohydrateGMeta =
      const VerificationMeta('totalCarbohydrateG');
  @override
  late final GeneratedColumn<double> totalCarbohydrateG =
      GeneratedColumn<double>('total_carbohydrate_g', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dietaryFiberGMeta =
      const VerificationMeta('dietaryFiberG');
  @override
  late final GeneratedColumn<double> dietaryFiberG = GeneratedColumn<double>(
      'dietary_fiber_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sugarGMeta = const VerificationMeta('sugarG');
  @override
  late final GeneratedColumn<double> sugarG = GeneratedColumn<double>(
      'sugar_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _addedSugarGMeta =
      const VerificationMeta('addedSugarG');
  @override
  late final GeneratedColumn<double> addedSugarG = GeneratedColumn<double>(
      'added_sugar_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _netCarbsGMeta =
      const VerificationMeta('netCarbsG');
  @override
  late final GeneratedColumn<double> netCarbsG = GeneratedColumn<double>(
      'net_carbs_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _saturatedFatGMeta =
      const VerificationMeta('saturatedFatG');
  @override
  late final GeneratedColumn<double> saturatedFatG = GeneratedColumn<double>(
      'saturated_fat_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _monounsaturatedFatGMeta =
      const VerificationMeta('monounsaturatedFatG');
  @override
  late final GeneratedColumn<double> monounsaturatedFatG =
      GeneratedColumn<double>('monounsaturated_fat_g', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _polyunsaturatedFatGMeta =
      const VerificationMeta('polyunsaturatedFatG');
  @override
  late final GeneratedColumn<double> polyunsaturatedFatG =
      GeneratedColumn<double>('polyunsaturated_fat_g', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _transFatGMeta =
      const VerificationMeta('transFatG');
  @override
  late final GeneratedColumn<double> transFatG = GeneratedColumn<double>(
      'trans_fat_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cholesterolMgMeta =
      const VerificationMeta('cholesterolMg');
  @override
  late final GeneratedColumn<double> cholesterolMg = GeneratedColumn<double>(
      'cholesterol_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sodiumMgMeta =
      const VerificationMeta('sodiumMg');
  @override
  late final GeneratedColumn<double> sodiumMg = GeneratedColumn<double>(
      'sodium_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _potassiumMgMeta =
      const VerificationMeta('potassiumMg');
  @override
  late final GeneratedColumn<double> potassiumMg = GeneratedColumn<double>(
      'potassium_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _magnesiumMgMeta =
      const VerificationMeta('magnesiumMg');
  @override
  late final GeneratedColumn<double> magnesiumMg = GeneratedColumn<double>(
      'magnesium_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _calciumMgMeta =
      const VerificationMeta('calciumMg');
  @override
  late final GeneratedColumn<double> calciumMg = GeneratedColumn<double>(
      'calcium_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _glycemicIndexMeta =
      const VerificationMeta('glycemicIndex');
  @override
  late final GeneratedColumn<int> glycemicIndex = GeneratedColumn<int>(
      'glycemic_index', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _glycemicLoadMeta =
      const VerificationMeta('glycemicLoad');
  @override
  late final GeneratedColumn<double> glycemicLoad = GeneratedColumn<double>(
      'glycemic_load', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _vitaminsMeta =
      const VerificationMeta('vitamins');
  @override
  late final GeneratedColumn<String> vitamins = GeneratedColumn<String>(
      'vitamins', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mineralsMeta =
      const VerificationMeta('minerals');
  @override
  late final GeneratedColumn<String> minerals = GeneratedColumn<String>(
      'minerals', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _foodPhotoUrlMeta =
      const VerificationMeta('foodPhotoUrl');
  @override
  late final GeneratedColumn<String> foodPhotoUrl = GeneratedColumn<String>(
      'food_photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  @override
  List<GeneratedColumn> get $columns => [
        foodId,
        keylist,
        foodDescription,
        source,
        createdByUserId,
        isVerified,
        isKetoFriendly,
        energyKcal,
        totalProteinG,
        totalFatG,
        totalCarbohydrateG,
        dietaryFiberG,
        sugarG,
        addedSugarG,
        netCarbsG,
        saturatedFatG,
        monounsaturatedFatG,
        polyunsaturatedFatG,
        transFatG,
        cholesterolMg,
        sodiumMg,
        potassiumMg,
        magnesiumMg,
        calciumMg,
        glycemicIndex,
        glycemicLoad,
        vitamins,
        minerals,
        foodPhotoUrl,
        barcode,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'foods';
  @override
  VerificationContext validateIntegrity(Insertable<Food> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    }
    if (data.containsKey('keylist')) {
      context.handle(_keylistMeta,
          keylist.isAcceptableOrUnknown(data['keylist']!, _keylistMeta));
    }
    if (data.containsKey('food_description')) {
      context.handle(
          _foodDescriptionMeta,
          foodDescription.isAcceptableOrUnknown(
              data['food_description']!, _foodDescriptionMeta));
    } else if (isInserting) {
      context.missing(_foodDescriptionMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('created_by_user_id')) {
      context.handle(
          _createdByUserIdMeta,
          createdByUserId.isAcceptableOrUnknown(
              data['created_by_user_id']!, _createdByUserIdMeta));
    }
    if (data.containsKey('is_verified')) {
      context.handle(
          _isVerifiedMeta,
          isVerified.isAcceptableOrUnknown(
              data['is_verified']!, _isVerifiedMeta));
    }
    if (data.containsKey('is_keto_friendly')) {
      context.handle(
          _isKetoFriendlyMeta,
          isKetoFriendly.isAcceptableOrUnknown(
              data['is_keto_friendly']!, _isKetoFriendlyMeta));
    }
    if (data.containsKey('energy_kcal')) {
      context.handle(
          _energyKcalMeta,
          energyKcal.isAcceptableOrUnknown(
              data['energy_kcal']!, _energyKcalMeta));
    } else if (isInserting) {
      context.missing(_energyKcalMeta);
    }
    if (data.containsKey('total_protein_g')) {
      context.handle(
          _totalProteinGMeta,
          totalProteinG.isAcceptableOrUnknown(
              data['total_protein_g']!, _totalProteinGMeta));
    } else if (isInserting) {
      context.missing(_totalProteinGMeta);
    }
    if (data.containsKey('total_fat_g')) {
      context.handle(
          _totalFatGMeta,
          totalFatG.isAcceptableOrUnknown(
              data['total_fat_g']!, _totalFatGMeta));
    } else if (isInserting) {
      context.missing(_totalFatGMeta);
    }
    if (data.containsKey('total_carbohydrate_g')) {
      context.handle(
          _totalCarbohydrateGMeta,
          totalCarbohydrateG.isAcceptableOrUnknown(
              data['total_carbohydrate_g']!, _totalCarbohydrateGMeta));
    } else if (isInserting) {
      context.missing(_totalCarbohydrateGMeta);
    }
    if (data.containsKey('dietary_fiber_g')) {
      context.handle(
          _dietaryFiberGMeta,
          dietaryFiberG.isAcceptableOrUnknown(
              data['dietary_fiber_g']!, _dietaryFiberGMeta));
    }
    if (data.containsKey('sugar_g')) {
      context.handle(_sugarGMeta,
          sugarG.isAcceptableOrUnknown(data['sugar_g']!, _sugarGMeta));
    }
    if (data.containsKey('added_sugar_g')) {
      context.handle(
          _addedSugarGMeta,
          addedSugarG.isAcceptableOrUnknown(
              data['added_sugar_g']!, _addedSugarGMeta));
    }
    if (data.containsKey('net_carbs_g')) {
      context.handle(
          _netCarbsGMeta,
          netCarbsG.isAcceptableOrUnknown(
              data['net_carbs_g']!, _netCarbsGMeta));
    }
    if (data.containsKey('saturated_fat_g')) {
      context.handle(
          _saturatedFatGMeta,
          saturatedFatG.isAcceptableOrUnknown(
              data['saturated_fat_g']!, _saturatedFatGMeta));
    }
    if (data.containsKey('monounsaturated_fat_g')) {
      context.handle(
          _monounsaturatedFatGMeta,
          monounsaturatedFatG.isAcceptableOrUnknown(
              data['monounsaturated_fat_g']!, _monounsaturatedFatGMeta));
    }
    if (data.containsKey('polyunsaturated_fat_g')) {
      context.handle(
          _polyunsaturatedFatGMeta,
          polyunsaturatedFatG.isAcceptableOrUnknown(
              data['polyunsaturated_fat_g']!, _polyunsaturatedFatGMeta));
    }
    if (data.containsKey('trans_fat_g')) {
      context.handle(
          _transFatGMeta,
          transFatG.isAcceptableOrUnknown(
              data['trans_fat_g']!, _transFatGMeta));
    }
    if (data.containsKey('cholesterol_mg')) {
      context.handle(
          _cholesterolMgMeta,
          cholesterolMg.isAcceptableOrUnknown(
              data['cholesterol_mg']!, _cholesterolMgMeta));
    }
    if (data.containsKey('sodium_mg')) {
      context.handle(_sodiumMgMeta,
          sodiumMg.isAcceptableOrUnknown(data['sodium_mg']!, _sodiumMgMeta));
    }
    if (data.containsKey('potassium_mg')) {
      context.handle(
          _potassiumMgMeta,
          potassiumMg.isAcceptableOrUnknown(
              data['potassium_mg']!, _potassiumMgMeta));
    }
    if (data.containsKey('magnesium_mg')) {
      context.handle(
          _magnesiumMgMeta,
          magnesiumMg.isAcceptableOrUnknown(
              data['magnesium_mg']!, _magnesiumMgMeta));
    }
    if (data.containsKey('calcium_mg')) {
      context.handle(_calciumMgMeta,
          calciumMg.isAcceptableOrUnknown(data['calcium_mg']!, _calciumMgMeta));
    }
    if (data.containsKey('glycemic_index')) {
      context.handle(
          _glycemicIndexMeta,
          glycemicIndex.isAcceptableOrUnknown(
              data['glycemic_index']!, _glycemicIndexMeta));
    }
    if (data.containsKey('glycemic_load')) {
      context.handle(
          _glycemicLoadMeta,
          glycemicLoad.isAcceptableOrUnknown(
              data['glycemic_load']!, _glycemicLoadMeta));
    }
    if (data.containsKey('vitamins')) {
      context.handle(_vitaminsMeta,
          vitamins.isAcceptableOrUnknown(data['vitamins']!, _vitaminsMeta));
    }
    if (data.containsKey('minerals')) {
      context.handle(_mineralsMeta,
          minerals.isAcceptableOrUnknown(data['minerals']!, _mineralsMeta));
    }
    if (data.containsKey('food_photo_url')) {
      context.handle(
          _foodPhotoUrlMeta,
          foodPhotoUrl.isAcceptableOrUnknown(
              data['food_photo_url']!, _foodPhotoUrlMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {foodId};
  @override
  Food map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Food(
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      keylist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}keylist']),
      foodDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}food_description'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      createdByUserId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_by_user_id']),
      isVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_verified'])!,
      isKetoFriendly: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_keto_friendly']),
      energyKcal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}energy_kcal'])!,
      totalProteinG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_protein_g'])!,
      totalFatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fat_g'])!,
      totalCarbohydrateG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_carbohydrate_g'])!,
      dietaryFiberG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}dietary_fiber_g'])!,
      sugarG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sugar_g'])!,
      addedSugarG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}added_sugar_g'])!,
      netCarbsG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}net_carbs_g']),
      saturatedFatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}saturated_fat_g']),
      monounsaturatedFatG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}monounsaturated_fat_g']),
      polyunsaturatedFatG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}polyunsaturated_fat_g']),
      transFatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}trans_fat_g']),
      cholesterolMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cholesterol_mg']),
      sodiumMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sodium_mg']),
      potassiumMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}potassium_mg']),
      magnesiumMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}magnesium_mg']),
      calciumMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calcium_mg']),
      glycemicIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}glycemic_index']),
      glycemicLoad: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}glycemic_load']),
      vitamins: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vitamins']),
      minerals: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}minerals']),
      foodPhotoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_photo_url']),
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FoodsTable createAlias(String alias) {
    return $FoodsTable(attachedDatabase, alias);
  }
}

class Food extends DataClass implements Insertable<Food> {
  final int foodId;
  final String? keylist;
  final String foodDescription;
  final String source;
  final int? createdByUserId;
  final int isVerified;
  final int? isKetoFriendly;
  final double energyKcal;
  final double totalProteinG;
  final double totalFatG;
  final double totalCarbohydrateG;
  final double dietaryFiberG;
  final double sugarG;
  final double addedSugarG;
  final double? netCarbsG;
  final double? saturatedFatG;
  final double? monounsaturatedFatG;
  final double? polyunsaturatedFatG;
  final double? transFatG;
  final double? cholesterolMg;
  final double? sodiumMg;
  final double? potassiumMg;
  final double? magnesiumMg;
  final double? calciumMg;
  final int? glycemicIndex;
  final double? glycemicLoad;
  final String? vitamins;
  final String? minerals;
  final String? foodPhotoUrl;
  final String? barcode;
  final String createdAt;
  final String updatedAt;
  const Food(
      {required this.foodId,
      this.keylist,
      required this.foodDescription,
      required this.source,
      this.createdByUserId,
      required this.isVerified,
      this.isKetoFriendly,
      required this.energyKcal,
      required this.totalProteinG,
      required this.totalFatG,
      required this.totalCarbohydrateG,
      required this.dietaryFiberG,
      required this.sugarG,
      required this.addedSugarG,
      this.netCarbsG,
      this.saturatedFatG,
      this.monounsaturatedFatG,
      this.polyunsaturatedFatG,
      this.transFatG,
      this.cholesterolMg,
      this.sodiumMg,
      this.potassiumMg,
      this.magnesiumMg,
      this.calciumMg,
      this.glycemicIndex,
      this.glycemicLoad,
      this.vitamins,
      this.minerals,
      this.foodPhotoUrl,
      this.barcode,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['food_id'] = Variable<int>(foodId);
    if (!nullToAbsent || keylist != null) {
      map['keylist'] = Variable<String>(keylist);
    }
    map['food_description'] = Variable<String>(foodDescription);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || createdByUserId != null) {
      map['created_by_user_id'] = Variable<int>(createdByUserId);
    }
    map['is_verified'] = Variable<int>(isVerified);
    if (!nullToAbsent || isKetoFriendly != null) {
      map['is_keto_friendly'] = Variable<int>(isKetoFriendly);
    }
    map['energy_kcal'] = Variable<double>(energyKcal);
    map['total_protein_g'] = Variable<double>(totalProteinG);
    map['total_fat_g'] = Variable<double>(totalFatG);
    map['total_carbohydrate_g'] = Variable<double>(totalCarbohydrateG);
    map['dietary_fiber_g'] = Variable<double>(dietaryFiberG);
    map['sugar_g'] = Variable<double>(sugarG);
    map['added_sugar_g'] = Variable<double>(addedSugarG);
    if (!nullToAbsent || netCarbsG != null) {
      map['net_carbs_g'] = Variable<double>(netCarbsG);
    }
    if (!nullToAbsent || saturatedFatG != null) {
      map['saturated_fat_g'] = Variable<double>(saturatedFatG);
    }
    if (!nullToAbsent || monounsaturatedFatG != null) {
      map['monounsaturated_fat_g'] = Variable<double>(monounsaturatedFatG);
    }
    if (!nullToAbsent || polyunsaturatedFatG != null) {
      map['polyunsaturated_fat_g'] = Variable<double>(polyunsaturatedFatG);
    }
    if (!nullToAbsent || transFatG != null) {
      map['trans_fat_g'] = Variable<double>(transFatG);
    }
    if (!nullToAbsent || cholesterolMg != null) {
      map['cholesterol_mg'] = Variable<double>(cholesterolMg);
    }
    if (!nullToAbsent || sodiumMg != null) {
      map['sodium_mg'] = Variable<double>(sodiumMg);
    }
    if (!nullToAbsent || potassiumMg != null) {
      map['potassium_mg'] = Variable<double>(potassiumMg);
    }
    if (!nullToAbsent || magnesiumMg != null) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg);
    }
    if (!nullToAbsent || calciumMg != null) {
      map['calcium_mg'] = Variable<double>(calciumMg);
    }
    if (!nullToAbsent || glycemicIndex != null) {
      map['glycemic_index'] = Variable<int>(glycemicIndex);
    }
    if (!nullToAbsent || glycemicLoad != null) {
      map['glycemic_load'] = Variable<double>(glycemicLoad);
    }
    if (!nullToAbsent || vitamins != null) {
      map['vitamins'] = Variable<String>(vitamins);
    }
    if (!nullToAbsent || minerals != null) {
      map['minerals'] = Variable<String>(minerals);
    }
    if (!nullToAbsent || foodPhotoUrl != null) {
      map['food_photo_url'] = Variable<String>(foodPhotoUrl);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  FoodsCompanion toCompanion(bool nullToAbsent) {
    return FoodsCompanion(
      foodId: Value(foodId),
      keylist: keylist == null && nullToAbsent
          ? const Value.absent()
          : Value(keylist),
      foodDescription: Value(foodDescription),
      source: Value(source),
      createdByUserId: createdByUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(createdByUserId),
      isVerified: Value(isVerified),
      isKetoFriendly: isKetoFriendly == null && nullToAbsent
          ? const Value.absent()
          : Value(isKetoFriendly),
      energyKcal: Value(energyKcal),
      totalProteinG: Value(totalProteinG),
      totalFatG: Value(totalFatG),
      totalCarbohydrateG: Value(totalCarbohydrateG),
      dietaryFiberG: Value(dietaryFiberG),
      sugarG: Value(sugarG),
      addedSugarG: Value(addedSugarG),
      netCarbsG: netCarbsG == null && nullToAbsent
          ? const Value.absent()
          : Value(netCarbsG),
      saturatedFatG: saturatedFatG == null && nullToAbsent
          ? const Value.absent()
          : Value(saturatedFatG),
      monounsaturatedFatG: monounsaturatedFatG == null && nullToAbsent
          ? const Value.absent()
          : Value(monounsaturatedFatG),
      polyunsaturatedFatG: polyunsaturatedFatG == null && nullToAbsent
          ? const Value.absent()
          : Value(polyunsaturatedFatG),
      transFatG: transFatG == null && nullToAbsent
          ? const Value.absent()
          : Value(transFatG),
      cholesterolMg: cholesterolMg == null && nullToAbsent
          ? const Value.absent()
          : Value(cholesterolMg),
      sodiumMg: sodiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(sodiumMg),
      potassiumMg: potassiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(potassiumMg),
      magnesiumMg: magnesiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(magnesiumMg),
      calciumMg: calciumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(calciumMg),
      glycemicIndex: glycemicIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(glycemicIndex),
      glycemicLoad: glycemicLoad == null && nullToAbsent
          ? const Value.absent()
          : Value(glycemicLoad),
      vitamins: vitamins == null && nullToAbsent
          ? const Value.absent()
          : Value(vitamins),
      minerals: minerals == null && nullToAbsent
          ? const Value.absent()
          : Value(minerals),
      foodPhotoUrl: foodPhotoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(foodPhotoUrl),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Food.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Food(
      foodId: serializer.fromJson<int>(json['foodId']),
      keylist: serializer.fromJson<String?>(json['keylist']),
      foodDescription: serializer.fromJson<String>(json['foodDescription']),
      source: serializer.fromJson<String>(json['source']),
      createdByUserId: serializer.fromJson<int?>(json['createdByUserId']),
      isVerified: serializer.fromJson<int>(json['isVerified']),
      isKetoFriendly: serializer.fromJson<int?>(json['isKetoFriendly']),
      energyKcal: serializer.fromJson<double>(json['energyKcal']),
      totalProteinG: serializer.fromJson<double>(json['totalProteinG']),
      totalFatG: serializer.fromJson<double>(json['totalFatG']),
      totalCarbohydrateG:
          serializer.fromJson<double>(json['totalCarbohydrateG']),
      dietaryFiberG: serializer.fromJson<double>(json['dietaryFiberG']),
      sugarG: serializer.fromJson<double>(json['sugarG']),
      addedSugarG: serializer.fromJson<double>(json['addedSugarG']),
      netCarbsG: serializer.fromJson<double?>(json['netCarbsG']),
      saturatedFatG: serializer.fromJson<double?>(json['saturatedFatG']),
      monounsaturatedFatG:
          serializer.fromJson<double?>(json['monounsaturatedFatG']),
      polyunsaturatedFatG:
          serializer.fromJson<double?>(json['polyunsaturatedFatG']),
      transFatG: serializer.fromJson<double?>(json['transFatG']),
      cholesterolMg: serializer.fromJson<double?>(json['cholesterolMg']),
      sodiumMg: serializer.fromJson<double?>(json['sodiumMg']),
      potassiumMg: serializer.fromJson<double?>(json['potassiumMg']),
      magnesiumMg: serializer.fromJson<double?>(json['magnesiumMg']),
      calciumMg: serializer.fromJson<double?>(json['calciumMg']),
      glycemicIndex: serializer.fromJson<int?>(json['glycemicIndex']),
      glycemicLoad: serializer.fromJson<double?>(json['glycemicLoad']),
      vitamins: serializer.fromJson<String?>(json['vitamins']),
      minerals: serializer.fromJson<String?>(json['minerals']),
      foodPhotoUrl: serializer.fromJson<String?>(json['foodPhotoUrl']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'foodId': serializer.toJson<int>(foodId),
      'keylist': serializer.toJson<String?>(keylist),
      'foodDescription': serializer.toJson<String>(foodDescription),
      'source': serializer.toJson<String>(source),
      'createdByUserId': serializer.toJson<int?>(createdByUserId),
      'isVerified': serializer.toJson<int>(isVerified),
      'isKetoFriendly': serializer.toJson<int?>(isKetoFriendly),
      'energyKcal': serializer.toJson<double>(energyKcal),
      'totalProteinG': serializer.toJson<double>(totalProteinG),
      'totalFatG': serializer.toJson<double>(totalFatG),
      'totalCarbohydrateG': serializer.toJson<double>(totalCarbohydrateG),
      'dietaryFiberG': serializer.toJson<double>(dietaryFiberG),
      'sugarG': serializer.toJson<double>(sugarG),
      'addedSugarG': serializer.toJson<double>(addedSugarG),
      'netCarbsG': serializer.toJson<double?>(netCarbsG),
      'saturatedFatG': serializer.toJson<double?>(saturatedFatG),
      'monounsaturatedFatG': serializer.toJson<double?>(monounsaturatedFatG),
      'polyunsaturatedFatG': serializer.toJson<double?>(polyunsaturatedFatG),
      'transFatG': serializer.toJson<double?>(transFatG),
      'cholesterolMg': serializer.toJson<double?>(cholesterolMg),
      'sodiumMg': serializer.toJson<double?>(sodiumMg),
      'potassiumMg': serializer.toJson<double?>(potassiumMg),
      'magnesiumMg': serializer.toJson<double?>(magnesiumMg),
      'calciumMg': serializer.toJson<double?>(calciumMg),
      'glycemicIndex': serializer.toJson<int?>(glycemicIndex),
      'glycemicLoad': serializer.toJson<double?>(glycemicLoad),
      'vitamins': serializer.toJson<String?>(vitamins),
      'minerals': serializer.toJson<String?>(minerals),
      'foodPhotoUrl': serializer.toJson<String?>(foodPhotoUrl),
      'barcode': serializer.toJson<String?>(barcode),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Food copyWith(
          {int? foodId,
          Value<String?> keylist = const Value.absent(),
          String? foodDescription,
          String? source,
          Value<int?> createdByUserId = const Value.absent(),
          int? isVerified,
          Value<int?> isKetoFriendly = const Value.absent(),
          double? energyKcal,
          double? totalProteinG,
          double? totalFatG,
          double? totalCarbohydrateG,
          double? dietaryFiberG,
          double? sugarG,
          double? addedSugarG,
          Value<double?> netCarbsG = const Value.absent(),
          Value<double?> saturatedFatG = const Value.absent(),
          Value<double?> monounsaturatedFatG = const Value.absent(),
          Value<double?> polyunsaturatedFatG = const Value.absent(),
          Value<double?> transFatG = const Value.absent(),
          Value<double?> cholesterolMg = const Value.absent(),
          Value<double?> sodiumMg = const Value.absent(),
          Value<double?> potassiumMg = const Value.absent(),
          Value<double?> magnesiumMg = const Value.absent(),
          Value<double?> calciumMg = const Value.absent(),
          Value<int?> glycemicIndex = const Value.absent(),
          Value<double?> glycemicLoad = const Value.absent(),
          Value<String?> vitamins = const Value.absent(),
          Value<String?> minerals = const Value.absent(),
          Value<String?> foodPhotoUrl = const Value.absent(),
          Value<String?> barcode = const Value.absent(),
          String? createdAt,
          String? updatedAt}) =>
      Food(
        foodId: foodId ?? this.foodId,
        keylist: keylist.present ? keylist.value : this.keylist,
        foodDescription: foodDescription ?? this.foodDescription,
        source: source ?? this.source,
        createdByUserId: createdByUserId.present
            ? createdByUserId.value
            : this.createdByUserId,
        isVerified: isVerified ?? this.isVerified,
        isKetoFriendly:
            isKetoFriendly.present ? isKetoFriendly.value : this.isKetoFriendly,
        energyKcal: energyKcal ?? this.energyKcal,
        totalProteinG: totalProteinG ?? this.totalProteinG,
        totalFatG: totalFatG ?? this.totalFatG,
        totalCarbohydrateG: totalCarbohydrateG ?? this.totalCarbohydrateG,
        dietaryFiberG: dietaryFiberG ?? this.dietaryFiberG,
        sugarG: sugarG ?? this.sugarG,
        addedSugarG: addedSugarG ?? this.addedSugarG,
        netCarbsG: netCarbsG.present ? netCarbsG.value : this.netCarbsG,
        saturatedFatG:
            saturatedFatG.present ? saturatedFatG.value : this.saturatedFatG,
        monounsaturatedFatG: monounsaturatedFatG.present
            ? monounsaturatedFatG.value
            : this.monounsaturatedFatG,
        polyunsaturatedFatG: polyunsaturatedFatG.present
            ? polyunsaturatedFatG.value
            : this.polyunsaturatedFatG,
        transFatG: transFatG.present ? transFatG.value : this.transFatG,
        cholesterolMg:
            cholesterolMg.present ? cholesterolMg.value : this.cholesterolMg,
        sodiumMg: sodiumMg.present ? sodiumMg.value : this.sodiumMg,
        potassiumMg: potassiumMg.present ? potassiumMg.value : this.potassiumMg,
        magnesiumMg: magnesiumMg.present ? magnesiumMg.value : this.magnesiumMg,
        calciumMg: calciumMg.present ? calciumMg.value : this.calciumMg,
        glycemicIndex:
            glycemicIndex.present ? glycemicIndex.value : this.glycemicIndex,
        glycemicLoad:
            glycemicLoad.present ? glycemicLoad.value : this.glycemicLoad,
        vitamins: vitamins.present ? vitamins.value : this.vitamins,
        minerals: minerals.present ? minerals.value : this.minerals,
        foodPhotoUrl:
            foodPhotoUrl.present ? foodPhotoUrl.value : this.foodPhotoUrl,
        barcode: barcode.present ? barcode.value : this.barcode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Food copyWithCompanion(FoodsCompanion data) {
    return Food(
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      keylist: data.keylist.present ? data.keylist.value : this.keylist,
      foodDescription: data.foodDescription.present
          ? data.foodDescription.value
          : this.foodDescription,
      source: data.source.present ? data.source.value : this.source,
      createdByUserId: data.createdByUserId.present
          ? data.createdByUserId.value
          : this.createdByUserId,
      isVerified:
          data.isVerified.present ? data.isVerified.value : this.isVerified,
      isKetoFriendly: data.isKetoFriendly.present
          ? data.isKetoFriendly.value
          : this.isKetoFriendly,
      energyKcal:
          data.energyKcal.present ? data.energyKcal.value : this.energyKcal,
      totalProteinG: data.totalProteinG.present
          ? data.totalProteinG.value
          : this.totalProteinG,
      totalFatG: data.totalFatG.present ? data.totalFatG.value : this.totalFatG,
      totalCarbohydrateG: data.totalCarbohydrateG.present
          ? data.totalCarbohydrateG.value
          : this.totalCarbohydrateG,
      dietaryFiberG: data.dietaryFiberG.present
          ? data.dietaryFiberG.value
          : this.dietaryFiberG,
      sugarG: data.sugarG.present ? data.sugarG.value : this.sugarG,
      addedSugarG:
          data.addedSugarG.present ? data.addedSugarG.value : this.addedSugarG,
      netCarbsG: data.netCarbsG.present ? data.netCarbsG.value : this.netCarbsG,
      saturatedFatG: data.saturatedFatG.present
          ? data.saturatedFatG.value
          : this.saturatedFatG,
      monounsaturatedFatG: data.monounsaturatedFatG.present
          ? data.monounsaturatedFatG.value
          : this.monounsaturatedFatG,
      polyunsaturatedFatG: data.polyunsaturatedFatG.present
          ? data.polyunsaturatedFatG.value
          : this.polyunsaturatedFatG,
      transFatG: data.transFatG.present ? data.transFatG.value : this.transFatG,
      cholesterolMg: data.cholesterolMg.present
          ? data.cholesterolMg.value
          : this.cholesterolMg,
      sodiumMg: data.sodiumMg.present ? data.sodiumMg.value : this.sodiumMg,
      potassiumMg:
          data.potassiumMg.present ? data.potassiumMg.value : this.potassiumMg,
      magnesiumMg:
          data.magnesiumMg.present ? data.magnesiumMg.value : this.magnesiumMg,
      calciumMg: data.calciumMg.present ? data.calciumMg.value : this.calciumMg,
      glycemicIndex: data.glycemicIndex.present
          ? data.glycemicIndex.value
          : this.glycemicIndex,
      glycemicLoad: data.glycemicLoad.present
          ? data.glycemicLoad.value
          : this.glycemicLoad,
      vitamins: data.vitamins.present ? data.vitamins.value : this.vitamins,
      minerals: data.minerals.present ? data.minerals.value : this.minerals,
      foodPhotoUrl: data.foodPhotoUrl.present
          ? data.foodPhotoUrl.value
          : this.foodPhotoUrl,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Food(')
          ..write('foodId: $foodId, ')
          ..write('keylist: $keylist, ')
          ..write('foodDescription: $foodDescription, ')
          ..write('source: $source, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('isVerified: $isVerified, ')
          ..write('isKetoFriendly: $isKetoFriendly, ')
          ..write('energyKcal: $energyKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('totalCarbohydrateG: $totalCarbohydrateG, ')
          ..write('dietaryFiberG: $dietaryFiberG, ')
          ..write('sugarG: $sugarG, ')
          ..write('addedSugarG: $addedSugarG, ')
          ..write('netCarbsG: $netCarbsG, ')
          ..write('saturatedFatG: $saturatedFatG, ')
          ..write('monounsaturatedFatG: $monounsaturatedFatG, ')
          ..write('polyunsaturatedFatG: $polyunsaturatedFatG, ')
          ..write('transFatG: $transFatG, ')
          ..write('cholesterolMg: $cholesterolMg, ')
          ..write('sodiumMg: $sodiumMg, ')
          ..write('potassiumMg: $potassiumMg, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('calciumMg: $calciumMg, ')
          ..write('glycemicIndex: $glycemicIndex, ')
          ..write('glycemicLoad: $glycemicLoad, ')
          ..write('vitamins: $vitamins, ')
          ..write('minerals: $minerals, ')
          ..write('foodPhotoUrl: $foodPhotoUrl, ')
          ..write('barcode: $barcode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        foodId,
        keylist,
        foodDescription,
        source,
        createdByUserId,
        isVerified,
        isKetoFriendly,
        energyKcal,
        totalProteinG,
        totalFatG,
        totalCarbohydrateG,
        dietaryFiberG,
        sugarG,
        addedSugarG,
        netCarbsG,
        saturatedFatG,
        monounsaturatedFatG,
        polyunsaturatedFatG,
        transFatG,
        cholesterolMg,
        sodiumMg,
        potassiumMg,
        magnesiumMg,
        calciumMg,
        glycemicIndex,
        glycemicLoad,
        vitamins,
        minerals,
        foodPhotoUrl,
        barcode,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Food &&
          other.foodId == this.foodId &&
          other.keylist == this.keylist &&
          other.foodDescription == this.foodDescription &&
          other.source == this.source &&
          other.createdByUserId == this.createdByUserId &&
          other.isVerified == this.isVerified &&
          other.isKetoFriendly == this.isKetoFriendly &&
          other.energyKcal == this.energyKcal &&
          other.totalProteinG == this.totalProteinG &&
          other.totalFatG == this.totalFatG &&
          other.totalCarbohydrateG == this.totalCarbohydrateG &&
          other.dietaryFiberG == this.dietaryFiberG &&
          other.sugarG == this.sugarG &&
          other.addedSugarG == this.addedSugarG &&
          other.netCarbsG == this.netCarbsG &&
          other.saturatedFatG == this.saturatedFatG &&
          other.monounsaturatedFatG == this.monounsaturatedFatG &&
          other.polyunsaturatedFatG == this.polyunsaturatedFatG &&
          other.transFatG == this.transFatG &&
          other.cholesterolMg == this.cholesterolMg &&
          other.sodiumMg == this.sodiumMg &&
          other.potassiumMg == this.potassiumMg &&
          other.magnesiumMg == this.magnesiumMg &&
          other.calciumMg == this.calciumMg &&
          other.glycemicIndex == this.glycemicIndex &&
          other.glycemicLoad == this.glycemicLoad &&
          other.vitamins == this.vitamins &&
          other.minerals == this.minerals &&
          other.foodPhotoUrl == this.foodPhotoUrl &&
          other.barcode == this.barcode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodsCompanion extends UpdateCompanion<Food> {
  final Value<int> foodId;
  final Value<String?> keylist;
  final Value<String> foodDescription;
  final Value<String> source;
  final Value<int?> createdByUserId;
  final Value<int> isVerified;
  final Value<int?> isKetoFriendly;
  final Value<double> energyKcal;
  final Value<double> totalProteinG;
  final Value<double> totalFatG;
  final Value<double> totalCarbohydrateG;
  final Value<double> dietaryFiberG;
  final Value<double> sugarG;
  final Value<double> addedSugarG;
  final Value<double?> netCarbsG;
  final Value<double?> saturatedFatG;
  final Value<double?> monounsaturatedFatG;
  final Value<double?> polyunsaturatedFatG;
  final Value<double?> transFatG;
  final Value<double?> cholesterolMg;
  final Value<double?> sodiumMg;
  final Value<double?> potassiumMg;
  final Value<double?> magnesiumMg;
  final Value<double?> calciumMg;
  final Value<int?> glycemicIndex;
  final Value<double?> glycemicLoad;
  final Value<String?> vitamins;
  final Value<String?> minerals;
  final Value<String?> foodPhotoUrl;
  final Value<String?> barcode;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const FoodsCompanion({
    this.foodId = const Value.absent(),
    this.keylist = const Value.absent(),
    this.foodDescription = const Value.absent(),
    this.source = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isKetoFriendly = const Value.absent(),
    this.energyKcal = const Value.absent(),
    this.totalProteinG = const Value.absent(),
    this.totalFatG = const Value.absent(),
    this.totalCarbohydrateG = const Value.absent(),
    this.dietaryFiberG = const Value.absent(),
    this.sugarG = const Value.absent(),
    this.addedSugarG = const Value.absent(),
    this.netCarbsG = const Value.absent(),
    this.saturatedFatG = const Value.absent(),
    this.monounsaturatedFatG = const Value.absent(),
    this.polyunsaturatedFatG = const Value.absent(),
    this.transFatG = const Value.absent(),
    this.cholesterolMg = const Value.absent(),
    this.sodiumMg = const Value.absent(),
    this.potassiumMg = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.calciumMg = const Value.absent(),
    this.glycemicIndex = const Value.absent(),
    this.glycemicLoad = const Value.absent(),
    this.vitamins = const Value.absent(),
    this.minerals = const Value.absent(),
    this.foodPhotoUrl = const Value.absent(),
    this.barcode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FoodsCompanion.insert({
    this.foodId = const Value.absent(),
    this.keylist = const Value.absent(),
    required String foodDescription,
    this.source = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isKetoFriendly = const Value.absent(),
    required double energyKcal,
    required double totalProteinG,
    required double totalFatG,
    required double totalCarbohydrateG,
    this.dietaryFiberG = const Value.absent(),
    this.sugarG = const Value.absent(),
    this.addedSugarG = const Value.absent(),
    this.netCarbsG = const Value.absent(),
    this.saturatedFatG = const Value.absent(),
    this.monounsaturatedFatG = const Value.absent(),
    this.polyunsaturatedFatG = const Value.absent(),
    this.transFatG = const Value.absent(),
    this.cholesterolMg = const Value.absent(),
    this.sodiumMg = const Value.absent(),
    this.potassiumMg = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.calciumMg = const Value.absent(),
    this.glycemicIndex = const Value.absent(),
    this.glycemicLoad = const Value.absent(),
    this.vitamins = const Value.absent(),
    this.minerals = const Value.absent(),
    this.foodPhotoUrl = const Value.absent(),
    this.barcode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : foodDescription = Value(foodDescription),
        energyKcal = Value(energyKcal),
        totalProteinG = Value(totalProteinG),
        totalFatG = Value(totalFatG),
        totalCarbohydrateG = Value(totalCarbohydrateG);
  static Insertable<Food> custom({
    Expression<int>? foodId,
    Expression<String>? keylist,
    Expression<String>? foodDescription,
    Expression<String>? source,
    Expression<int>? createdByUserId,
    Expression<int>? isVerified,
    Expression<int>? isKetoFriendly,
    Expression<double>? energyKcal,
    Expression<double>? totalProteinG,
    Expression<double>? totalFatG,
    Expression<double>? totalCarbohydrateG,
    Expression<double>? dietaryFiberG,
    Expression<double>? sugarG,
    Expression<double>? addedSugarG,
    Expression<double>? netCarbsG,
    Expression<double>? saturatedFatG,
    Expression<double>? monounsaturatedFatG,
    Expression<double>? polyunsaturatedFatG,
    Expression<double>? transFatG,
    Expression<double>? cholesterolMg,
    Expression<double>? sodiumMg,
    Expression<double>? potassiumMg,
    Expression<double>? magnesiumMg,
    Expression<double>? calciumMg,
    Expression<int>? glycemicIndex,
    Expression<double>? glycemicLoad,
    Expression<String>? vitamins,
    Expression<String>? minerals,
    Expression<String>? foodPhotoUrl,
    Expression<String>? barcode,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (foodId != null) 'food_id': foodId,
      if (keylist != null) 'keylist': keylist,
      if (foodDescription != null) 'food_description': foodDescription,
      if (source != null) 'source': source,
      if (createdByUserId != null) 'created_by_user_id': createdByUserId,
      if (isVerified != null) 'is_verified': isVerified,
      if (isKetoFriendly != null) 'is_keto_friendly': isKetoFriendly,
      if (energyKcal != null) 'energy_kcal': energyKcal,
      if (totalProteinG != null) 'total_protein_g': totalProteinG,
      if (totalFatG != null) 'total_fat_g': totalFatG,
      if (totalCarbohydrateG != null)
        'total_carbohydrate_g': totalCarbohydrateG,
      if (dietaryFiberG != null) 'dietary_fiber_g': dietaryFiberG,
      if (sugarG != null) 'sugar_g': sugarG,
      if (addedSugarG != null) 'added_sugar_g': addedSugarG,
      if (netCarbsG != null) 'net_carbs_g': netCarbsG,
      if (saturatedFatG != null) 'saturated_fat_g': saturatedFatG,
      if (monounsaturatedFatG != null)
        'monounsaturated_fat_g': monounsaturatedFatG,
      if (polyunsaturatedFatG != null)
        'polyunsaturated_fat_g': polyunsaturatedFatG,
      if (transFatG != null) 'trans_fat_g': transFatG,
      if (cholesterolMg != null) 'cholesterol_mg': cholesterolMg,
      if (sodiumMg != null) 'sodium_mg': sodiumMg,
      if (potassiumMg != null) 'potassium_mg': potassiumMg,
      if (magnesiumMg != null) 'magnesium_mg': magnesiumMg,
      if (calciumMg != null) 'calcium_mg': calciumMg,
      if (glycemicIndex != null) 'glycemic_index': glycemicIndex,
      if (glycemicLoad != null) 'glycemic_load': glycemicLoad,
      if (vitamins != null) 'vitamins': vitamins,
      if (minerals != null) 'minerals': minerals,
      if (foodPhotoUrl != null) 'food_photo_url': foodPhotoUrl,
      if (barcode != null) 'barcode': barcode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FoodsCompanion copyWith(
      {Value<int>? foodId,
      Value<String?>? keylist,
      Value<String>? foodDescription,
      Value<String>? source,
      Value<int?>? createdByUserId,
      Value<int>? isVerified,
      Value<int?>? isKetoFriendly,
      Value<double>? energyKcal,
      Value<double>? totalProteinG,
      Value<double>? totalFatG,
      Value<double>? totalCarbohydrateG,
      Value<double>? dietaryFiberG,
      Value<double>? sugarG,
      Value<double>? addedSugarG,
      Value<double?>? netCarbsG,
      Value<double?>? saturatedFatG,
      Value<double?>? monounsaturatedFatG,
      Value<double?>? polyunsaturatedFatG,
      Value<double?>? transFatG,
      Value<double?>? cholesterolMg,
      Value<double?>? sodiumMg,
      Value<double?>? potassiumMg,
      Value<double?>? magnesiumMg,
      Value<double?>? calciumMg,
      Value<int?>? glycemicIndex,
      Value<double?>? glycemicLoad,
      Value<String?>? vitamins,
      Value<String?>? minerals,
      Value<String?>? foodPhotoUrl,
      Value<String?>? barcode,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return FoodsCompanion(
      foodId: foodId ?? this.foodId,
      keylist: keylist ?? this.keylist,
      foodDescription: foodDescription ?? this.foodDescription,
      source: source ?? this.source,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      isVerified: isVerified ?? this.isVerified,
      isKetoFriendly: isKetoFriendly ?? this.isKetoFriendly,
      energyKcal: energyKcal ?? this.energyKcal,
      totalProteinG: totalProteinG ?? this.totalProteinG,
      totalFatG: totalFatG ?? this.totalFatG,
      totalCarbohydrateG: totalCarbohydrateG ?? this.totalCarbohydrateG,
      dietaryFiberG: dietaryFiberG ?? this.dietaryFiberG,
      sugarG: sugarG ?? this.sugarG,
      addedSugarG: addedSugarG ?? this.addedSugarG,
      netCarbsG: netCarbsG ?? this.netCarbsG,
      saturatedFatG: saturatedFatG ?? this.saturatedFatG,
      monounsaturatedFatG: monounsaturatedFatG ?? this.monounsaturatedFatG,
      polyunsaturatedFatG: polyunsaturatedFatG ?? this.polyunsaturatedFatG,
      transFatG: transFatG ?? this.transFatG,
      cholesterolMg: cholesterolMg ?? this.cholesterolMg,
      sodiumMg: sodiumMg ?? this.sodiumMg,
      potassiumMg: potassiumMg ?? this.potassiumMg,
      magnesiumMg: magnesiumMg ?? this.magnesiumMg,
      calciumMg: calciumMg ?? this.calciumMg,
      glycemicIndex: glycemicIndex ?? this.glycemicIndex,
      glycemicLoad: glycemicLoad ?? this.glycemicLoad,
      vitamins: vitamins ?? this.vitamins,
      minerals: minerals ?? this.minerals,
      foodPhotoUrl: foodPhotoUrl ?? this.foodPhotoUrl,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (keylist.present) {
      map['keylist'] = Variable<String>(keylist.value);
    }
    if (foodDescription.present) {
      map['food_description'] = Variable<String>(foodDescription.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdByUserId.present) {
      map['created_by_user_id'] = Variable<int>(createdByUserId.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<int>(isVerified.value);
    }
    if (isKetoFriendly.present) {
      map['is_keto_friendly'] = Variable<int>(isKetoFriendly.value);
    }
    if (energyKcal.present) {
      map['energy_kcal'] = Variable<double>(energyKcal.value);
    }
    if (totalProteinG.present) {
      map['total_protein_g'] = Variable<double>(totalProteinG.value);
    }
    if (totalFatG.present) {
      map['total_fat_g'] = Variable<double>(totalFatG.value);
    }
    if (totalCarbohydrateG.present) {
      map['total_carbohydrate_g'] = Variable<double>(totalCarbohydrateG.value);
    }
    if (dietaryFiberG.present) {
      map['dietary_fiber_g'] = Variable<double>(dietaryFiberG.value);
    }
    if (sugarG.present) {
      map['sugar_g'] = Variable<double>(sugarG.value);
    }
    if (addedSugarG.present) {
      map['added_sugar_g'] = Variable<double>(addedSugarG.value);
    }
    if (netCarbsG.present) {
      map['net_carbs_g'] = Variable<double>(netCarbsG.value);
    }
    if (saturatedFatG.present) {
      map['saturated_fat_g'] = Variable<double>(saturatedFatG.value);
    }
    if (monounsaturatedFatG.present) {
      map['monounsaturated_fat_g'] =
          Variable<double>(monounsaturatedFatG.value);
    }
    if (polyunsaturatedFatG.present) {
      map['polyunsaturated_fat_g'] =
          Variable<double>(polyunsaturatedFatG.value);
    }
    if (transFatG.present) {
      map['trans_fat_g'] = Variable<double>(transFatG.value);
    }
    if (cholesterolMg.present) {
      map['cholesterol_mg'] = Variable<double>(cholesterolMg.value);
    }
    if (sodiumMg.present) {
      map['sodium_mg'] = Variable<double>(sodiumMg.value);
    }
    if (potassiumMg.present) {
      map['potassium_mg'] = Variable<double>(potassiumMg.value);
    }
    if (magnesiumMg.present) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg.value);
    }
    if (calciumMg.present) {
      map['calcium_mg'] = Variable<double>(calciumMg.value);
    }
    if (glycemicIndex.present) {
      map['glycemic_index'] = Variable<int>(glycemicIndex.value);
    }
    if (glycemicLoad.present) {
      map['glycemic_load'] = Variable<double>(glycemicLoad.value);
    }
    if (vitamins.present) {
      map['vitamins'] = Variable<String>(vitamins.value);
    }
    if (minerals.present) {
      map['minerals'] = Variable<String>(minerals.value);
    }
    if (foodPhotoUrl.present) {
      map['food_photo_url'] = Variable<String>(foodPhotoUrl.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsCompanion(')
          ..write('foodId: $foodId, ')
          ..write('keylist: $keylist, ')
          ..write('foodDescription: $foodDescription, ')
          ..write('source: $source, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('isVerified: $isVerified, ')
          ..write('isKetoFriendly: $isKetoFriendly, ')
          ..write('energyKcal: $energyKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('totalCarbohydrateG: $totalCarbohydrateG, ')
          ..write('dietaryFiberG: $dietaryFiberG, ')
          ..write('sugarG: $sugarG, ')
          ..write('addedSugarG: $addedSugarG, ')
          ..write('netCarbsG: $netCarbsG, ')
          ..write('saturatedFatG: $saturatedFatG, ')
          ..write('monounsaturatedFatG: $monounsaturatedFatG, ')
          ..write('polyunsaturatedFatG: $polyunsaturatedFatG, ')
          ..write('transFatG: $transFatG, ')
          ..write('cholesterolMg: $cholesterolMg, ')
          ..write('sodiumMg: $sodiumMg, ')
          ..write('potassiumMg: $potassiumMg, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('calciumMg: $calciumMg, ')
          ..write('glycemicIndex: $glycemicIndex, ')
          ..write('glycemicLoad: $glycemicLoad, ')
          ..write('vitamins: $vitamins, ')
          ..write('minerals: $minerals, ')
          ..write('foodPhotoUrl: $foodPhotoUrl, ')
          ..write('barcode: $barcode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodPortionsTable extends FoodPortions
    with TableInfo<$FoodPortionsTable, FoodPortion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodPortionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _portionIdMeta =
      const VerificationMeta('portionId');
  @override
  late final GeneratedColumn<int> portionId = GeneratedColumn<int>(
      'portion_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _portionAmountMeta =
      const VerificationMeta('portionAmount');
  @override
  late final GeneratedColumn<double> portionAmount = GeneratedColumn<double>(
      'portion_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _portionUnitMeta =
      const VerificationMeta('portionUnit');
  @override
  late final GeneratedColumn<String> portionUnit = GeneratedColumn<String>(
      'portion_unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _portionDescriptionMeta =
      const VerificationMeta('portionDescription');
  @override
  late final GeneratedColumn<String> portionDescription =
      GeneratedColumn<String>('portion_description', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _portionGramWeightMeta =
      const VerificationMeta('portionGramWeight');
  @override
  late final GeneratedColumn<double> portionGramWeight =
      GeneratedColumn<double>('portion_gram_weight', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _energyKcalMeta =
      const VerificationMeta('energyKcal');
  @override
  late final GeneratedColumn<double> energyKcal = GeneratedColumn<double>(
      'energy_kcal', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _proteinGMeta =
      const VerificationMeta('proteinG');
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
      'protein_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
      'fat_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _carbohydrateGMeta =
      const VerificationMeta('carbohydrateG');
  @override
  late final GeneratedColumn<double> carbohydrateG = GeneratedColumn<double>(
      'carbohydrate_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _netCarbsGMeta =
      const VerificationMeta('netCarbsG');
  @override
  late final GeneratedColumn<double> netCarbsG = GeneratedColumn<double>(
      'net_carbs_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<int> isDefault = GeneratedColumn<int>(
      'is_default', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  @override
  List<GeneratedColumn> get $columns => [
        portionId,
        foodId,
        portionAmount,
        portionUnit,
        portionDescription,
        portionGramWeight,
        energyKcal,
        proteinG,
        fatG,
        carbohydrateG,
        netCarbsG,
        isDefault,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_portions';
  @override
  VerificationContext validateIntegrity(Insertable<FoodPortion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('portion_id')) {
      context.handle(_portionIdMeta,
          portionId.isAcceptableOrUnknown(data['portion_id']!, _portionIdMeta));
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('portion_amount')) {
      context.handle(
          _portionAmountMeta,
          portionAmount.isAcceptableOrUnknown(
              data['portion_amount']!, _portionAmountMeta));
    } else if (isInserting) {
      context.missing(_portionAmountMeta);
    }
    if (data.containsKey('portion_unit')) {
      context.handle(
          _portionUnitMeta,
          portionUnit.isAcceptableOrUnknown(
              data['portion_unit']!, _portionUnitMeta));
    } else if (isInserting) {
      context.missing(_portionUnitMeta);
    }
    if (data.containsKey('portion_description')) {
      context.handle(
          _portionDescriptionMeta,
          portionDescription.isAcceptableOrUnknown(
              data['portion_description']!, _portionDescriptionMeta));
    }
    if (data.containsKey('portion_gram_weight')) {
      context.handle(
          _portionGramWeightMeta,
          portionGramWeight.isAcceptableOrUnknown(
              data['portion_gram_weight']!, _portionGramWeightMeta));
    } else if (isInserting) {
      context.missing(_portionGramWeightMeta);
    }
    if (data.containsKey('energy_kcal')) {
      context.handle(
          _energyKcalMeta,
          energyKcal.isAcceptableOrUnknown(
              data['energy_kcal']!, _energyKcalMeta));
    }
    if (data.containsKey('protein_g')) {
      context.handle(_proteinGMeta,
          proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta));
    }
    if (data.containsKey('fat_g')) {
      context.handle(
          _fatGMeta, fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta));
    }
    if (data.containsKey('carbohydrate_g')) {
      context.handle(
          _carbohydrateGMeta,
          carbohydrateG.isAcceptableOrUnknown(
              data['carbohydrate_g']!, _carbohydrateGMeta));
    }
    if (data.containsKey('net_carbs_g')) {
      context.handle(
          _netCarbsGMeta,
          netCarbsG.isAcceptableOrUnknown(
              data['net_carbs_g']!, _netCarbsGMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {portionId};
  @override
  FoodPortion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodPortion(
      portionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}portion_id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      portionAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}portion_amount'])!,
      portionUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}portion_unit'])!,
      portionDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}portion_description']),
      portionGramWeight: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}portion_gram_weight'])!,
      energyKcal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}energy_kcal']),
      proteinG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein_g']),
      fatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_g']),
      carbohydrateG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbohydrate_g']),
      netCarbsG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}net_carbs_g']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FoodPortionsTable createAlias(String alias) {
    return $FoodPortionsTable(attachedDatabase, alias);
  }
}

class FoodPortion extends DataClass implements Insertable<FoodPortion> {
  final int portionId;
  final int foodId;
  final double portionAmount;
  final String portionUnit;
  final String? portionDescription;
  final double portionGramWeight;
  final double? energyKcal;
  final double? proteinG;
  final double? fatG;
  final double? carbohydrateG;
  final double? netCarbsG;
  final int isDefault;
  final String createdAt;
  const FoodPortion(
      {required this.portionId,
      required this.foodId,
      required this.portionAmount,
      required this.portionUnit,
      this.portionDescription,
      required this.portionGramWeight,
      this.energyKcal,
      this.proteinG,
      this.fatG,
      this.carbohydrateG,
      this.netCarbsG,
      required this.isDefault,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['portion_id'] = Variable<int>(portionId);
    map['food_id'] = Variable<int>(foodId);
    map['portion_amount'] = Variable<double>(portionAmount);
    map['portion_unit'] = Variable<String>(portionUnit);
    if (!nullToAbsent || portionDescription != null) {
      map['portion_description'] = Variable<String>(portionDescription);
    }
    map['portion_gram_weight'] = Variable<double>(portionGramWeight);
    if (!nullToAbsent || energyKcal != null) {
      map['energy_kcal'] = Variable<double>(energyKcal);
    }
    if (!nullToAbsent || proteinG != null) {
      map['protein_g'] = Variable<double>(proteinG);
    }
    if (!nullToAbsent || fatG != null) {
      map['fat_g'] = Variable<double>(fatG);
    }
    if (!nullToAbsent || carbohydrateG != null) {
      map['carbohydrate_g'] = Variable<double>(carbohydrateG);
    }
    if (!nullToAbsent || netCarbsG != null) {
      map['net_carbs_g'] = Variable<double>(netCarbsG);
    }
    map['is_default'] = Variable<int>(isDefault);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  FoodPortionsCompanion toCompanion(bool nullToAbsent) {
    return FoodPortionsCompanion(
      portionId: Value(portionId),
      foodId: Value(foodId),
      portionAmount: Value(portionAmount),
      portionUnit: Value(portionUnit),
      portionDescription: portionDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(portionDescription),
      portionGramWeight: Value(portionGramWeight),
      energyKcal: energyKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(energyKcal),
      proteinG: proteinG == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinG),
      fatG: fatG == null && nullToAbsent ? const Value.absent() : Value(fatG),
      carbohydrateG: carbohydrateG == null && nullToAbsent
          ? const Value.absent()
          : Value(carbohydrateG),
      netCarbsG: netCarbsG == null && nullToAbsent
          ? const Value.absent()
          : Value(netCarbsG),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
    );
  }

  factory FoodPortion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodPortion(
      portionId: serializer.fromJson<int>(json['portionId']),
      foodId: serializer.fromJson<int>(json['foodId']),
      portionAmount: serializer.fromJson<double>(json['portionAmount']),
      portionUnit: serializer.fromJson<String>(json['portionUnit']),
      portionDescription:
          serializer.fromJson<String?>(json['portionDescription']),
      portionGramWeight: serializer.fromJson<double>(json['portionGramWeight']),
      energyKcal: serializer.fromJson<double?>(json['energyKcal']),
      proteinG: serializer.fromJson<double?>(json['proteinG']),
      fatG: serializer.fromJson<double?>(json['fatG']),
      carbohydrateG: serializer.fromJson<double?>(json['carbohydrateG']),
      netCarbsG: serializer.fromJson<double?>(json['netCarbsG']),
      isDefault: serializer.fromJson<int>(json['isDefault']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'portionId': serializer.toJson<int>(portionId),
      'foodId': serializer.toJson<int>(foodId),
      'portionAmount': serializer.toJson<double>(portionAmount),
      'portionUnit': serializer.toJson<String>(portionUnit),
      'portionDescription': serializer.toJson<String?>(portionDescription),
      'portionGramWeight': serializer.toJson<double>(portionGramWeight),
      'energyKcal': serializer.toJson<double?>(energyKcal),
      'proteinG': serializer.toJson<double?>(proteinG),
      'fatG': serializer.toJson<double?>(fatG),
      'carbohydrateG': serializer.toJson<double?>(carbohydrateG),
      'netCarbsG': serializer.toJson<double?>(netCarbsG),
      'isDefault': serializer.toJson<int>(isDefault),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  FoodPortion copyWith(
          {int? portionId,
          int? foodId,
          double? portionAmount,
          String? portionUnit,
          Value<String?> portionDescription = const Value.absent(),
          double? portionGramWeight,
          Value<double?> energyKcal = const Value.absent(),
          Value<double?> proteinG = const Value.absent(),
          Value<double?> fatG = const Value.absent(),
          Value<double?> carbohydrateG = const Value.absent(),
          Value<double?> netCarbsG = const Value.absent(),
          int? isDefault,
          String? createdAt}) =>
      FoodPortion(
        portionId: portionId ?? this.portionId,
        foodId: foodId ?? this.foodId,
        portionAmount: portionAmount ?? this.portionAmount,
        portionUnit: portionUnit ?? this.portionUnit,
        portionDescription: portionDescription.present
            ? portionDescription.value
            : this.portionDescription,
        portionGramWeight: portionGramWeight ?? this.portionGramWeight,
        energyKcal: energyKcal.present ? energyKcal.value : this.energyKcal,
        proteinG: proteinG.present ? proteinG.value : this.proteinG,
        fatG: fatG.present ? fatG.value : this.fatG,
        carbohydrateG:
            carbohydrateG.present ? carbohydrateG.value : this.carbohydrateG,
        netCarbsG: netCarbsG.present ? netCarbsG.value : this.netCarbsG,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt ?? this.createdAt,
      );
  FoodPortion copyWithCompanion(FoodPortionsCompanion data) {
    return FoodPortion(
      portionId: data.portionId.present ? data.portionId.value : this.portionId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      portionAmount: data.portionAmount.present
          ? data.portionAmount.value
          : this.portionAmount,
      portionUnit:
          data.portionUnit.present ? data.portionUnit.value : this.portionUnit,
      portionDescription: data.portionDescription.present
          ? data.portionDescription.value
          : this.portionDescription,
      portionGramWeight: data.portionGramWeight.present
          ? data.portionGramWeight.value
          : this.portionGramWeight,
      energyKcal:
          data.energyKcal.present ? data.energyKcal.value : this.energyKcal,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      carbohydrateG: data.carbohydrateG.present
          ? data.carbohydrateG.value
          : this.carbohydrateG,
      netCarbsG: data.netCarbsG.present ? data.netCarbsG.value : this.netCarbsG,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodPortion(')
          ..write('portionId: $portionId, ')
          ..write('foodId: $foodId, ')
          ..write('portionAmount: $portionAmount, ')
          ..write('portionUnit: $portionUnit, ')
          ..write('portionDescription: $portionDescription, ')
          ..write('portionGramWeight: $portionGramWeight, ')
          ..write('energyKcal: $energyKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('fatG: $fatG, ')
          ..write('carbohydrateG: $carbohydrateG, ')
          ..write('netCarbsG: $netCarbsG, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      portionId,
      foodId,
      portionAmount,
      portionUnit,
      portionDescription,
      portionGramWeight,
      energyKcal,
      proteinG,
      fatG,
      carbohydrateG,
      netCarbsG,
      isDefault,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodPortion &&
          other.portionId == this.portionId &&
          other.foodId == this.foodId &&
          other.portionAmount == this.portionAmount &&
          other.portionUnit == this.portionUnit &&
          other.portionDescription == this.portionDescription &&
          other.portionGramWeight == this.portionGramWeight &&
          other.energyKcal == this.energyKcal &&
          other.proteinG == this.proteinG &&
          other.fatG == this.fatG &&
          other.carbohydrateG == this.carbohydrateG &&
          other.netCarbsG == this.netCarbsG &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt);
}

class FoodPortionsCompanion extends UpdateCompanion<FoodPortion> {
  final Value<int> portionId;
  final Value<int> foodId;
  final Value<double> portionAmount;
  final Value<String> portionUnit;
  final Value<String?> portionDescription;
  final Value<double> portionGramWeight;
  final Value<double?> energyKcal;
  final Value<double?> proteinG;
  final Value<double?> fatG;
  final Value<double?> carbohydrateG;
  final Value<double?> netCarbsG;
  final Value<int> isDefault;
  final Value<String> createdAt;
  const FoodPortionsCompanion({
    this.portionId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.portionAmount = const Value.absent(),
    this.portionUnit = const Value.absent(),
    this.portionDescription = const Value.absent(),
    this.portionGramWeight = const Value.absent(),
    this.energyKcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.carbohydrateG = const Value.absent(),
    this.netCarbsG = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FoodPortionsCompanion.insert({
    this.portionId = const Value.absent(),
    required int foodId,
    required double portionAmount,
    required String portionUnit,
    this.portionDescription = const Value.absent(),
    required double portionGramWeight,
    this.energyKcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.carbohydrateG = const Value.absent(),
    this.netCarbsG = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : foodId = Value(foodId),
        portionAmount = Value(portionAmount),
        portionUnit = Value(portionUnit),
        portionGramWeight = Value(portionGramWeight);
  static Insertable<FoodPortion> custom({
    Expression<int>? portionId,
    Expression<int>? foodId,
    Expression<double>? portionAmount,
    Expression<String>? portionUnit,
    Expression<String>? portionDescription,
    Expression<double>? portionGramWeight,
    Expression<double>? energyKcal,
    Expression<double>? proteinG,
    Expression<double>? fatG,
    Expression<double>? carbohydrateG,
    Expression<double>? netCarbsG,
    Expression<int>? isDefault,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (portionId != null) 'portion_id': portionId,
      if (foodId != null) 'food_id': foodId,
      if (portionAmount != null) 'portion_amount': portionAmount,
      if (portionUnit != null) 'portion_unit': portionUnit,
      if (portionDescription != null) 'portion_description': portionDescription,
      if (portionGramWeight != null) 'portion_gram_weight': portionGramWeight,
      if (energyKcal != null) 'energy_kcal': energyKcal,
      if (proteinG != null) 'protein_g': proteinG,
      if (fatG != null) 'fat_g': fatG,
      if (carbohydrateG != null) 'carbohydrate_g': carbohydrateG,
      if (netCarbsG != null) 'net_carbs_g': netCarbsG,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FoodPortionsCompanion copyWith(
      {Value<int>? portionId,
      Value<int>? foodId,
      Value<double>? portionAmount,
      Value<String>? portionUnit,
      Value<String?>? portionDescription,
      Value<double>? portionGramWeight,
      Value<double?>? energyKcal,
      Value<double?>? proteinG,
      Value<double?>? fatG,
      Value<double?>? carbohydrateG,
      Value<double?>? netCarbsG,
      Value<int>? isDefault,
      Value<String>? createdAt}) {
    return FoodPortionsCompanion(
      portionId: portionId ?? this.portionId,
      foodId: foodId ?? this.foodId,
      portionAmount: portionAmount ?? this.portionAmount,
      portionUnit: portionUnit ?? this.portionUnit,
      portionDescription: portionDescription ?? this.portionDescription,
      portionGramWeight: portionGramWeight ?? this.portionGramWeight,
      energyKcal: energyKcal ?? this.energyKcal,
      proteinG: proteinG ?? this.proteinG,
      fatG: fatG ?? this.fatG,
      carbohydrateG: carbohydrateG ?? this.carbohydrateG,
      netCarbsG: netCarbsG ?? this.netCarbsG,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (portionId.present) {
      map['portion_id'] = Variable<int>(portionId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (portionAmount.present) {
      map['portion_amount'] = Variable<double>(portionAmount.value);
    }
    if (portionUnit.present) {
      map['portion_unit'] = Variable<String>(portionUnit.value);
    }
    if (portionDescription.present) {
      map['portion_description'] = Variable<String>(portionDescription.value);
    }
    if (portionGramWeight.present) {
      map['portion_gram_weight'] = Variable<double>(portionGramWeight.value);
    }
    if (energyKcal.present) {
      map['energy_kcal'] = Variable<double>(energyKcal.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<double>(fatG.value);
    }
    if (carbohydrateG.present) {
      map['carbohydrate_g'] = Variable<double>(carbohydrateG.value);
    }
    if (netCarbsG.present) {
      map['net_carbs_g'] = Variable<double>(netCarbsG.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<int>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodPortionsCompanion(')
          ..write('portionId: $portionId, ')
          ..write('foodId: $foodId, ')
          ..write('portionAmount: $portionAmount, ')
          ..write('portionUnit: $portionUnit, ')
          ..write('portionDescription: $portionDescription, ')
          ..write('portionGramWeight: $portionGramWeight, ')
          ..write('energyKcal: $energyKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('fatG: $fatG, ')
          ..write('carbohydrateG: $carbohydrateG, ')
          ..write('netCarbsG: $netCarbsG, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DietEntriesTable extends DietEntries
    with TableInfo<$DietEntriesTable, DietEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DietEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
      'entry_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<String> recordedAt = GeneratedColumn<String>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _portionIdMeta =
      const VerificationMeta('portionId');
  @override
  late final GeneratedColumn<int> portionId = GeneratedColumn<int>(
      'portion_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _customPortionGramsMeta =
      const VerificationMeta('customPortionGrams');
  @override
  late final GeneratedColumn<double> customPortionGrams =
      GeneratedColumn<double>('custom_portion_grams', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _servingSizeMultiplierMeta =
      const VerificationMeta('servingSizeMultiplier');
  @override
  late final GeneratedColumn<double> servingSizeMultiplier =
      GeneratedColumn<double>('serving_size_multiplier', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(1.0));
  static const VerificationMeta _totalEnergyKcalMeta =
      const VerificationMeta('totalEnergyKcal');
  @override
  late final GeneratedColumn<double> totalEnergyKcal = GeneratedColumn<double>(
      'total_energy_kcal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalProteinGMeta =
      const VerificationMeta('totalProteinG');
  @override
  late final GeneratedColumn<double> totalProteinG = GeneratedColumn<double>(
      'total_protein_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalFatGMeta =
      const VerificationMeta('totalFatG');
  @override
  late final GeneratedColumn<double> totalFatG = GeneratedColumn<double>(
      'total_fat_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalCarbohydrateGMeta =
      const VerificationMeta('totalCarbohydrateG');
  @override
  late final GeneratedColumn<double> totalCarbohydrateG =
      GeneratedColumn<double>('total_carbohydrate_g', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalNetCarbsGMeta =
      const VerificationMeta('totalNetCarbsG');
  @override
  late final GeneratedColumn<double> totalNetCarbsG = GeneratedColumn<double>(
      'total_net_carbs_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalFiberGMeta =
      const VerificationMeta('totalFiberG');
  @override
  late final GeneratedColumn<double> totalFiberG = GeneratedColumn<double>(
      'total_fiber_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _totalSodiumMgMeta =
      const VerificationMeta('totalSodiumMg');
  @override
  late final GeneratedColumn<double> totalSodiumMg = GeneratedColumn<double>(
      'total_sodium_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _mealContextMeta =
      const VerificationMeta('mealContext');
  @override
  late final GeneratedColumn<String> mealContext = GeneratedColumn<String>(
      'meal_context', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _foodPhotoUrlMeta =
      const VerificationMeta('foodPhotoUrl');
  @override
  late final GeneratedColumn<String> foodPhotoUrl = GeneratedColumn<String>(
      'food_photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<int> synced = GeneratedColumn<int>(
      'synced', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  @override
  List<GeneratedColumn> get $columns => [
        entryId,
        userId,
        foodId,
        recordedAt,
        date,
        portionId,
        customPortionGrams,
        servingSizeMultiplier,
        totalEnergyKcal,
        totalProteinG,
        totalFatG,
        totalCarbohydrateG,
        totalNetCarbsG,
        totalFiberG,
        totalSodiumMg,
        mealContext,
        location,
        notes,
        foodPhotoUrl,
        synced,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diet_entries';
  @override
  VerificationContext validateIntegrity(Insertable<DietEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('portion_id')) {
      context.handle(_portionIdMeta,
          portionId.isAcceptableOrUnknown(data['portion_id']!, _portionIdMeta));
    }
    if (data.containsKey('custom_portion_grams')) {
      context.handle(
          _customPortionGramsMeta,
          customPortionGrams.isAcceptableOrUnknown(
              data['custom_portion_grams']!, _customPortionGramsMeta));
    }
    if (data.containsKey('serving_size_multiplier')) {
      context.handle(
          _servingSizeMultiplierMeta,
          servingSizeMultiplier.isAcceptableOrUnknown(
              data['serving_size_multiplier']!, _servingSizeMultiplierMeta));
    }
    if (data.containsKey('total_energy_kcal')) {
      context.handle(
          _totalEnergyKcalMeta,
          totalEnergyKcal.isAcceptableOrUnknown(
              data['total_energy_kcal']!, _totalEnergyKcalMeta));
    } else if (isInserting) {
      context.missing(_totalEnergyKcalMeta);
    }
    if (data.containsKey('total_protein_g')) {
      context.handle(
          _totalProteinGMeta,
          totalProteinG.isAcceptableOrUnknown(
              data['total_protein_g']!, _totalProteinGMeta));
    } else if (isInserting) {
      context.missing(_totalProteinGMeta);
    }
    if (data.containsKey('total_fat_g')) {
      context.handle(
          _totalFatGMeta,
          totalFatG.isAcceptableOrUnknown(
              data['total_fat_g']!, _totalFatGMeta));
    } else if (isInserting) {
      context.missing(_totalFatGMeta);
    }
    if (data.containsKey('total_carbohydrate_g')) {
      context.handle(
          _totalCarbohydrateGMeta,
          totalCarbohydrateG.isAcceptableOrUnknown(
              data['total_carbohydrate_g']!, _totalCarbohydrateGMeta));
    } else if (isInserting) {
      context.missing(_totalCarbohydrateGMeta);
    }
    if (data.containsKey('total_net_carbs_g')) {
      context.handle(
          _totalNetCarbsGMeta,
          totalNetCarbsG.isAcceptableOrUnknown(
              data['total_net_carbs_g']!, _totalNetCarbsGMeta));
    } else if (isInserting) {
      context.missing(_totalNetCarbsGMeta);
    }
    if (data.containsKey('total_fiber_g')) {
      context.handle(
          _totalFiberGMeta,
          totalFiberG.isAcceptableOrUnknown(
              data['total_fiber_g']!, _totalFiberGMeta));
    }
    if (data.containsKey('total_sodium_mg')) {
      context.handle(
          _totalSodiumMgMeta,
          totalSodiumMg.isAcceptableOrUnknown(
              data['total_sodium_mg']!, _totalSodiumMgMeta));
    }
    if (data.containsKey('meal_context')) {
      context.handle(
          _mealContextMeta,
          mealContext.isAcceptableOrUnknown(
              data['meal_context']!, _mealContextMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('food_photo_url')) {
      context.handle(
          _foodPhotoUrlMeta,
          foodPhotoUrl.isAcceptableOrUnknown(
              data['food_photo_url']!, _foodPhotoUrlMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId};
  @override
  DietEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DietEntry(
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}entry_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recorded_at'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      portionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}portion_id']),
      customPortionGrams: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}custom_portion_grams']),
      servingSizeMultiplier: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}serving_size_multiplier'])!,
      totalEnergyKcal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_energy_kcal'])!,
      totalProteinG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_protein_g'])!,
      totalFatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fat_g'])!,
      totalCarbohydrateG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_carbohydrate_g'])!,
      totalNetCarbsG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_net_carbs_g'])!,
      totalFiberG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fiber_g']),
      totalSodiumMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_sodium_mg']),
      mealContext: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal_context']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      foodPhotoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_photo_url']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DietEntriesTable createAlias(String alias) {
    return $DietEntriesTable(attachedDatabase, alias);
  }
}

class DietEntry extends DataClass implements Insertable<DietEntry> {
  final int entryId;
  final int userId;
  final int foodId;
  final String recordedAt;
  final String date;
  final int? portionId;
  final double? customPortionGrams;
  final double servingSizeMultiplier;
  final double totalEnergyKcal;
  final double totalProteinG;
  final double totalFatG;
  final double totalCarbohydrateG;
  final double totalNetCarbsG;
  final double? totalFiberG;
  final double? totalSodiumMg;
  final String? mealContext;
  final String? location;
  final String? notes;
  final String? foodPhotoUrl;
  final int synced;
  final String createdAt;
  final String updatedAt;
  const DietEntry(
      {required this.entryId,
      required this.userId,
      required this.foodId,
      required this.recordedAt,
      required this.date,
      this.portionId,
      this.customPortionGrams,
      required this.servingSizeMultiplier,
      required this.totalEnergyKcal,
      required this.totalProteinG,
      required this.totalFatG,
      required this.totalCarbohydrateG,
      required this.totalNetCarbsG,
      this.totalFiberG,
      this.totalSodiumMg,
      this.mealContext,
      this.location,
      this.notes,
      this.foodPhotoUrl,
      required this.synced,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<int>(entryId);
    map['user_id'] = Variable<int>(userId);
    map['food_id'] = Variable<int>(foodId);
    map['recorded_at'] = Variable<String>(recordedAt);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || portionId != null) {
      map['portion_id'] = Variable<int>(portionId);
    }
    if (!nullToAbsent || customPortionGrams != null) {
      map['custom_portion_grams'] = Variable<double>(customPortionGrams);
    }
    map['serving_size_multiplier'] = Variable<double>(servingSizeMultiplier);
    map['total_energy_kcal'] = Variable<double>(totalEnergyKcal);
    map['total_protein_g'] = Variable<double>(totalProteinG);
    map['total_fat_g'] = Variable<double>(totalFatG);
    map['total_carbohydrate_g'] = Variable<double>(totalCarbohydrateG);
    map['total_net_carbs_g'] = Variable<double>(totalNetCarbsG);
    if (!nullToAbsent || totalFiberG != null) {
      map['total_fiber_g'] = Variable<double>(totalFiberG);
    }
    if (!nullToAbsent || totalSodiumMg != null) {
      map['total_sodium_mg'] = Variable<double>(totalSodiumMg);
    }
    if (!nullToAbsent || mealContext != null) {
      map['meal_context'] = Variable<String>(mealContext);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || foodPhotoUrl != null) {
      map['food_photo_url'] = Variable<String>(foodPhotoUrl);
    }
    map['synced'] = Variable<int>(synced);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  DietEntriesCompanion toCompanion(bool nullToAbsent) {
    return DietEntriesCompanion(
      entryId: Value(entryId),
      userId: Value(userId),
      foodId: Value(foodId),
      recordedAt: Value(recordedAt),
      date: Value(date),
      portionId: portionId == null && nullToAbsent
          ? const Value.absent()
          : Value(portionId),
      customPortionGrams: customPortionGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(customPortionGrams),
      servingSizeMultiplier: Value(servingSizeMultiplier),
      totalEnergyKcal: Value(totalEnergyKcal),
      totalProteinG: Value(totalProteinG),
      totalFatG: Value(totalFatG),
      totalCarbohydrateG: Value(totalCarbohydrateG),
      totalNetCarbsG: Value(totalNetCarbsG),
      totalFiberG: totalFiberG == null && nullToAbsent
          ? const Value.absent()
          : Value(totalFiberG),
      totalSodiumMg: totalSodiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(totalSodiumMg),
      mealContext: mealContext == null && nullToAbsent
          ? const Value.absent()
          : Value(mealContext),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      foodPhotoUrl: foodPhotoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(foodPhotoUrl),
      synced: Value(synced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DietEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DietEntry(
      entryId: serializer.fromJson<int>(json['entryId']),
      userId: serializer.fromJson<int>(json['userId']),
      foodId: serializer.fromJson<int>(json['foodId']),
      recordedAt: serializer.fromJson<String>(json['recordedAt']),
      date: serializer.fromJson<String>(json['date']),
      portionId: serializer.fromJson<int?>(json['portionId']),
      customPortionGrams:
          serializer.fromJson<double?>(json['customPortionGrams']),
      servingSizeMultiplier:
          serializer.fromJson<double>(json['servingSizeMultiplier']),
      totalEnergyKcal: serializer.fromJson<double>(json['totalEnergyKcal']),
      totalProteinG: serializer.fromJson<double>(json['totalProteinG']),
      totalFatG: serializer.fromJson<double>(json['totalFatG']),
      totalCarbohydrateG:
          serializer.fromJson<double>(json['totalCarbohydrateG']),
      totalNetCarbsG: serializer.fromJson<double>(json['totalNetCarbsG']),
      totalFiberG: serializer.fromJson<double?>(json['totalFiberG']),
      totalSodiumMg: serializer.fromJson<double?>(json['totalSodiumMg']),
      mealContext: serializer.fromJson<String?>(json['mealContext']),
      location: serializer.fromJson<String?>(json['location']),
      notes: serializer.fromJson<String?>(json['notes']),
      foodPhotoUrl: serializer.fromJson<String?>(json['foodPhotoUrl']),
      synced: serializer.fromJson<int>(json['synced']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<int>(entryId),
      'userId': serializer.toJson<int>(userId),
      'foodId': serializer.toJson<int>(foodId),
      'recordedAt': serializer.toJson<String>(recordedAt),
      'date': serializer.toJson<String>(date),
      'portionId': serializer.toJson<int?>(portionId),
      'customPortionGrams': serializer.toJson<double?>(customPortionGrams),
      'servingSizeMultiplier': serializer.toJson<double>(servingSizeMultiplier),
      'totalEnergyKcal': serializer.toJson<double>(totalEnergyKcal),
      'totalProteinG': serializer.toJson<double>(totalProteinG),
      'totalFatG': serializer.toJson<double>(totalFatG),
      'totalCarbohydrateG': serializer.toJson<double>(totalCarbohydrateG),
      'totalNetCarbsG': serializer.toJson<double>(totalNetCarbsG),
      'totalFiberG': serializer.toJson<double?>(totalFiberG),
      'totalSodiumMg': serializer.toJson<double?>(totalSodiumMg),
      'mealContext': serializer.toJson<String?>(mealContext),
      'location': serializer.toJson<String?>(location),
      'notes': serializer.toJson<String?>(notes),
      'foodPhotoUrl': serializer.toJson<String?>(foodPhotoUrl),
      'synced': serializer.toJson<int>(synced),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  DietEntry copyWith(
          {int? entryId,
          int? userId,
          int? foodId,
          String? recordedAt,
          String? date,
          Value<int?> portionId = const Value.absent(),
          Value<double?> customPortionGrams = const Value.absent(),
          double? servingSizeMultiplier,
          double? totalEnergyKcal,
          double? totalProteinG,
          double? totalFatG,
          double? totalCarbohydrateG,
          double? totalNetCarbsG,
          Value<double?> totalFiberG = const Value.absent(),
          Value<double?> totalSodiumMg = const Value.absent(),
          Value<String?> mealContext = const Value.absent(),
          Value<String?> location = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> foodPhotoUrl = const Value.absent(),
          int? synced,
          String? createdAt,
          String? updatedAt}) =>
      DietEntry(
        entryId: entryId ?? this.entryId,
        userId: userId ?? this.userId,
        foodId: foodId ?? this.foodId,
        recordedAt: recordedAt ?? this.recordedAt,
        date: date ?? this.date,
        portionId: portionId.present ? portionId.value : this.portionId,
        customPortionGrams: customPortionGrams.present
            ? customPortionGrams.value
            : this.customPortionGrams,
        servingSizeMultiplier:
            servingSizeMultiplier ?? this.servingSizeMultiplier,
        totalEnergyKcal: totalEnergyKcal ?? this.totalEnergyKcal,
        totalProteinG: totalProteinG ?? this.totalProteinG,
        totalFatG: totalFatG ?? this.totalFatG,
        totalCarbohydrateG: totalCarbohydrateG ?? this.totalCarbohydrateG,
        totalNetCarbsG: totalNetCarbsG ?? this.totalNetCarbsG,
        totalFiberG: totalFiberG.present ? totalFiberG.value : this.totalFiberG,
        totalSodiumMg:
            totalSodiumMg.present ? totalSodiumMg.value : this.totalSodiumMg,
        mealContext: mealContext.present ? mealContext.value : this.mealContext,
        location: location.present ? location.value : this.location,
        notes: notes.present ? notes.value : this.notes,
        foodPhotoUrl:
            foodPhotoUrl.present ? foodPhotoUrl.value : this.foodPhotoUrl,
        synced: synced ?? this.synced,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DietEntry copyWithCompanion(DietEntriesCompanion data) {
    return DietEntry(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      userId: data.userId.present ? data.userId.value : this.userId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      date: data.date.present ? data.date.value : this.date,
      portionId: data.portionId.present ? data.portionId.value : this.portionId,
      customPortionGrams: data.customPortionGrams.present
          ? data.customPortionGrams.value
          : this.customPortionGrams,
      servingSizeMultiplier: data.servingSizeMultiplier.present
          ? data.servingSizeMultiplier.value
          : this.servingSizeMultiplier,
      totalEnergyKcal: data.totalEnergyKcal.present
          ? data.totalEnergyKcal.value
          : this.totalEnergyKcal,
      totalProteinG: data.totalProteinG.present
          ? data.totalProteinG.value
          : this.totalProteinG,
      totalFatG: data.totalFatG.present ? data.totalFatG.value : this.totalFatG,
      totalCarbohydrateG: data.totalCarbohydrateG.present
          ? data.totalCarbohydrateG.value
          : this.totalCarbohydrateG,
      totalNetCarbsG: data.totalNetCarbsG.present
          ? data.totalNetCarbsG.value
          : this.totalNetCarbsG,
      totalFiberG:
          data.totalFiberG.present ? data.totalFiberG.value : this.totalFiberG,
      totalSodiumMg: data.totalSodiumMg.present
          ? data.totalSodiumMg.value
          : this.totalSodiumMg,
      mealContext:
          data.mealContext.present ? data.mealContext.value : this.mealContext,
      location: data.location.present ? data.location.value : this.location,
      notes: data.notes.present ? data.notes.value : this.notes,
      foodPhotoUrl: data.foodPhotoUrl.present
          ? data.foodPhotoUrl.value
          : this.foodPhotoUrl,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DietEntry(')
          ..write('entryId: $entryId, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('date: $date, ')
          ..write('portionId: $portionId, ')
          ..write('customPortionGrams: $customPortionGrams, ')
          ..write('servingSizeMultiplier: $servingSizeMultiplier, ')
          ..write('totalEnergyKcal: $totalEnergyKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('totalCarbohydrateG: $totalCarbohydrateG, ')
          ..write('totalNetCarbsG: $totalNetCarbsG, ')
          ..write('totalFiberG: $totalFiberG, ')
          ..write('totalSodiumMg: $totalSodiumMg, ')
          ..write('mealContext: $mealContext, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('foodPhotoUrl: $foodPhotoUrl, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        entryId,
        userId,
        foodId,
        recordedAt,
        date,
        portionId,
        customPortionGrams,
        servingSizeMultiplier,
        totalEnergyKcal,
        totalProteinG,
        totalFatG,
        totalCarbohydrateG,
        totalNetCarbsG,
        totalFiberG,
        totalSodiumMg,
        mealContext,
        location,
        notes,
        foodPhotoUrl,
        synced,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DietEntry &&
          other.entryId == this.entryId &&
          other.userId == this.userId &&
          other.foodId == this.foodId &&
          other.recordedAt == this.recordedAt &&
          other.date == this.date &&
          other.portionId == this.portionId &&
          other.customPortionGrams == this.customPortionGrams &&
          other.servingSizeMultiplier == this.servingSizeMultiplier &&
          other.totalEnergyKcal == this.totalEnergyKcal &&
          other.totalProteinG == this.totalProteinG &&
          other.totalFatG == this.totalFatG &&
          other.totalCarbohydrateG == this.totalCarbohydrateG &&
          other.totalNetCarbsG == this.totalNetCarbsG &&
          other.totalFiberG == this.totalFiberG &&
          other.totalSodiumMg == this.totalSodiumMg &&
          other.mealContext == this.mealContext &&
          other.location == this.location &&
          other.notes == this.notes &&
          other.foodPhotoUrl == this.foodPhotoUrl &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DietEntriesCompanion extends UpdateCompanion<DietEntry> {
  final Value<int> entryId;
  final Value<int> userId;
  final Value<int> foodId;
  final Value<String> recordedAt;
  final Value<String> date;
  final Value<int?> portionId;
  final Value<double?> customPortionGrams;
  final Value<double> servingSizeMultiplier;
  final Value<double> totalEnergyKcal;
  final Value<double> totalProteinG;
  final Value<double> totalFatG;
  final Value<double> totalCarbohydrateG;
  final Value<double> totalNetCarbsG;
  final Value<double?> totalFiberG;
  final Value<double?> totalSodiumMg;
  final Value<String?> mealContext;
  final Value<String?> location;
  final Value<String?> notes;
  final Value<String?> foodPhotoUrl;
  final Value<int> synced;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const DietEntriesCompanion({
    this.entryId = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.date = const Value.absent(),
    this.portionId = const Value.absent(),
    this.customPortionGrams = const Value.absent(),
    this.servingSizeMultiplier = const Value.absent(),
    this.totalEnergyKcal = const Value.absent(),
    this.totalProteinG = const Value.absent(),
    this.totalFatG = const Value.absent(),
    this.totalCarbohydrateG = const Value.absent(),
    this.totalNetCarbsG = const Value.absent(),
    this.totalFiberG = const Value.absent(),
    this.totalSodiumMg = const Value.absent(),
    this.mealContext = const Value.absent(),
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.foodPhotoUrl = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DietEntriesCompanion.insert({
    this.entryId = const Value.absent(),
    required int userId,
    required int foodId,
    required String recordedAt,
    required String date,
    this.portionId = const Value.absent(),
    this.customPortionGrams = const Value.absent(),
    this.servingSizeMultiplier = const Value.absent(),
    required double totalEnergyKcal,
    required double totalProteinG,
    required double totalFatG,
    required double totalCarbohydrateG,
    required double totalNetCarbsG,
    this.totalFiberG = const Value.absent(),
    this.totalSodiumMg = const Value.absent(),
    this.mealContext = const Value.absent(),
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.foodPhotoUrl = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        foodId = Value(foodId),
        recordedAt = Value(recordedAt),
        date = Value(date),
        totalEnergyKcal = Value(totalEnergyKcal),
        totalProteinG = Value(totalProteinG),
        totalFatG = Value(totalFatG),
        totalCarbohydrateG = Value(totalCarbohydrateG),
        totalNetCarbsG = Value(totalNetCarbsG);
  static Insertable<DietEntry> custom({
    Expression<int>? entryId,
    Expression<int>? userId,
    Expression<int>? foodId,
    Expression<String>? recordedAt,
    Expression<String>? date,
    Expression<int>? portionId,
    Expression<double>? customPortionGrams,
    Expression<double>? servingSizeMultiplier,
    Expression<double>? totalEnergyKcal,
    Expression<double>? totalProteinG,
    Expression<double>? totalFatG,
    Expression<double>? totalCarbohydrateG,
    Expression<double>? totalNetCarbsG,
    Expression<double>? totalFiberG,
    Expression<double>? totalSodiumMg,
    Expression<String>? mealContext,
    Expression<String>? location,
    Expression<String>? notes,
    Expression<String>? foodPhotoUrl,
    Expression<int>? synced,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (userId != null) 'user_id': userId,
      if (foodId != null) 'food_id': foodId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (date != null) 'date': date,
      if (portionId != null) 'portion_id': portionId,
      if (customPortionGrams != null)
        'custom_portion_grams': customPortionGrams,
      if (servingSizeMultiplier != null)
        'serving_size_multiplier': servingSizeMultiplier,
      if (totalEnergyKcal != null) 'total_energy_kcal': totalEnergyKcal,
      if (totalProteinG != null) 'total_protein_g': totalProteinG,
      if (totalFatG != null) 'total_fat_g': totalFatG,
      if (totalCarbohydrateG != null)
        'total_carbohydrate_g': totalCarbohydrateG,
      if (totalNetCarbsG != null) 'total_net_carbs_g': totalNetCarbsG,
      if (totalFiberG != null) 'total_fiber_g': totalFiberG,
      if (totalSodiumMg != null) 'total_sodium_mg': totalSodiumMg,
      if (mealContext != null) 'meal_context': mealContext,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
      if (foodPhotoUrl != null) 'food_photo_url': foodPhotoUrl,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DietEntriesCompanion copyWith(
      {Value<int>? entryId,
      Value<int>? userId,
      Value<int>? foodId,
      Value<String>? recordedAt,
      Value<String>? date,
      Value<int?>? portionId,
      Value<double?>? customPortionGrams,
      Value<double>? servingSizeMultiplier,
      Value<double>? totalEnergyKcal,
      Value<double>? totalProteinG,
      Value<double>? totalFatG,
      Value<double>? totalCarbohydrateG,
      Value<double>? totalNetCarbsG,
      Value<double?>? totalFiberG,
      Value<double?>? totalSodiumMg,
      Value<String?>? mealContext,
      Value<String?>? location,
      Value<String?>? notes,
      Value<String?>? foodPhotoUrl,
      Value<int>? synced,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return DietEntriesCompanion(
      entryId: entryId ?? this.entryId,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      recordedAt: recordedAt ?? this.recordedAt,
      date: date ?? this.date,
      portionId: portionId ?? this.portionId,
      customPortionGrams: customPortionGrams ?? this.customPortionGrams,
      servingSizeMultiplier:
          servingSizeMultiplier ?? this.servingSizeMultiplier,
      totalEnergyKcal: totalEnergyKcal ?? this.totalEnergyKcal,
      totalProteinG: totalProteinG ?? this.totalProteinG,
      totalFatG: totalFatG ?? this.totalFatG,
      totalCarbohydrateG: totalCarbohydrateG ?? this.totalCarbohydrateG,
      totalNetCarbsG: totalNetCarbsG ?? this.totalNetCarbsG,
      totalFiberG: totalFiberG ?? this.totalFiberG,
      totalSodiumMg: totalSodiumMg ?? this.totalSodiumMg,
      mealContext: mealContext ?? this.mealContext,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      foodPhotoUrl: foodPhotoUrl ?? this.foodPhotoUrl,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<String>(recordedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (portionId.present) {
      map['portion_id'] = Variable<int>(portionId.value);
    }
    if (customPortionGrams.present) {
      map['custom_portion_grams'] = Variable<double>(customPortionGrams.value);
    }
    if (servingSizeMultiplier.present) {
      map['serving_size_multiplier'] =
          Variable<double>(servingSizeMultiplier.value);
    }
    if (totalEnergyKcal.present) {
      map['total_energy_kcal'] = Variable<double>(totalEnergyKcal.value);
    }
    if (totalProteinG.present) {
      map['total_protein_g'] = Variable<double>(totalProteinG.value);
    }
    if (totalFatG.present) {
      map['total_fat_g'] = Variable<double>(totalFatG.value);
    }
    if (totalCarbohydrateG.present) {
      map['total_carbohydrate_g'] = Variable<double>(totalCarbohydrateG.value);
    }
    if (totalNetCarbsG.present) {
      map['total_net_carbs_g'] = Variable<double>(totalNetCarbsG.value);
    }
    if (totalFiberG.present) {
      map['total_fiber_g'] = Variable<double>(totalFiberG.value);
    }
    if (totalSodiumMg.present) {
      map['total_sodium_mg'] = Variable<double>(totalSodiumMg.value);
    }
    if (mealContext.present) {
      map['meal_context'] = Variable<String>(mealContext.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (foodPhotoUrl.present) {
      map['food_photo_url'] = Variable<String>(foodPhotoUrl.value);
    }
    if (synced.present) {
      map['synced'] = Variable<int>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DietEntriesCompanion(')
          ..write('entryId: $entryId, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('date: $date, ')
          ..write('portionId: $portionId, ')
          ..write('customPortionGrams: $customPortionGrams, ')
          ..write('servingSizeMultiplier: $servingSizeMultiplier, ')
          ..write('totalEnergyKcal: $totalEnergyKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('totalCarbohydrateG: $totalCarbohydrateG, ')
          ..write('totalNetCarbsG: $totalNetCarbsG, ')
          ..write('totalFiberG: $totalFiberG, ')
          ..write('totalSodiumMg: $totalSodiumMg, ')
          ..write('mealContext: $mealContext, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('foodPhotoUrl: $foodPhotoUrl, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HealthLogsTable extends HealthLogs
    with TableInfo<$HealthLogsTable, HealthLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  @override
  late final GeneratedColumn<int> logId = GeneratedColumn<int>(
      'log_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<String> recordedAt = GeneratedColumn<String>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bloodGlucoseMgDlMeta =
      const VerificationMeta('bloodGlucoseMgDl');
  @override
  late final GeneratedColumn<double> bloodGlucoseMgDl = GeneratedColumn<double>(
      'blood_glucose_mg_dl', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _bloodKetonesMmolLMeta =
      const VerificationMeta('bloodKetonesMmolL');
  @override
  late final GeneratedColumn<double> bloodKetonesMmolL =
      GeneratedColumn<double>('blood_ketones_mmol_l', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gkiScoreMeta =
      const VerificationMeta('gkiScore');
  @override
  late final GeneratedColumn<double> gkiScore = GeneratedColumn<double>(
      'gki_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lactateMmolLMeta =
      const VerificationMeta('lactateMmolL');
  @override
  late final GeneratedColumn<double> lactateMmolL = GeneratedColumn<double>(
      'lactate_mmol_l', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sodiumMmolLMeta =
      const VerificationMeta('sodiumMmolL');
  @override
  late final GeneratedColumn<double> sodiumMmolL = GeneratedColumn<double>(
      'sodium_mmol_l', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _bloodPressureSystolicMeta =
      const VerificationMeta('bloodPressureSystolic');
  @override
  late final GeneratedColumn<int> bloodPressureSystolic = GeneratedColumn<int>(
      'blood_pressure_systolic', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bloodPressureDiastolicMeta =
      const VerificationMeta('bloodPressureDiastolic');
  @override
  late final GeneratedColumn<int> bloodPressureDiastolic = GeneratedColumn<int>(
      'blood_pressure_diastolic', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _bodyFatPercentageMeta =
      const VerificationMeta('bodyFatPercentage');
  @override
  late final GeneratedColumn<double> bodyFatPercentage =
      GeneratedColumn<double>('body_fat_percentage', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _muscleMassKgMeta =
      const VerificationMeta('muscleMassKg');
  @override
  late final GeneratedColumn<double> muscleMassKg = GeneratedColumn<double>(
      'muscle_mass_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manual'));
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<int> synced = GeneratedColumn<int>(
      'synced', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  @override
  List<GeneratedColumn> get $columns => [
        logId,
        userId,
        recordedAt,
        date,
        bloodGlucoseMgDl,
        bloodKetonesMmolL,
        gkiScore,
        lactateMmolL,
        sodiumMmolL,
        bloodPressureSystolic,
        bloodPressureDiastolic,
        weightKg,
        bodyFatPercentage,
        muscleMassKg,
        source,
        deviceId,
        notes,
        synced,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_logs';
  @override
  VerificationContext validateIntegrity(Insertable<HealthLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_id')) {
      context.handle(
          _logIdMeta, logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('blood_glucose_mg_dl')) {
      context.handle(
          _bloodGlucoseMgDlMeta,
          bloodGlucoseMgDl.isAcceptableOrUnknown(
              data['blood_glucose_mg_dl']!, _bloodGlucoseMgDlMeta));
    }
    if (data.containsKey('blood_ketones_mmol_l')) {
      context.handle(
          _bloodKetonesMmolLMeta,
          bloodKetonesMmolL.isAcceptableOrUnknown(
              data['blood_ketones_mmol_l']!, _bloodKetonesMmolLMeta));
    }
    if (data.containsKey('gki_score')) {
      context.handle(_gkiScoreMeta,
          gkiScore.isAcceptableOrUnknown(data['gki_score']!, _gkiScoreMeta));
    }
    if (data.containsKey('lactate_mmol_l')) {
      context.handle(
          _lactateMmolLMeta,
          lactateMmolL.isAcceptableOrUnknown(
              data['lactate_mmol_l']!, _lactateMmolLMeta));
    }
    if (data.containsKey('sodium_mmol_l')) {
      context.handle(
          _sodiumMmolLMeta,
          sodiumMmolL.isAcceptableOrUnknown(
              data['sodium_mmol_l']!, _sodiumMmolLMeta));
    }
    if (data.containsKey('blood_pressure_systolic')) {
      context.handle(
          _bloodPressureSystolicMeta,
          bloodPressureSystolic.isAcceptableOrUnknown(
              data['blood_pressure_systolic']!, _bloodPressureSystolicMeta));
    }
    if (data.containsKey('blood_pressure_diastolic')) {
      context.handle(
          _bloodPressureDiastolicMeta,
          bloodPressureDiastolic.isAcceptableOrUnknown(
              data['blood_pressure_diastolic']!, _bloodPressureDiastolicMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('body_fat_percentage')) {
      context.handle(
          _bodyFatPercentageMeta,
          bodyFatPercentage.isAcceptableOrUnknown(
              data['body_fat_percentage']!, _bodyFatPercentageMeta));
    }
    if (data.containsKey('muscle_mass_kg')) {
      context.handle(
          _muscleMassKgMeta,
          muscleMassKg.isAcceptableOrUnknown(
              data['muscle_mass_kg']!, _muscleMassKgMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logId};
  @override
  HealthLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthLog(
      logId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recorded_at'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      bloodGlucoseMgDl: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}blood_glucose_mg_dl']),
      bloodKetonesMmolL: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}blood_ketones_mmol_l']),
      gkiScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gki_score']),
      lactateMmolL: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lactate_mmol_l']),
      sodiumMmolL: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sodium_mmol_l']),
      bloodPressureSystolic: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}blood_pressure_systolic']),
      bloodPressureDiastolic: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}blood_pressure_diastolic']),
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      bodyFatPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}body_fat_percentage']),
      muscleMassKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}muscle_mass_kg']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HealthLogsTable createAlias(String alias) {
    return $HealthLogsTable(attachedDatabase, alias);
  }
}

class HealthLog extends DataClass implements Insertable<HealthLog> {
  final int logId;
  final int userId;
  final String recordedAt;
  final String date;
  final double? bloodGlucoseMgDl;
  final double? bloodKetonesMmolL;
  final double? gkiScore;
  final double? lactateMmolL;
  final double? sodiumMmolL;
  final int? bloodPressureSystolic;
  final int? bloodPressureDiastolic;
  final double? weightKg;
  final double? bodyFatPercentage;
  final double? muscleMassKg;
  final String source;
  final String? deviceId;
  final String? notes;
  final int synced;
  final String createdAt;
  const HealthLog(
      {required this.logId,
      required this.userId,
      required this.recordedAt,
      required this.date,
      this.bloodGlucoseMgDl,
      this.bloodKetonesMmolL,
      this.gkiScore,
      this.lactateMmolL,
      this.sodiumMmolL,
      this.bloodPressureSystolic,
      this.bloodPressureDiastolic,
      this.weightKg,
      this.bodyFatPercentage,
      this.muscleMassKg,
      required this.source,
      this.deviceId,
      this.notes,
      required this.synced,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_id'] = Variable<int>(logId);
    map['user_id'] = Variable<int>(userId);
    map['recorded_at'] = Variable<String>(recordedAt);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || bloodGlucoseMgDl != null) {
      map['blood_glucose_mg_dl'] = Variable<double>(bloodGlucoseMgDl);
    }
    if (!nullToAbsent || bloodKetonesMmolL != null) {
      map['blood_ketones_mmol_l'] = Variable<double>(bloodKetonesMmolL);
    }
    if (!nullToAbsent || gkiScore != null) {
      map['gki_score'] = Variable<double>(gkiScore);
    }
    if (!nullToAbsent || lactateMmolL != null) {
      map['lactate_mmol_l'] = Variable<double>(lactateMmolL);
    }
    if (!nullToAbsent || sodiumMmolL != null) {
      map['sodium_mmol_l'] = Variable<double>(sodiumMmolL);
    }
    if (!nullToAbsent || bloodPressureSystolic != null) {
      map['blood_pressure_systolic'] = Variable<int>(bloodPressureSystolic);
    }
    if (!nullToAbsent || bloodPressureDiastolic != null) {
      map['blood_pressure_diastolic'] = Variable<int>(bloodPressureDiastolic);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || bodyFatPercentage != null) {
      map['body_fat_percentage'] = Variable<double>(bodyFatPercentage);
    }
    if (!nullToAbsent || muscleMassKg != null) {
      map['muscle_mass_kg'] = Variable<double>(muscleMassKg);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['synced'] = Variable<int>(synced);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  HealthLogsCompanion toCompanion(bool nullToAbsent) {
    return HealthLogsCompanion(
      logId: Value(logId),
      userId: Value(userId),
      recordedAt: Value(recordedAt),
      date: Value(date),
      bloodGlucoseMgDl: bloodGlucoseMgDl == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodGlucoseMgDl),
      bloodKetonesMmolL: bloodKetonesMmolL == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodKetonesMmolL),
      gkiScore: gkiScore == null && nullToAbsent
          ? const Value.absent()
          : Value(gkiScore),
      lactateMmolL: lactateMmolL == null && nullToAbsent
          ? const Value.absent()
          : Value(lactateMmolL),
      sodiumMmolL: sodiumMmolL == null && nullToAbsent
          ? const Value.absent()
          : Value(sodiumMmolL),
      bloodPressureSystolic: bloodPressureSystolic == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodPressureSystolic),
      bloodPressureDiastolic: bloodPressureDiastolic == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodPressureDiastolic),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      bodyFatPercentage: bodyFatPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFatPercentage),
      muscleMassKg: muscleMassKg == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleMassKg),
      source: Value(source),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      synced: Value(synced),
      createdAt: Value(createdAt),
    );
  }

  factory HealthLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthLog(
      logId: serializer.fromJson<int>(json['logId']),
      userId: serializer.fromJson<int>(json['userId']),
      recordedAt: serializer.fromJson<String>(json['recordedAt']),
      date: serializer.fromJson<String>(json['date']),
      bloodGlucoseMgDl: serializer.fromJson<double?>(json['bloodGlucoseMgDl']),
      bloodKetonesMmolL:
          serializer.fromJson<double?>(json['bloodKetonesMmolL']),
      gkiScore: serializer.fromJson<double?>(json['gkiScore']),
      lactateMmolL: serializer.fromJson<double?>(json['lactateMmolL']),
      sodiumMmolL: serializer.fromJson<double?>(json['sodiumMmolL']),
      bloodPressureSystolic:
          serializer.fromJson<int?>(json['bloodPressureSystolic']),
      bloodPressureDiastolic:
          serializer.fromJson<int?>(json['bloodPressureDiastolic']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      bodyFatPercentage:
          serializer.fromJson<double?>(json['bodyFatPercentage']),
      muscleMassKg: serializer.fromJson<double?>(json['muscleMassKg']),
      source: serializer.fromJson<String>(json['source']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      notes: serializer.fromJson<String?>(json['notes']),
      synced: serializer.fromJson<int>(json['synced']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'logId': serializer.toJson<int>(logId),
      'userId': serializer.toJson<int>(userId),
      'recordedAt': serializer.toJson<String>(recordedAt),
      'date': serializer.toJson<String>(date),
      'bloodGlucoseMgDl': serializer.toJson<double?>(bloodGlucoseMgDl),
      'bloodKetonesMmolL': serializer.toJson<double?>(bloodKetonesMmolL),
      'gkiScore': serializer.toJson<double?>(gkiScore),
      'lactateMmolL': serializer.toJson<double?>(lactateMmolL),
      'sodiumMmolL': serializer.toJson<double?>(sodiumMmolL),
      'bloodPressureSystolic': serializer.toJson<int?>(bloodPressureSystolic),
      'bloodPressureDiastolic': serializer.toJson<int?>(bloodPressureDiastolic),
      'weightKg': serializer.toJson<double?>(weightKg),
      'bodyFatPercentage': serializer.toJson<double?>(bodyFatPercentage),
      'muscleMassKg': serializer.toJson<double?>(muscleMassKg),
      'source': serializer.toJson<String>(source),
      'deviceId': serializer.toJson<String?>(deviceId),
      'notes': serializer.toJson<String?>(notes),
      'synced': serializer.toJson<int>(synced),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  HealthLog copyWith(
          {int? logId,
          int? userId,
          String? recordedAt,
          String? date,
          Value<double?> bloodGlucoseMgDl = const Value.absent(),
          Value<double?> bloodKetonesMmolL = const Value.absent(),
          Value<double?> gkiScore = const Value.absent(),
          Value<double?> lactateMmolL = const Value.absent(),
          Value<double?> sodiumMmolL = const Value.absent(),
          Value<int?> bloodPressureSystolic = const Value.absent(),
          Value<int?> bloodPressureDiastolic = const Value.absent(),
          Value<double?> weightKg = const Value.absent(),
          Value<double?> bodyFatPercentage = const Value.absent(),
          Value<double?> muscleMassKg = const Value.absent(),
          String? source,
          Value<String?> deviceId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          int? synced,
          String? createdAt}) =>
      HealthLog(
        logId: logId ?? this.logId,
        userId: userId ?? this.userId,
        recordedAt: recordedAt ?? this.recordedAt,
        date: date ?? this.date,
        bloodGlucoseMgDl: bloodGlucoseMgDl.present
            ? bloodGlucoseMgDl.value
            : this.bloodGlucoseMgDl,
        bloodKetonesMmolL: bloodKetonesMmolL.present
            ? bloodKetonesMmolL.value
            : this.bloodKetonesMmolL,
        gkiScore: gkiScore.present ? gkiScore.value : this.gkiScore,
        lactateMmolL:
            lactateMmolL.present ? lactateMmolL.value : this.lactateMmolL,
        sodiumMmolL: sodiumMmolL.present ? sodiumMmolL.value : this.sodiumMmolL,
        bloodPressureSystolic: bloodPressureSystolic.present
            ? bloodPressureSystolic.value
            : this.bloodPressureSystolic,
        bloodPressureDiastolic: bloodPressureDiastolic.present
            ? bloodPressureDiastolic.value
            : this.bloodPressureDiastolic,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        bodyFatPercentage: bodyFatPercentage.present
            ? bodyFatPercentage.value
            : this.bodyFatPercentage,
        muscleMassKg:
            muscleMassKg.present ? muscleMassKg.value : this.muscleMassKg,
        source: source ?? this.source,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        notes: notes.present ? notes.value : this.notes,
        synced: synced ?? this.synced,
        createdAt: createdAt ?? this.createdAt,
      );
  HealthLog copyWithCompanion(HealthLogsCompanion data) {
    return HealthLog(
      logId: data.logId.present ? data.logId.value : this.logId,
      userId: data.userId.present ? data.userId.value : this.userId,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      date: data.date.present ? data.date.value : this.date,
      bloodGlucoseMgDl: data.bloodGlucoseMgDl.present
          ? data.bloodGlucoseMgDl.value
          : this.bloodGlucoseMgDl,
      bloodKetonesMmolL: data.bloodKetonesMmolL.present
          ? data.bloodKetonesMmolL.value
          : this.bloodKetonesMmolL,
      gkiScore: data.gkiScore.present ? data.gkiScore.value : this.gkiScore,
      lactateMmolL: data.lactateMmolL.present
          ? data.lactateMmolL.value
          : this.lactateMmolL,
      sodiumMmolL:
          data.sodiumMmolL.present ? data.sodiumMmolL.value : this.sodiumMmolL,
      bloodPressureSystolic: data.bloodPressureSystolic.present
          ? data.bloodPressureSystolic.value
          : this.bloodPressureSystolic,
      bloodPressureDiastolic: data.bloodPressureDiastolic.present
          ? data.bloodPressureDiastolic.value
          : this.bloodPressureDiastolic,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      bodyFatPercentage: data.bodyFatPercentage.present
          ? data.bodyFatPercentage.value
          : this.bodyFatPercentage,
      muscleMassKg: data.muscleMassKg.present
          ? data.muscleMassKg.value
          : this.muscleMassKg,
      source: data.source.present ? data.source.value : this.source,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      notes: data.notes.present ? data.notes.value : this.notes,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthLog(')
          ..write('logId: $logId, ')
          ..write('userId: $userId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('date: $date, ')
          ..write('bloodGlucoseMgDl: $bloodGlucoseMgDl, ')
          ..write('bloodKetonesMmolL: $bloodKetonesMmolL, ')
          ..write('gkiScore: $gkiScore, ')
          ..write('lactateMmolL: $lactateMmolL, ')
          ..write('sodiumMmolL: $sodiumMmolL, ')
          ..write('bloodPressureSystolic: $bloodPressureSystolic, ')
          ..write('bloodPressureDiastolic: $bloodPressureDiastolic, ')
          ..write('weightKg: $weightKg, ')
          ..write('bodyFatPercentage: $bodyFatPercentage, ')
          ..write('muscleMassKg: $muscleMassKg, ')
          ..write('source: $source, ')
          ..write('deviceId: $deviceId, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      logId,
      userId,
      recordedAt,
      date,
      bloodGlucoseMgDl,
      bloodKetonesMmolL,
      gkiScore,
      lactateMmolL,
      sodiumMmolL,
      bloodPressureSystolic,
      bloodPressureDiastolic,
      weightKg,
      bodyFatPercentage,
      muscleMassKg,
      source,
      deviceId,
      notes,
      synced,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthLog &&
          other.logId == this.logId &&
          other.userId == this.userId &&
          other.recordedAt == this.recordedAt &&
          other.date == this.date &&
          other.bloodGlucoseMgDl == this.bloodGlucoseMgDl &&
          other.bloodKetonesMmolL == this.bloodKetonesMmolL &&
          other.gkiScore == this.gkiScore &&
          other.lactateMmolL == this.lactateMmolL &&
          other.sodiumMmolL == this.sodiumMmolL &&
          other.bloodPressureSystolic == this.bloodPressureSystolic &&
          other.bloodPressureDiastolic == this.bloodPressureDiastolic &&
          other.weightKg == this.weightKg &&
          other.bodyFatPercentage == this.bodyFatPercentage &&
          other.muscleMassKg == this.muscleMassKg &&
          other.source == this.source &&
          other.deviceId == this.deviceId &&
          other.notes == this.notes &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt);
}

class HealthLogsCompanion extends UpdateCompanion<HealthLog> {
  final Value<int> logId;
  final Value<int> userId;
  final Value<String> recordedAt;
  final Value<String> date;
  final Value<double?> bloodGlucoseMgDl;
  final Value<double?> bloodKetonesMmolL;
  final Value<double?> gkiScore;
  final Value<double?> lactateMmolL;
  final Value<double?> sodiumMmolL;
  final Value<int?> bloodPressureSystolic;
  final Value<int?> bloodPressureDiastolic;
  final Value<double?> weightKg;
  final Value<double?> bodyFatPercentage;
  final Value<double?> muscleMassKg;
  final Value<String> source;
  final Value<String?> deviceId;
  final Value<String?> notes;
  final Value<int> synced;
  final Value<String> createdAt;
  const HealthLogsCompanion({
    this.logId = const Value.absent(),
    this.userId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.date = const Value.absent(),
    this.bloodGlucoseMgDl = const Value.absent(),
    this.bloodKetonesMmolL = const Value.absent(),
    this.gkiScore = const Value.absent(),
    this.lactateMmolL = const Value.absent(),
    this.sodiumMmolL = const Value.absent(),
    this.bloodPressureSystolic = const Value.absent(),
    this.bloodPressureDiastolic = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.bodyFatPercentage = const Value.absent(),
    this.muscleMassKg = const Value.absent(),
    this.source = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HealthLogsCompanion.insert({
    this.logId = const Value.absent(),
    required int userId,
    required String recordedAt,
    required String date,
    this.bloodGlucoseMgDl = const Value.absent(),
    this.bloodKetonesMmolL = const Value.absent(),
    this.gkiScore = const Value.absent(),
    this.lactateMmolL = const Value.absent(),
    this.sodiumMmolL = const Value.absent(),
    this.bloodPressureSystolic = const Value.absent(),
    this.bloodPressureDiastolic = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.bodyFatPercentage = const Value.absent(),
    this.muscleMassKg = const Value.absent(),
    this.source = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        recordedAt = Value(recordedAt),
        date = Value(date);
  static Insertable<HealthLog> custom({
    Expression<int>? logId,
    Expression<int>? userId,
    Expression<String>? recordedAt,
    Expression<String>? date,
    Expression<double>? bloodGlucoseMgDl,
    Expression<double>? bloodKetonesMmolL,
    Expression<double>? gkiScore,
    Expression<double>? lactateMmolL,
    Expression<double>? sodiumMmolL,
    Expression<int>? bloodPressureSystolic,
    Expression<int>? bloodPressureDiastolic,
    Expression<double>? weightKg,
    Expression<double>? bodyFatPercentage,
    Expression<double>? muscleMassKg,
    Expression<String>? source,
    Expression<String>? deviceId,
    Expression<String>? notes,
    Expression<int>? synced,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (logId != null) 'log_id': logId,
      if (userId != null) 'user_id': userId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (date != null) 'date': date,
      if (bloodGlucoseMgDl != null) 'blood_glucose_mg_dl': bloodGlucoseMgDl,
      if (bloodKetonesMmolL != null) 'blood_ketones_mmol_l': bloodKetonesMmolL,
      if (gkiScore != null) 'gki_score': gkiScore,
      if (lactateMmolL != null) 'lactate_mmol_l': lactateMmolL,
      if (sodiumMmolL != null) 'sodium_mmol_l': sodiumMmolL,
      if (bloodPressureSystolic != null)
        'blood_pressure_systolic': bloodPressureSystolic,
      if (bloodPressureDiastolic != null)
        'blood_pressure_diastolic': bloodPressureDiastolic,
      if (weightKg != null) 'weight_kg': weightKg,
      if (bodyFatPercentage != null) 'body_fat_percentage': bodyFatPercentage,
      if (muscleMassKg != null) 'muscle_mass_kg': muscleMassKg,
      if (source != null) 'source': source,
      if (deviceId != null) 'device_id': deviceId,
      if (notes != null) 'notes': notes,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HealthLogsCompanion copyWith(
      {Value<int>? logId,
      Value<int>? userId,
      Value<String>? recordedAt,
      Value<String>? date,
      Value<double?>? bloodGlucoseMgDl,
      Value<double?>? bloodKetonesMmolL,
      Value<double?>? gkiScore,
      Value<double?>? lactateMmolL,
      Value<double?>? sodiumMmolL,
      Value<int?>? bloodPressureSystolic,
      Value<int?>? bloodPressureDiastolic,
      Value<double?>? weightKg,
      Value<double?>? bodyFatPercentage,
      Value<double?>? muscleMassKg,
      Value<String>? source,
      Value<String?>? deviceId,
      Value<String?>? notes,
      Value<int>? synced,
      Value<String>? createdAt}) {
    return HealthLogsCompanion(
      logId: logId ?? this.logId,
      userId: userId ?? this.userId,
      recordedAt: recordedAt ?? this.recordedAt,
      date: date ?? this.date,
      bloodGlucoseMgDl: bloodGlucoseMgDl ?? this.bloodGlucoseMgDl,
      bloodKetonesMmolL: bloodKetonesMmolL ?? this.bloodKetonesMmolL,
      gkiScore: gkiScore ?? this.gkiScore,
      lactateMmolL: lactateMmolL ?? this.lactateMmolL,
      sodiumMmolL: sodiumMmolL ?? this.sodiumMmolL,
      bloodPressureSystolic:
          bloodPressureSystolic ?? this.bloodPressureSystolic,
      bloodPressureDiastolic:
          bloodPressureDiastolic ?? this.bloodPressureDiastolic,
      weightKg: weightKg ?? this.weightKg,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      muscleMassKg: muscleMassKg ?? this.muscleMassKg,
      source: source ?? this.source,
      deviceId: deviceId ?? this.deviceId,
      notes: notes ?? this.notes,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<String>(recordedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (bloodGlucoseMgDl.present) {
      map['blood_glucose_mg_dl'] = Variable<double>(bloodGlucoseMgDl.value);
    }
    if (bloodKetonesMmolL.present) {
      map['blood_ketones_mmol_l'] = Variable<double>(bloodKetonesMmolL.value);
    }
    if (gkiScore.present) {
      map['gki_score'] = Variable<double>(gkiScore.value);
    }
    if (lactateMmolL.present) {
      map['lactate_mmol_l'] = Variable<double>(lactateMmolL.value);
    }
    if (sodiumMmolL.present) {
      map['sodium_mmol_l'] = Variable<double>(sodiumMmolL.value);
    }
    if (bloodPressureSystolic.present) {
      map['blood_pressure_systolic'] =
          Variable<int>(bloodPressureSystolic.value);
    }
    if (bloodPressureDiastolic.present) {
      map['blood_pressure_diastolic'] =
          Variable<int>(bloodPressureDiastolic.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (bodyFatPercentage.present) {
      map['body_fat_percentage'] = Variable<double>(bodyFatPercentage.value);
    }
    if (muscleMassKg.present) {
      map['muscle_mass_kg'] = Variable<double>(muscleMassKg.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (synced.present) {
      map['synced'] = Variable<int>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthLogsCompanion(')
          ..write('logId: $logId, ')
          ..write('userId: $userId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('date: $date, ')
          ..write('bloodGlucoseMgDl: $bloodGlucoseMgDl, ')
          ..write('bloodKetonesMmolL: $bloodKetonesMmolL, ')
          ..write('gkiScore: $gkiScore, ')
          ..write('lactateMmolL: $lactateMmolL, ')
          ..write('sodiumMmolL: $sodiumMmolL, ')
          ..write('bloodPressureSystolic: $bloodPressureSystolic, ')
          ..write('bloodPressureDiastolic: $bloodPressureDiastolic, ')
          ..write('weightKg: $weightKg, ')
          ..write('bodyFatPercentage: $bodyFatPercentage, ')
          ..write('muscleMassKg: $muscleMassKg, ')
          ..write('source: $source, ')
          ..write('deviceId: $deviceId, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DailySummariesTable extends DailySummaries
    with TableInfo<$DailySummariesTable, DailySummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailySummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _summaryIdMeta =
      const VerificationMeta('summaryId');
  @override
  late final GeneratedColumn<int> summaryId = GeneratedColumn<int>(
      'summary_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalEnergyKcalMeta =
      const VerificationMeta('totalEnergyKcal');
  @override
  late final GeneratedColumn<double> totalEnergyKcal = GeneratedColumn<double>(
      'total_energy_kcal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalProteinGMeta =
      const VerificationMeta('totalProteinG');
  @override
  late final GeneratedColumn<double> totalProteinG = GeneratedColumn<double>(
      'total_protein_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalFatGMeta =
      const VerificationMeta('totalFatG');
  @override
  late final GeneratedColumn<double> totalFatG = GeneratedColumn<double>(
      'total_fat_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalCarbohydrateGMeta =
      const VerificationMeta('totalCarbohydrateG');
  @override
  late final GeneratedColumn<double> totalCarbohydrateG =
      GeneratedColumn<double>('total_carbohydrate_g', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _totalNetCarbsGMeta =
      const VerificationMeta('totalNetCarbsG');
  @override
  late final GeneratedColumn<double> totalNetCarbsG = GeneratedColumn<double>(
      'total_net_carbs_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalFiberGMeta =
      const VerificationMeta('totalFiberG');
  @override
  late final GeneratedColumn<double> totalFiberG = GeneratedColumn<double>(
      'total_fiber_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalSodiumMgMeta =
      const VerificationMeta('totalSodiumMg');
  @override
  late final GeneratedColumn<double> totalSodiumMg = GeneratedColumn<double>(
      'total_sodium_mg', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalPotassiumMgMeta =
      const VerificationMeta('totalPotassiumMg');
  @override
  late final GeneratedColumn<double> totalPotassiumMg = GeneratedColumn<double>(
      'total_potassium_mg', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalMagnesiumMgMeta =
      const VerificationMeta('totalMagnesiumMg');
  @override
  late final GeneratedColumn<double> totalMagnesiumMg = GeneratedColumn<double>(
      'total_magnesium_mg', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _carbGoalMetMeta =
      const VerificationMeta('carbGoalMet');
  @override
  late final GeneratedColumn<int> carbGoalMet = GeneratedColumn<int>(
      'carb_goal_met', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _proteinGoalMetMeta =
      const VerificationMeta('proteinGoalMet');
  @override
  late final GeneratedColumn<int> proteinGoalMet = GeneratedColumn<int>(
      'protein_goal_met', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fatGoalMetMeta =
      const VerificationMeta('fatGoalMet');
  @override
  late final GeneratedColumn<int> fatGoalMet = GeneratedColumn<int>(
      'fat_goal_met', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _avgGlucoseMgDlMeta =
      const VerificationMeta('avgGlucoseMgDl');
  @override
  late final GeneratedColumn<double> avgGlucoseMgDl = GeneratedColumn<double>(
      'avg_glucose_mg_dl', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _avgKetonesMmolLMeta =
      const VerificationMeta('avgKetonesMmolL');
  @override
  late final GeneratedColumn<double> avgKetonesMmolL = GeneratedColumn<double>(
      'avg_ketones_mmol_l', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _avgGkiScoreMeta =
      const VerificationMeta('avgGkiScore');
  @override
  late final GeneratedColumn<double> avgGkiScore = GeneratedColumn<double>(
      'avg_gki_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _minGkiScoreMeta =
      const VerificationMeta('minGkiScore');
  @override
  late final GeneratedColumn<double> minGkiScore = GeneratedColumn<double>(
      'min_gki_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _maxGkiScoreMeta =
      const VerificationMeta('maxGkiScore');
  @override
  late final GeneratedColumn<double> maxGkiScore = GeneratedColumn<double>(
      'max_gki_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _inKetosisMeta =
      const VerificationMeta('inKetosis');
  @override
  late final GeneratedColumn<int> inKetosis = GeneratedColumn<int>(
      'in_ketosis', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _inTherapeuticKetosisMeta =
      const VerificationMeta('inTherapeuticKetosis');
  @override
  late final GeneratedColumn<int> inTherapeuticKetosis = GeneratedColumn<int>(
      'in_therapeutic_ketosis', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _avgHeartRateBpmMeta =
      const VerificationMeta('avgHeartRateBpm');
  @override
  late final GeneratedColumn<int> avgHeartRateBpm = GeneratedColumn<int>(
      'avg_heart_rate_bpm', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _avgHrvMsMeta =
      const VerificationMeta('avgHrvMs');
  @override
  late final GeneratedColumn<double> avgHrvMs = GeneratedColumn<double>(
      'avg_hrv_ms', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _totalStepsMeta =
      const VerificationMeta('totalSteps');
  @override
  late final GeneratedColumn<int> totalSteps = GeneratedColumn<int>(
      'total_steps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _weightChangeFromStartKgMeta =
      const VerificationMeta('weightChangeFromStartKg');
  @override
  late final GeneratedColumn<double> weightChangeFromStartKg =
      GeneratedColumn<double>('weight_change_from_start_kg', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _avgEnergyLevelMeta =
      const VerificationMeta('avgEnergyLevel');
  @override
  late final GeneratedColumn<double> avgEnergyLevel = GeneratedColumn<double>(
      'avg_energy_level', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _avgMentalClarityMeta =
      const VerificationMeta('avgMentalClarity');
  @override
  late final GeneratedColumn<double> avgMentalClarity = GeneratedColumn<double>(
      'avg_mental_clarity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _avgMoodRatingMeta =
      const VerificationMeta('avgMoodRating');
  @override
  late final GeneratedColumn<double> avgMoodRating = GeneratedColumn<double>(
      'avg_mood_rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _dietEntriesCountMeta =
      const VerificationMeta('dietEntriesCount');
  @override
  late final GeneratedColumn<int> dietEntriesCount = GeneratedColumn<int>(
      'diet_entries_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _healthLogsCountMeta =
      const VerificationMeta('healthLogsCount');
  @override
  late final GeneratedColumn<int> healthLogsCount = GeneratedColumn<int>(
      'health_logs_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastCalculatedAtMeta =
      const VerificationMeta('lastCalculatedAt');
  @override
  late final GeneratedColumn<String> lastCalculatedAt = GeneratedColumn<String>(
      'last_calculated_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<int> synced = GeneratedColumn<int>(
      'synced', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        summaryId,
        userId,
        date,
        totalEnergyKcal,
        totalProteinG,
        totalFatG,
        totalCarbohydrateG,
        totalNetCarbsG,
        totalFiberG,
        totalSodiumMg,
        totalPotassiumMg,
        totalMagnesiumMg,
        carbGoalMet,
        proteinGoalMet,
        fatGoalMet,
        avgGlucoseMgDl,
        avgKetonesMmolL,
        avgGkiScore,
        minGkiScore,
        maxGkiScore,
        inKetosis,
        inTherapeuticKetosis,
        avgHeartRateBpm,
        avgHrvMs,
        totalSteps,
        weightKg,
        weightChangeFromStartKg,
        avgEnergyLevel,
        avgMentalClarity,
        avgMoodRating,
        dietEntriesCount,
        healthLogsCount,
        lastCalculatedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_summaries';
  @override
  VerificationContext validateIntegrity(Insertable<DailySummary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('summary_id')) {
      context.handle(_summaryIdMeta,
          summaryId.isAcceptableOrUnknown(data['summary_id']!, _summaryIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total_energy_kcal')) {
      context.handle(
          _totalEnergyKcalMeta,
          totalEnergyKcal.isAcceptableOrUnknown(
              data['total_energy_kcal']!, _totalEnergyKcalMeta));
    }
    if (data.containsKey('total_protein_g')) {
      context.handle(
          _totalProteinGMeta,
          totalProteinG.isAcceptableOrUnknown(
              data['total_protein_g']!, _totalProteinGMeta));
    }
    if (data.containsKey('total_fat_g')) {
      context.handle(
          _totalFatGMeta,
          totalFatG.isAcceptableOrUnknown(
              data['total_fat_g']!, _totalFatGMeta));
    }
    if (data.containsKey('total_carbohydrate_g')) {
      context.handle(
          _totalCarbohydrateGMeta,
          totalCarbohydrateG.isAcceptableOrUnknown(
              data['total_carbohydrate_g']!, _totalCarbohydrateGMeta));
    }
    if (data.containsKey('total_net_carbs_g')) {
      context.handle(
          _totalNetCarbsGMeta,
          totalNetCarbsG.isAcceptableOrUnknown(
              data['total_net_carbs_g']!, _totalNetCarbsGMeta));
    }
    if (data.containsKey('total_fiber_g')) {
      context.handle(
          _totalFiberGMeta,
          totalFiberG.isAcceptableOrUnknown(
              data['total_fiber_g']!, _totalFiberGMeta));
    }
    if (data.containsKey('total_sodium_mg')) {
      context.handle(
          _totalSodiumMgMeta,
          totalSodiumMg.isAcceptableOrUnknown(
              data['total_sodium_mg']!, _totalSodiumMgMeta));
    }
    if (data.containsKey('total_potassium_mg')) {
      context.handle(
          _totalPotassiumMgMeta,
          totalPotassiumMg.isAcceptableOrUnknown(
              data['total_potassium_mg']!, _totalPotassiumMgMeta));
    }
    if (data.containsKey('total_magnesium_mg')) {
      context.handle(
          _totalMagnesiumMgMeta,
          totalMagnesiumMg.isAcceptableOrUnknown(
              data['total_magnesium_mg']!, _totalMagnesiumMgMeta));
    }
    if (data.containsKey('carb_goal_met')) {
      context.handle(
          _carbGoalMetMeta,
          carbGoalMet.isAcceptableOrUnknown(
              data['carb_goal_met']!, _carbGoalMetMeta));
    }
    if (data.containsKey('protein_goal_met')) {
      context.handle(
          _proteinGoalMetMeta,
          proteinGoalMet.isAcceptableOrUnknown(
              data['protein_goal_met']!, _proteinGoalMetMeta));
    }
    if (data.containsKey('fat_goal_met')) {
      context.handle(
          _fatGoalMetMeta,
          fatGoalMet.isAcceptableOrUnknown(
              data['fat_goal_met']!, _fatGoalMetMeta));
    }
    if (data.containsKey('avg_glucose_mg_dl')) {
      context.handle(
          _avgGlucoseMgDlMeta,
          avgGlucoseMgDl.isAcceptableOrUnknown(
              data['avg_glucose_mg_dl']!, _avgGlucoseMgDlMeta));
    }
    if (data.containsKey('avg_ketones_mmol_l')) {
      context.handle(
          _avgKetonesMmolLMeta,
          avgKetonesMmolL.isAcceptableOrUnknown(
              data['avg_ketones_mmol_l']!, _avgKetonesMmolLMeta));
    }
    if (data.containsKey('avg_gki_score')) {
      context.handle(
          _avgGkiScoreMeta,
          avgGkiScore.isAcceptableOrUnknown(
              data['avg_gki_score']!, _avgGkiScoreMeta));
    }
    if (data.containsKey('min_gki_score')) {
      context.handle(
          _minGkiScoreMeta,
          minGkiScore.isAcceptableOrUnknown(
              data['min_gki_score']!, _minGkiScoreMeta));
    }
    if (data.containsKey('max_gki_score')) {
      context.handle(
          _maxGkiScoreMeta,
          maxGkiScore.isAcceptableOrUnknown(
              data['max_gki_score']!, _maxGkiScoreMeta));
    }
    if (data.containsKey('in_ketosis')) {
      context.handle(_inKetosisMeta,
          inKetosis.isAcceptableOrUnknown(data['in_ketosis']!, _inKetosisMeta));
    }
    if (data.containsKey('in_therapeutic_ketosis')) {
      context.handle(
          _inTherapeuticKetosisMeta,
          inTherapeuticKetosis.isAcceptableOrUnknown(
              data['in_therapeutic_ketosis']!, _inTherapeuticKetosisMeta));
    }
    if (data.containsKey('avg_heart_rate_bpm')) {
      context.handle(
          _avgHeartRateBpmMeta,
          avgHeartRateBpm.isAcceptableOrUnknown(
              data['avg_heart_rate_bpm']!, _avgHeartRateBpmMeta));
    }
    if (data.containsKey('avg_hrv_ms')) {
      context.handle(_avgHrvMsMeta,
          avgHrvMs.isAcceptableOrUnknown(data['avg_hrv_ms']!, _avgHrvMsMeta));
    }
    if (data.containsKey('total_steps')) {
      context.handle(
          _totalStepsMeta,
          totalSteps.isAcceptableOrUnknown(
              data['total_steps']!, _totalStepsMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('weight_change_from_start_kg')) {
      context.handle(
          _weightChangeFromStartKgMeta,
          weightChangeFromStartKg.isAcceptableOrUnknown(
              data['weight_change_from_start_kg']!,
              _weightChangeFromStartKgMeta));
    }
    if (data.containsKey('avg_energy_level')) {
      context.handle(
          _avgEnergyLevelMeta,
          avgEnergyLevel.isAcceptableOrUnknown(
              data['avg_energy_level']!, _avgEnergyLevelMeta));
    }
    if (data.containsKey('avg_mental_clarity')) {
      context.handle(
          _avgMentalClarityMeta,
          avgMentalClarity.isAcceptableOrUnknown(
              data['avg_mental_clarity']!, _avgMentalClarityMeta));
    }
    if (data.containsKey('avg_mood_rating')) {
      context.handle(
          _avgMoodRatingMeta,
          avgMoodRating.isAcceptableOrUnknown(
              data['avg_mood_rating']!, _avgMoodRatingMeta));
    }
    if (data.containsKey('diet_entries_count')) {
      context.handle(
          _dietEntriesCountMeta,
          dietEntriesCount.isAcceptableOrUnknown(
              data['diet_entries_count']!, _dietEntriesCountMeta));
    }
    if (data.containsKey('health_logs_count')) {
      context.handle(
          _healthLogsCountMeta,
          healthLogsCount.isAcceptableOrUnknown(
              data['health_logs_count']!, _healthLogsCountMeta));
    }
    if (data.containsKey('last_calculated_at')) {
      context.handle(
          _lastCalculatedAtMeta,
          lastCalculatedAt.isAcceptableOrUnknown(
              data['last_calculated_at']!, _lastCalculatedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {summaryId};
  @override
  DailySummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailySummary(
      summaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}summary_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      totalEnergyKcal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_energy_kcal'])!,
      totalProteinG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_protein_g'])!,
      totalFatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fat_g'])!,
      totalCarbohydrateG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_carbohydrate_g'])!,
      totalNetCarbsG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_net_carbs_g'])!,
      totalFiberG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fiber_g'])!,
      totalSodiumMg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_sodium_mg'])!,
      totalPotassiumMg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_potassium_mg'])!,
      totalMagnesiumMg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_magnesium_mg'])!,
      carbGoalMet: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}carb_goal_met'])!,
      proteinGoalMet: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}protein_goal_met'])!,
      fatGoalMet: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fat_goal_met'])!,
      avgGlucoseMgDl: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}avg_glucose_mg_dl']),
      avgKetonesMmolL: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}avg_ketones_mmol_l']),
      avgGkiScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}avg_gki_score']),
      minGkiScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}min_gki_score']),
      maxGkiScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_gki_score']),
      inKetosis: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}in_ketosis'])!,
      inTherapeuticKetosis: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}in_therapeutic_ketosis'])!,
      avgHeartRateBpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}avg_heart_rate_bpm']),
      avgHrvMs: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}avg_hrv_ms']),
      totalSteps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_steps']),
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      weightChangeFromStartKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}weight_change_from_start_kg']),
      avgEnergyLevel: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}avg_energy_level']),
      avgMentalClarity: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}avg_mental_clarity']),
      avgMoodRating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}avg_mood_rating']),
      dietEntriesCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}diet_entries_count'])!,
      healthLogsCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}health_logs_count'])!,
      lastCalculatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_calculated_at'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $DailySummariesTable createAlias(String alias) {
    return $DailySummariesTable(attachedDatabase, alias);
  }
}

class DailySummary extends DataClass implements Insertable<DailySummary> {
  final int summaryId;
  final int userId;
  final String date;
  final double totalEnergyKcal;
  final double totalProteinG;
  final double totalFatG;
  final double totalCarbohydrateG;
  final double totalNetCarbsG;
  final double totalFiberG;
  final double totalSodiumMg;
  final double totalPotassiumMg;
  final double totalMagnesiumMg;
  final int carbGoalMet;
  final int proteinGoalMet;
  final int fatGoalMet;
  final double? avgGlucoseMgDl;
  final double? avgKetonesMmolL;
  final double? avgGkiScore;
  final double? minGkiScore;
  final double? maxGkiScore;
  final int inKetosis;
  final int inTherapeuticKetosis;
  final int? avgHeartRateBpm;
  final double? avgHrvMs;
  final int? totalSteps;
  final double? weightKg;
  final double? weightChangeFromStartKg;
  final double? avgEnergyLevel;
  final double? avgMentalClarity;
  final double? avgMoodRating;
  final int dietEntriesCount;
  final int healthLogsCount;
  final String lastCalculatedAt;
  final int synced;
  const DailySummary(
      {required this.summaryId,
      required this.userId,
      required this.date,
      required this.totalEnergyKcal,
      required this.totalProteinG,
      required this.totalFatG,
      required this.totalCarbohydrateG,
      required this.totalNetCarbsG,
      required this.totalFiberG,
      required this.totalSodiumMg,
      required this.totalPotassiumMg,
      required this.totalMagnesiumMg,
      required this.carbGoalMet,
      required this.proteinGoalMet,
      required this.fatGoalMet,
      this.avgGlucoseMgDl,
      this.avgKetonesMmolL,
      this.avgGkiScore,
      this.minGkiScore,
      this.maxGkiScore,
      required this.inKetosis,
      required this.inTherapeuticKetosis,
      this.avgHeartRateBpm,
      this.avgHrvMs,
      this.totalSteps,
      this.weightKg,
      this.weightChangeFromStartKg,
      this.avgEnergyLevel,
      this.avgMentalClarity,
      this.avgMoodRating,
      required this.dietEntriesCount,
      required this.healthLogsCount,
      required this.lastCalculatedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['summary_id'] = Variable<int>(summaryId);
    map['user_id'] = Variable<int>(userId);
    map['date'] = Variable<String>(date);
    map['total_energy_kcal'] = Variable<double>(totalEnergyKcal);
    map['total_protein_g'] = Variable<double>(totalProteinG);
    map['total_fat_g'] = Variable<double>(totalFatG);
    map['total_carbohydrate_g'] = Variable<double>(totalCarbohydrateG);
    map['total_net_carbs_g'] = Variable<double>(totalNetCarbsG);
    map['total_fiber_g'] = Variable<double>(totalFiberG);
    map['total_sodium_mg'] = Variable<double>(totalSodiumMg);
    map['total_potassium_mg'] = Variable<double>(totalPotassiumMg);
    map['total_magnesium_mg'] = Variable<double>(totalMagnesiumMg);
    map['carb_goal_met'] = Variable<int>(carbGoalMet);
    map['protein_goal_met'] = Variable<int>(proteinGoalMet);
    map['fat_goal_met'] = Variable<int>(fatGoalMet);
    if (!nullToAbsent || avgGlucoseMgDl != null) {
      map['avg_glucose_mg_dl'] = Variable<double>(avgGlucoseMgDl);
    }
    if (!nullToAbsent || avgKetonesMmolL != null) {
      map['avg_ketones_mmol_l'] = Variable<double>(avgKetonesMmolL);
    }
    if (!nullToAbsent || avgGkiScore != null) {
      map['avg_gki_score'] = Variable<double>(avgGkiScore);
    }
    if (!nullToAbsent || minGkiScore != null) {
      map['min_gki_score'] = Variable<double>(minGkiScore);
    }
    if (!nullToAbsent || maxGkiScore != null) {
      map['max_gki_score'] = Variable<double>(maxGkiScore);
    }
    map['in_ketosis'] = Variable<int>(inKetosis);
    map['in_therapeutic_ketosis'] = Variable<int>(inTherapeuticKetosis);
    if (!nullToAbsent || avgHeartRateBpm != null) {
      map['avg_heart_rate_bpm'] = Variable<int>(avgHeartRateBpm);
    }
    if (!nullToAbsent || avgHrvMs != null) {
      map['avg_hrv_ms'] = Variable<double>(avgHrvMs);
    }
    if (!nullToAbsent || totalSteps != null) {
      map['total_steps'] = Variable<int>(totalSteps);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || weightChangeFromStartKg != null) {
      map['weight_change_from_start_kg'] =
          Variable<double>(weightChangeFromStartKg);
    }
    if (!nullToAbsent || avgEnergyLevel != null) {
      map['avg_energy_level'] = Variable<double>(avgEnergyLevel);
    }
    if (!nullToAbsent || avgMentalClarity != null) {
      map['avg_mental_clarity'] = Variable<double>(avgMentalClarity);
    }
    if (!nullToAbsent || avgMoodRating != null) {
      map['avg_mood_rating'] = Variable<double>(avgMoodRating);
    }
    map['diet_entries_count'] = Variable<int>(dietEntriesCount);
    map['health_logs_count'] = Variable<int>(healthLogsCount);
    map['last_calculated_at'] = Variable<String>(lastCalculatedAt);
    map['synced'] = Variable<int>(synced);
    return map;
  }

  DailySummariesCompanion toCompanion(bool nullToAbsent) {
    return DailySummariesCompanion(
      summaryId: Value(summaryId),
      userId: Value(userId),
      date: Value(date),
      totalEnergyKcal: Value(totalEnergyKcal),
      totalProteinG: Value(totalProteinG),
      totalFatG: Value(totalFatG),
      totalCarbohydrateG: Value(totalCarbohydrateG),
      totalNetCarbsG: Value(totalNetCarbsG),
      totalFiberG: Value(totalFiberG),
      totalSodiumMg: Value(totalSodiumMg),
      totalPotassiumMg: Value(totalPotassiumMg),
      totalMagnesiumMg: Value(totalMagnesiumMg),
      carbGoalMet: Value(carbGoalMet),
      proteinGoalMet: Value(proteinGoalMet),
      fatGoalMet: Value(fatGoalMet),
      avgGlucoseMgDl: avgGlucoseMgDl == null && nullToAbsent
          ? const Value.absent()
          : Value(avgGlucoseMgDl),
      avgKetonesMmolL: avgKetonesMmolL == null && nullToAbsent
          ? const Value.absent()
          : Value(avgKetonesMmolL),
      avgGkiScore: avgGkiScore == null && nullToAbsent
          ? const Value.absent()
          : Value(avgGkiScore),
      minGkiScore: minGkiScore == null && nullToAbsent
          ? const Value.absent()
          : Value(minGkiScore),
      maxGkiScore: maxGkiScore == null && nullToAbsent
          ? const Value.absent()
          : Value(maxGkiScore),
      inKetosis: Value(inKetosis),
      inTherapeuticKetosis: Value(inTherapeuticKetosis),
      avgHeartRateBpm: avgHeartRateBpm == null && nullToAbsent
          ? const Value.absent()
          : Value(avgHeartRateBpm),
      avgHrvMs: avgHrvMs == null && nullToAbsent
          ? const Value.absent()
          : Value(avgHrvMs),
      totalSteps: totalSteps == null && nullToAbsent
          ? const Value.absent()
          : Value(totalSteps),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      weightChangeFromStartKg: weightChangeFromStartKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightChangeFromStartKg),
      avgEnergyLevel: avgEnergyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(avgEnergyLevel),
      avgMentalClarity: avgMentalClarity == null && nullToAbsent
          ? const Value.absent()
          : Value(avgMentalClarity),
      avgMoodRating: avgMoodRating == null && nullToAbsent
          ? const Value.absent()
          : Value(avgMoodRating),
      dietEntriesCount: Value(dietEntriesCount),
      healthLogsCount: Value(healthLogsCount),
      lastCalculatedAt: Value(lastCalculatedAt),
      synced: Value(synced),
    );
  }

  factory DailySummary.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailySummary(
      summaryId: serializer.fromJson<int>(json['summaryId']),
      userId: serializer.fromJson<int>(json['userId']),
      date: serializer.fromJson<String>(json['date']),
      totalEnergyKcal: serializer.fromJson<double>(json['totalEnergyKcal']),
      totalProteinG: serializer.fromJson<double>(json['totalProteinG']),
      totalFatG: serializer.fromJson<double>(json['totalFatG']),
      totalCarbohydrateG:
          serializer.fromJson<double>(json['totalCarbohydrateG']),
      totalNetCarbsG: serializer.fromJson<double>(json['totalNetCarbsG']),
      totalFiberG: serializer.fromJson<double>(json['totalFiberG']),
      totalSodiumMg: serializer.fromJson<double>(json['totalSodiumMg']),
      totalPotassiumMg: serializer.fromJson<double>(json['totalPotassiumMg']),
      totalMagnesiumMg: serializer.fromJson<double>(json['totalMagnesiumMg']),
      carbGoalMet: serializer.fromJson<int>(json['carbGoalMet']),
      proteinGoalMet: serializer.fromJson<int>(json['proteinGoalMet']),
      fatGoalMet: serializer.fromJson<int>(json['fatGoalMet']),
      avgGlucoseMgDl: serializer.fromJson<double?>(json['avgGlucoseMgDl']),
      avgKetonesMmolL: serializer.fromJson<double?>(json['avgKetonesMmolL']),
      avgGkiScore: serializer.fromJson<double?>(json['avgGkiScore']),
      minGkiScore: serializer.fromJson<double?>(json['minGkiScore']),
      maxGkiScore: serializer.fromJson<double?>(json['maxGkiScore']),
      inKetosis: serializer.fromJson<int>(json['inKetosis']),
      inTherapeuticKetosis:
          serializer.fromJson<int>(json['inTherapeuticKetosis']),
      avgHeartRateBpm: serializer.fromJson<int?>(json['avgHeartRateBpm']),
      avgHrvMs: serializer.fromJson<double?>(json['avgHrvMs']),
      totalSteps: serializer.fromJson<int?>(json['totalSteps']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      weightChangeFromStartKg:
          serializer.fromJson<double?>(json['weightChangeFromStartKg']),
      avgEnergyLevel: serializer.fromJson<double?>(json['avgEnergyLevel']),
      avgMentalClarity: serializer.fromJson<double?>(json['avgMentalClarity']),
      avgMoodRating: serializer.fromJson<double?>(json['avgMoodRating']),
      dietEntriesCount: serializer.fromJson<int>(json['dietEntriesCount']),
      healthLogsCount: serializer.fromJson<int>(json['healthLogsCount']),
      lastCalculatedAt: serializer.fromJson<String>(json['lastCalculatedAt']),
      synced: serializer.fromJson<int>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'summaryId': serializer.toJson<int>(summaryId),
      'userId': serializer.toJson<int>(userId),
      'date': serializer.toJson<String>(date),
      'totalEnergyKcal': serializer.toJson<double>(totalEnergyKcal),
      'totalProteinG': serializer.toJson<double>(totalProteinG),
      'totalFatG': serializer.toJson<double>(totalFatG),
      'totalCarbohydrateG': serializer.toJson<double>(totalCarbohydrateG),
      'totalNetCarbsG': serializer.toJson<double>(totalNetCarbsG),
      'totalFiberG': serializer.toJson<double>(totalFiberG),
      'totalSodiumMg': serializer.toJson<double>(totalSodiumMg),
      'totalPotassiumMg': serializer.toJson<double>(totalPotassiumMg),
      'totalMagnesiumMg': serializer.toJson<double>(totalMagnesiumMg),
      'carbGoalMet': serializer.toJson<int>(carbGoalMet),
      'proteinGoalMet': serializer.toJson<int>(proteinGoalMet),
      'fatGoalMet': serializer.toJson<int>(fatGoalMet),
      'avgGlucoseMgDl': serializer.toJson<double?>(avgGlucoseMgDl),
      'avgKetonesMmolL': serializer.toJson<double?>(avgKetonesMmolL),
      'avgGkiScore': serializer.toJson<double?>(avgGkiScore),
      'minGkiScore': serializer.toJson<double?>(minGkiScore),
      'maxGkiScore': serializer.toJson<double?>(maxGkiScore),
      'inKetosis': serializer.toJson<int>(inKetosis),
      'inTherapeuticKetosis': serializer.toJson<int>(inTherapeuticKetosis),
      'avgHeartRateBpm': serializer.toJson<int?>(avgHeartRateBpm),
      'avgHrvMs': serializer.toJson<double?>(avgHrvMs),
      'totalSteps': serializer.toJson<int?>(totalSteps),
      'weightKg': serializer.toJson<double?>(weightKg),
      'weightChangeFromStartKg':
          serializer.toJson<double?>(weightChangeFromStartKg),
      'avgEnergyLevel': serializer.toJson<double?>(avgEnergyLevel),
      'avgMentalClarity': serializer.toJson<double?>(avgMentalClarity),
      'avgMoodRating': serializer.toJson<double?>(avgMoodRating),
      'dietEntriesCount': serializer.toJson<int>(dietEntriesCount),
      'healthLogsCount': serializer.toJson<int>(healthLogsCount),
      'lastCalculatedAt': serializer.toJson<String>(lastCalculatedAt),
      'synced': serializer.toJson<int>(synced),
    };
  }

  DailySummary copyWith(
          {int? summaryId,
          int? userId,
          String? date,
          double? totalEnergyKcal,
          double? totalProteinG,
          double? totalFatG,
          double? totalCarbohydrateG,
          double? totalNetCarbsG,
          double? totalFiberG,
          double? totalSodiumMg,
          double? totalPotassiumMg,
          double? totalMagnesiumMg,
          int? carbGoalMet,
          int? proteinGoalMet,
          int? fatGoalMet,
          Value<double?> avgGlucoseMgDl = const Value.absent(),
          Value<double?> avgKetonesMmolL = const Value.absent(),
          Value<double?> avgGkiScore = const Value.absent(),
          Value<double?> minGkiScore = const Value.absent(),
          Value<double?> maxGkiScore = const Value.absent(),
          int? inKetosis,
          int? inTherapeuticKetosis,
          Value<int?> avgHeartRateBpm = const Value.absent(),
          Value<double?> avgHrvMs = const Value.absent(),
          Value<int?> totalSteps = const Value.absent(),
          Value<double?> weightKg = const Value.absent(),
          Value<double?> weightChangeFromStartKg = const Value.absent(),
          Value<double?> avgEnergyLevel = const Value.absent(),
          Value<double?> avgMentalClarity = const Value.absent(),
          Value<double?> avgMoodRating = const Value.absent(),
          int? dietEntriesCount,
          int? healthLogsCount,
          String? lastCalculatedAt,
          int? synced}) =>
      DailySummary(
        summaryId: summaryId ?? this.summaryId,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        totalEnergyKcal: totalEnergyKcal ?? this.totalEnergyKcal,
        totalProteinG: totalProteinG ?? this.totalProteinG,
        totalFatG: totalFatG ?? this.totalFatG,
        totalCarbohydrateG: totalCarbohydrateG ?? this.totalCarbohydrateG,
        totalNetCarbsG: totalNetCarbsG ?? this.totalNetCarbsG,
        totalFiberG: totalFiberG ?? this.totalFiberG,
        totalSodiumMg: totalSodiumMg ?? this.totalSodiumMg,
        totalPotassiumMg: totalPotassiumMg ?? this.totalPotassiumMg,
        totalMagnesiumMg: totalMagnesiumMg ?? this.totalMagnesiumMg,
        carbGoalMet: carbGoalMet ?? this.carbGoalMet,
        proteinGoalMet: proteinGoalMet ?? this.proteinGoalMet,
        fatGoalMet: fatGoalMet ?? this.fatGoalMet,
        avgGlucoseMgDl:
            avgGlucoseMgDl.present ? avgGlucoseMgDl.value : this.avgGlucoseMgDl,
        avgKetonesMmolL: avgKetonesMmolL.present
            ? avgKetonesMmolL.value
            : this.avgKetonesMmolL,
        avgGkiScore: avgGkiScore.present ? avgGkiScore.value : this.avgGkiScore,
        minGkiScore: minGkiScore.present ? minGkiScore.value : this.minGkiScore,
        maxGkiScore: maxGkiScore.present ? maxGkiScore.value : this.maxGkiScore,
        inKetosis: inKetosis ?? this.inKetosis,
        inTherapeuticKetosis: inTherapeuticKetosis ?? this.inTherapeuticKetosis,
        avgHeartRateBpm: avgHeartRateBpm.present
            ? avgHeartRateBpm.value
            : this.avgHeartRateBpm,
        avgHrvMs: avgHrvMs.present ? avgHrvMs.value : this.avgHrvMs,
        totalSteps: totalSteps.present ? totalSteps.value : this.totalSteps,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        weightChangeFromStartKg: weightChangeFromStartKg.present
            ? weightChangeFromStartKg.value
            : this.weightChangeFromStartKg,
        avgEnergyLevel:
            avgEnergyLevel.present ? avgEnergyLevel.value : this.avgEnergyLevel,
        avgMentalClarity: avgMentalClarity.present
            ? avgMentalClarity.value
            : this.avgMentalClarity,
        avgMoodRating:
            avgMoodRating.present ? avgMoodRating.value : this.avgMoodRating,
        dietEntriesCount: dietEntriesCount ?? this.dietEntriesCount,
        healthLogsCount: healthLogsCount ?? this.healthLogsCount,
        lastCalculatedAt: lastCalculatedAt ?? this.lastCalculatedAt,
        synced: synced ?? this.synced,
      );
  DailySummary copyWithCompanion(DailySummariesCompanion data) {
    return DailySummary(
      summaryId: data.summaryId.present ? data.summaryId.value : this.summaryId,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      totalEnergyKcal: data.totalEnergyKcal.present
          ? data.totalEnergyKcal.value
          : this.totalEnergyKcal,
      totalProteinG: data.totalProteinG.present
          ? data.totalProteinG.value
          : this.totalProteinG,
      totalFatG: data.totalFatG.present ? data.totalFatG.value : this.totalFatG,
      totalCarbohydrateG: data.totalCarbohydrateG.present
          ? data.totalCarbohydrateG.value
          : this.totalCarbohydrateG,
      totalNetCarbsG: data.totalNetCarbsG.present
          ? data.totalNetCarbsG.value
          : this.totalNetCarbsG,
      totalFiberG:
          data.totalFiberG.present ? data.totalFiberG.value : this.totalFiberG,
      totalSodiumMg: data.totalSodiumMg.present
          ? data.totalSodiumMg.value
          : this.totalSodiumMg,
      totalPotassiumMg: data.totalPotassiumMg.present
          ? data.totalPotassiumMg.value
          : this.totalPotassiumMg,
      totalMagnesiumMg: data.totalMagnesiumMg.present
          ? data.totalMagnesiumMg.value
          : this.totalMagnesiumMg,
      carbGoalMet:
          data.carbGoalMet.present ? data.carbGoalMet.value : this.carbGoalMet,
      proteinGoalMet: data.proteinGoalMet.present
          ? data.proteinGoalMet.value
          : this.proteinGoalMet,
      fatGoalMet:
          data.fatGoalMet.present ? data.fatGoalMet.value : this.fatGoalMet,
      avgGlucoseMgDl: data.avgGlucoseMgDl.present
          ? data.avgGlucoseMgDl.value
          : this.avgGlucoseMgDl,
      avgKetonesMmolL: data.avgKetonesMmolL.present
          ? data.avgKetonesMmolL.value
          : this.avgKetonesMmolL,
      avgGkiScore:
          data.avgGkiScore.present ? data.avgGkiScore.value : this.avgGkiScore,
      minGkiScore:
          data.minGkiScore.present ? data.minGkiScore.value : this.minGkiScore,
      maxGkiScore:
          data.maxGkiScore.present ? data.maxGkiScore.value : this.maxGkiScore,
      inKetosis: data.inKetosis.present ? data.inKetosis.value : this.inKetosis,
      inTherapeuticKetosis: data.inTherapeuticKetosis.present
          ? data.inTherapeuticKetosis.value
          : this.inTherapeuticKetosis,
      avgHeartRateBpm: data.avgHeartRateBpm.present
          ? data.avgHeartRateBpm.value
          : this.avgHeartRateBpm,
      avgHrvMs: data.avgHrvMs.present ? data.avgHrvMs.value : this.avgHrvMs,
      totalSteps:
          data.totalSteps.present ? data.totalSteps.value : this.totalSteps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      weightChangeFromStartKg: data.weightChangeFromStartKg.present
          ? data.weightChangeFromStartKg.value
          : this.weightChangeFromStartKg,
      avgEnergyLevel: data.avgEnergyLevel.present
          ? data.avgEnergyLevel.value
          : this.avgEnergyLevel,
      avgMentalClarity: data.avgMentalClarity.present
          ? data.avgMentalClarity.value
          : this.avgMentalClarity,
      avgMoodRating: data.avgMoodRating.present
          ? data.avgMoodRating.value
          : this.avgMoodRating,
      dietEntriesCount: data.dietEntriesCount.present
          ? data.dietEntriesCount.value
          : this.dietEntriesCount,
      healthLogsCount: data.healthLogsCount.present
          ? data.healthLogsCount.value
          : this.healthLogsCount,
      lastCalculatedAt: data.lastCalculatedAt.present
          ? data.lastCalculatedAt.value
          : this.lastCalculatedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailySummary(')
          ..write('summaryId: $summaryId, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('totalEnergyKcal: $totalEnergyKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('totalCarbohydrateG: $totalCarbohydrateG, ')
          ..write('totalNetCarbsG: $totalNetCarbsG, ')
          ..write('totalFiberG: $totalFiberG, ')
          ..write('totalSodiumMg: $totalSodiumMg, ')
          ..write('totalPotassiumMg: $totalPotassiumMg, ')
          ..write('totalMagnesiumMg: $totalMagnesiumMg, ')
          ..write('carbGoalMet: $carbGoalMet, ')
          ..write('proteinGoalMet: $proteinGoalMet, ')
          ..write('fatGoalMet: $fatGoalMet, ')
          ..write('avgGlucoseMgDl: $avgGlucoseMgDl, ')
          ..write('avgKetonesMmolL: $avgKetonesMmolL, ')
          ..write('avgGkiScore: $avgGkiScore, ')
          ..write('minGkiScore: $minGkiScore, ')
          ..write('maxGkiScore: $maxGkiScore, ')
          ..write('inKetosis: $inKetosis, ')
          ..write('inTherapeuticKetosis: $inTherapeuticKetosis, ')
          ..write('avgHeartRateBpm: $avgHeartRateBpm, ')
          ..write('avgHrvMs: $avgHrvMs, ')
          ..write('totalSteps: $totalSteps, ')
          ..write('weightKg: $weightKg, ')
          ..write('weightChangeFromStartKg: $weightChangeFromStartKg, ')
          ..write('avgEnergyLevel: $avgEnergyLevel, ')
          ..write('avgMentalClarity: $avgMentalClarity, ')
          ..write('avgMoodRating: $avgMoodRating, ')
          ..write('dietEntriesCount: $dietEntriesCount, ')
          ..write('healthLogsCount: $healthLogsCount, ')
          ..write('lastCalculatedAt: $lastCalculatedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        summaryId,
        userId,
        date,
        totalEnergyKcal,
        totalProteinG,
        totalFatG,
        totalCarbohydrateG,
        totalNetCarbsG,
        totalFiberG,
        totalSodiumMg,
        totalPotassiumMg,
        totalMagnesiumMg,
        carbGoalMet,
        proteinGoalMet,
        fatGoalMet,
        avgGlucoseMgDl,
        avgKetonesMmolL,
        avgGkiScore,
        minGkiScore,
        maxGkiScore,
        inKetosis,
        inTherapeuticKetosis,
        avgHeartRateBpm,
        avgHrvMs,
        totalSteps,
        weightKg,
        weightChangeFromStartKg,
        avgEnergyLevel,
        avgMentalClarity,
        avgMoodRating,
        dietEntriesCount,
        healthLogsCount,
        lastCalculatedAt,
        synced
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailySummary &&
          other.summaryId == this.summaryId &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.totalEnergyKcal == this.totalEnergyKcal &&
          other.totalProteinG == this.totalProteinG &&
          other.totalFatG == this.totalFatG &&
          other.totalCarbohydrateG == this.totalCarbohydrateG &&
          other.totalNetCarbsG == this.totalNetCarbsG &&
          other.totalFiberG == this.totalFiberG &&
          other.totalSodiumMg == this.totalSodiumMg &&
          other.totalPotassiumMg == this.totalPotassiumMg &&
          other.totalMagnesiumMg == this.totalMagnesiumMg &&
          other.carbGoalMet == this.carbGoalMet &&
          other.proteinGoalMet == this.proteinGoalMet &&
          other.fatGoalMet == this.fatGoalMet &&
          other.avgGlucoseMgDl == this.avgGlucoseMgDl &&
          other.avgKetonesMmolL == this.avgKetonesMmolL &&
          other.avgGkiScore == this.avgGkiScore &&
          other.minGkiScore == this.minGkiScore &&
          other.maxGkiScore == this.maxGkiScore &&
          other.inKetosis == this.inKetosis &&
          other.inTherapeuticKetosis == this.inTherapeuticKetosis &&
          other.avgHeartRateBpm == this.avgHeartRateBpm &&
          other.avgHrvMs == this.avgHrvMs &&
          other.totalSteps == this.totalSteps &&
          other.weightKg == this.weightKg &&
          other.weightChangeFromStartKg == this.weightChangeFromStartKg &&
          other.avgEnergyLevel == this.avgEnergyLevel &&
          other.avgMentalClarity == this.avgMentalClarity &&
          other.avgMoodRating == this.avgMoodRating &&
          other.dietEntriesCount == this.dietEntriesCount &&
          other.healthLogsCount == this.healthLogsCount &&
          other.lastCalculatedAt == this.lastCalculatedAt &&
          other.synced == this.synced);
}

class DailySummariesCompanion extends UpdateCompanion<DailySummary> {
  final Value<int> summaryId;
  final Value<int> userId;
  final Value<String> date;
  final Value<double> totalEnergyKcal;
  final Value<double> totalProteinG;
  final Value<double> totalFatG;
  final Value<double> totalCarbohydrateG;
  final Value<double> totalNetCarbsG;
  final Value<double> totalFiberG;
  final Value<double> totalSodiumMg;
  final Value<double> totalPotassiumMg;
  final Value<double> totalMagnesiumMg;
  final Value<int> carbGoalMet;
  final Value<int> proteinGoalMet;
  final Value<int> fatGoalMet;
  final Value<double?> avgGlucoseMgDl;
  final Value<double?> avgKetonesMmolL;
  final Value<double?> avgGkiScore;
  final Value<double?> minGkiScore;
  final Value<double?> maxGkiScore;
  final Value<int> inKetosis;
  final Value<int> inTherapeuticKetosis;
  final Value<int?> avgHeartRateBpm;
  final Value<double?> avgHrvMs;
  final Value<int?> totalSteps;
  final Value<double?> weightKg;
  final Value<double?> weightChangeFromStartKg;
  final Value<double?> avgEnergyLevel;
  final Value<double?> avgMentalClarity;
  final Value<double?> avgMoodRating;
  final Value<int> dietEntriesCount;
  final Value<int> healthLogsCount;
  final Value<String> lastCalculatedAt;
  final Value<int> synced;
  const DailySummariesCompanion({
    this.summaryId = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.totalEnergyKcal = const Value.absent(),
    this.totalProteinG = const Value.absent(),
    this.totalFatG = const Value.absent(),
    this.totalCarbohydrateG = const Value.absent(),
    this.totalNetCarbsG = const Value.absent(),
    this.totalFiberG = const Value.absent(),
    this.totalSodiumMg = const Value.absent(),
    this.totalPotassiumMg = const Value.absent(),
    this.totalMagnesiumMg = const Value.absent(),
    this.carbGoalMet = const Value.absent(),
    this.proteinGoalMet = const Value.absent(),
    this.fatGoalMet = const Value.absent(),
    this.avgGlucoseMgDl = const Value.absent(),
    this.avgKetonesMmolL = const Value.absent(),
    this.avgGkiScore = const Value.absent(),
    this.minGkiScore = const Value.absent(),
    this.maxGkiScore = const Value.absent(),
    this.inKetosis = const Value.absent(),
    this.inTherapeuticKetosis = const Value.absent(),
    this.avgHeartRateBpm = const Value.absent(),
    this.avgHrvMs = const Value.absent(),
    this.totalSteps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.weightChangeFromStartKg = const Value.absent(),
    this.avgEnergyLevel = const Value.absent(),
    this.avgMentalClarity = const Value.absent(),
    this.avgMoodRating = const Value.absent(),
    this.dietEntriesCount = const Value.absent(),
    this.healthLogsCount = const Value.absent(),
    this.lastCalculatedAt = const Value.absent(),
    this.synced = const Value.absent(),
  });
  DailySummariesCompanion.insert({
    this.summaryId = const Value.absent(),
    required int userId,
    required String date,
    this.totalEnergyKcal = const Value.absent(),
    this.totalProteinG = const Value.absent(),
    this.totalFatG = const Value.absent(),
    this.totalCarbohydrateG = const Value.absent(),
    this.totalNetCarbsG = const Value.absent(),
    this.totalFiberG = const Value.absent(),
    this.totalSodiumMg = const Value.absent(),
    this.totalPotassiumMg = const Value.absent(),
    this.totalMagnesiumMg = const Value.absent(),
    this.carbGoalMet = const Value.absent(),
    this.proteinGoalMet = const Value.absent(),
    this.fatGoalMet = const Value.absent(),
    this.avgGlucoseMgDl = const Value.absent(),
    this.avgKetonesMmolL = const Value.absent(),
    this.avgGkiScore = const Value.absent(),
    this.minGkiScore = const Value.absent(),
    this.maxGkiScore = const Value.absent(),
    this.inKetosis = const Value.absent(),
    this.inTherapeuticKetosis = const Value.absent(),
    this.avgHeartRateBpm = const Value.absent(),
    this.avgHrvMs = const Value.absent(),
    this.totalSteps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.weightChangeFromStartKg = const Value.absent(),
    this.avgEnergyLevel = const Value.absent(),
    this.avgMentalClarity = const Value.absent(),
    this.avgMoodRating = const Value.absent(),
    this.dietEntriesCount = const Value.absent(),
    this.healthLogsCount = const Value.absent(),
    this.lastCalculatedAt = const Value.absent(),
    this.synced = const Value.absent(),
  })  : userId = Value(userId),
        date = Value(date);
  static Insertable<DailySummary> custom({
    Expression<int>? summaryId,
    Expression<int>? userId,
    Expression<String>? date,
    Expression<double>? totalEnergyKcal,
    Expression<double>? totalProteinG,
    Expression<double>? totalFatG,
    Expression<double>? totalCarbohydrateG,
    Expression<double>? totalNetCarbsG,
    Expression<double>? totalFiberG,
    Expression<double>? totalSodiumMg,
    Expression<double>? totalPotassiumMg,
    Expression<double>? totalMagnesiumMg,
    Expression<int>? carbGoalMet,
    Expression<int>? proteinGoalMet,
    Expression<int>? fatGoalMet,
    Expression<double>? avgGlucoseMgDl,
    Expression<double>? avgKetonesMmolL,
    Expression<double>? avgGkiScore,
    Expression<double>? minGkiScore,
    Expression<double>? maxGkiScore,
    Expression<int>? inKetosis,
    Expression<int>? inTherapeuticKetosis,
    Expression<int>? avgHeartRateBpm,
    Expression<double>? avgHrvMs,
    Expression<int>? totalSteps,
    Expression<double>? weightKg,
    Expression<double>? weightChangeFromStartKg,
    Expression<double>? avgEnergyLevel,
    Expression<double>? avgMentalClarity,
    Expression<double>? avgMoodRating,
    Expression<int>? dietEntriesCount,
    Expression<int>? healthLogsCount,
    Expression<String>? lastCalculatedAt,
    Expression<int>? synced,
  }) {
    return RawValuesInsertable({
      if (summaryId != null) 'summary_id': summaryId,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (totalEnergyKcal != null) 'total_energy_kcal': totalEnergyKcal,
      if (totalProteinG != null) 'total_protein_g': totalProteinG,
      if (totalFatG != null) 'total_fat_g': totalFatG,
      if (totalCarbohydrateG != null)
        'total_carbohydrate_g': totalCarbohydrateG,
      if (totalNetCarbsG != null) 'total_net_carbs_g': totalNetCarbsG,
      if (totalFiberG != null) 'total_fiber_g': totalFiberG,
      if (totalSodiumMg != null) 'total_sodium_mg': totalSodiumMg,
      if (totalPotassiumMg != null) 'total_potassium_mg': totalPotassiumMg,
      if (totalMagnesiumMg != null) 'total_magnesium_mg': totalMagnesiumMg,
      if (carbGoalMet != null) 'carb_goal_met': carbGoalMet,
      if (proteinGoalMet != null) 'protein_goal_met': proteinGoalMet,
      if (fatGoalMet != null) 'fat_goal_met': fatGoalMet,
      if (avgGlucoseMgDl != null) 'avg_glucose_mg_dl': avgGlucoseMgDl,
      if (avgKetonesMmolL != null) 'avg_ketones_mmol_l': avgKetonesMmolL,
      if (avgGkiScore != null) 'avg_gki_score': avgGkiScore,
      if (minGkiScore != null) 'min_gki_score': minGkiScore,
      if (maxGkiScore != null) 'max_gki_score': maxGkiScore,
      if (inKetosis != null) 'in_ketosis': inKetosis,
      if (inTherapeuticKetosis != null)
        'in_therapeutic_ketosis': inTherapeuticKetosis,
      if (avgHeartRateBpm != null) 'avg_heart_rate_bpm': avgHeartRateBpm,
      if (avgHrvMs != null) 'avg_hrv_ms': avgHrvMs,
      if (totalSteps != null) 'total_steps': totalSteps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (weightChangeFromStartKg != null)
        'weight_change_from_start_kg': weightChangeFromStartKg,
      if (avgEnergyLevel != null) 'avg_energy_level': avgEnergyLevel,
      if (avgMentalClarity != null) 'avg_mental_clarity': avgMentalClarity,
      if (avgMoodRating != null) 'avg_mood_rating': avgMoodRating,
      if (dietEntriesCount != null) 'diet_entries_count': dietEntriesCount,
      if (healthLogsCount != null) 'health_logs_count': healthLogsCount,
      if (lastCalculatedAt != null) 'last_calculated_at': lastCalculatedAt,
      if (synced != null) 'synced': synced,
    });
  }

  DailySummariesCompanion copyWith(
      {Value<int>? summaryId,
      Value<int>? userId,
      Value<String>? date,
      Value<double>? totalEnergyKcal,
      Value<double>? totalProteinG,
      Value<double>? totalFatG,
      Value<double>? totalCarbohydrateG,
      Value<double>? totalNetCarbsG,
      Value<double>? totalFiberG,
      Value<double>? totalSodiumMg,
      Value<double>? totalPotassiumMg,
      Value<double>? totalMagnesiumMg,
      Value<int>? carbGoalMet,
      Value<int>? proteinGoalMet,
      Value<int>? fatGoalMet,
      Value<double?>? avgGlucoseMgDl,
      Value<double?>? avgKetonesMmolL,
      Value<double?>? avgGkiScore,
      Value<double?>? minGkiScore,
      Value<double?>? maxGkiScore,
      Value<int>? inKetosis,
      Value<int>? inTherapeuticKetosis,
      Value<int?>? avgHeartRateBpm,
      Value<double?>? avgHrvMs,
      Value<int?>? totalSteps,
      Value<double?>? weightKg,
      Value<double?>? weightChangeFromStartKg,
      Value<double?>? avgEnergyLevel,
      Value<double?>? avgMentalClarity,
      Value<double?>? avgMoodRating,
      Value<int>? dietEntriesCount,
      Value<int>? healthLogsCount,
      Value<String>? lastCalculatedAt,
      Value<int>? synced}) {
    return DailySummariesCompanion(
      summaryId: summaryId ?? this.summaryId,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      totalEnergyKcal: totalEnergyKcal ?? this.totalEnergyKcal,
      totalProteinG: totalProteinG ?? this.totalProteinG,
      totalFatG: totalFatG ?? this.totalFatG,
      totalCarbohydrateG: totalCarbohydrateG ?? this.totalCarbohydrateG,
      totalNetCarbsG: totalNetCarbsG ?? this.totalNetCarbsG,
      totalFiberG: totalFiberG ?? this.totalFiberG,
      totalSodiumMg: totalSodiumMg ?? this.totalSodiumMg,
      totalPotassiumMg: totalPotassiumMg ?? this.totalPotassiumMg,
      totalMagnesiumMg: totalMagnesiumMg ?? this.totalMagnesiumMg,
      carbGoalMet: carbGoalMet ?? this.carbGoalMet,
      proteinGoalMet: proteinGoalMet ?? this.proteinGoalMet,
      fatGoalMet: fatGoalMet ?? this.fatGoalMet,
      avgGlucoseMgDl: avgGlucoseMgDl ?? this.avgGlucoseMgDl,
      avgKetonesMmolL: avgKetonesMmolL ?? this.avgKetonesMmolL,
      avgGkiScore: avgGkiScore ?? this.avgGkiScore,
      minGkiScore: minGkiScore ?? this.minGkiScore,
      maxGkiScore: maxGkiScore ?? this.maxGkiScore,
      inKetosis: inKetosis ?? this.inKetosis,
      inTherapeuticKetosis: inTherapeuticKetosis ?? this.inTherapeuticKetosis,
      avgHeartRateBpm: avgHeartRateBpm ?? this.avgHeartRateBpm,
      avgHrvMs: avgHrvMs ?? this.avgHrvMs,
      totalSteps: totalSteps ?? this.totalSteps,
      weightKg: weightKg ?? this.weightKg,
      weightChangeFromStartKg:
          weightChangeFromStartKg ?? this.weightChangeFromStartKg,
      avgEnergyLevel: avgEnergyLevel ?? this.avgEnergyLevel,
      avgMentalClarity: avgMentalClarity ?? this.avgMentalClarity,
      avgMoodRating: avgMoodRating ?? this.avgMoodRating,
      dietEntriesCount: dietEntriesCount ?? this.dietEntriesCount,
      healthLogsCount: healthLogsCount ?? this.healthLogsCount,
      lastCalculatedAt: lastCalculatedAt ?? this.lastCalculatedAt,
      synced: synced ?? this.synced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (summaryId.present) {
      map['summary_id'] = Variable<int>(summaryId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (totalEnergyKcal.present) {
      map['total_energy_kcal'] = Variable<double>(totalEnergyKcal.value);
    }
    if (totalProteinG.present) {
      map['total_protein_g'] = Variable<double>(totalProteinG.value);
    }
    if (totalFatG.present) {
      map['total_fat_g'] = Variable<double>(totalFatG.value);
    }
    if (totalCarbohydrateG.present) {
      map['total_carbohydrate_g'] = Variable<double>(totalCarbohydrateG.value);
    }
    if (totalNetCarbsG.present) {
      map['total_net_carbs_g'] = Variable<double>(totalNetCarbsG.value);
    }
    if (totalFiberG.present) {
      map['total_fiber_g'] = Variable<double>(totalFiberG.value);
    }
    if (totalSodiumMg.present) {
      map['total_sodium_mg'] = Variable<double>(totalSodiumMg.value);
    }
    if (totalPotassiumMg.present) {
      map['total_potassium_mg'] = Variable<double>(totalPotassiumMg.value);
    }
    if (totalMagnesiumMg.present) {
      map['total_magnesium_mg'] = Variable<double>(totalMagnesiumMg.value);
    }
    if (carbGoalMet.present) {
      map['carb_goal_met'] = Variable<int>(carbGoalMet.value);
    }
    if (proteinGoalMet.present) {
      map['protein_goal_met'] = Variable<int>(proteinGoalMet.value);
    }
    if (fatGoalMet.present) {
      map['fat_goal_met'] = Variable<int>(fatGoalMet.value);
    }
    if (avgGlucoseMgDl.present) {
      map['avg_glucose_mg_dl'] = Variable<double>(avgGlucoseMgDl.value);
    }
    if (avgKetonesMmolL.present) {
      map['avg_ketones_mmol_l'] = Variable<double>(avgKetonesMmolL.value);
    }
    if (avgGkiScore.present) {
      map['avg_gki_score'] = Variable<double>(avgGkiScore.value);
    }
    if (minGkiScore.present) {
      map['min_gki_score'] = Variable<double>(minGkiScore.value);
    }
    if (maxGkiScore.present) {
      map['max_gki_score'] = Variable<double>(maxGkiScore.value);
    }
    if (inKetosis.present) {
      map['in_ketosis'] = Variable<int>(inKetosis.value);
    }
    if (inTherapeuticKetosis.present) {
      map['in_therapeutic_ketosis'] = Variable<int>(inTherapeuticKetosis.value);
    }
    if (avgHeartRateBpm.present) {
      map['avg_heart_rate_bpm'] = Variable<int>(avgHeartRateBpm.value);
    }
    if (avgHrvMs.present) {
      map['avg_hrv_ms'] = Variable<double>(avgHrvMs.value);
    }
    if (totalSteps.present) {
      map['total_steps'] = Variable<int>(totalSteps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (weightChangeFromStartKg.present) {
      map['weight_change_from_start_kg'] =
          Variable<double>(weightChangeFromStartKg.value);
    }
    if (avgEnergyLevel.present) {
      map['avg_energy_level'] = Variable<double>(avgEnergyLevel.value);
    }
    if (avgMentalClarity.present) {
      map['avg_mental_clarity'] = Variable<double>(avgMentalClarity.value);
    }
    if (avgMoodRating.present) {
      map['avg_mood_rating'] = Variable<double>(avgMoodRating.value);
    }
    if (dietEntriesCount.present) {
      map['diet_entries_count'] = Variable<int>(dietEntriesCount.value);
    }
    if (healthLogsCount.present) {
      map['health_logs_count'] = Variable<int>(healthLogsCount.value);
    }
    if (lastCalculatedAt.present) {
      map['last_calculated_at'] = Variable<String>(lastCalculatedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<int>(synced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailySummariesCompanion(')
          ..write('summaryId: $summaryId, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('totalEnergyKcal: $totalEnergyKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('totalCarbohydrateG: $totalCarbohydrateG, ')
          ..write('totalNetCarbsG: $totalNetCarbsG, ')
          ..write('totalFiberG: $totalFiberG, ')
          ..write('totalSodiumMg: $totalSodiumMg, ')
          ..write('totalPotassiumMg: $totalPotassiumMg, ')
          ..write('totalMagnesiumMg: $totalMagnesiumMg, ')
          ..write('carbGoalMet: $carbGoalMet, ')
          ..write('proteinGoalMet: $proteinGoalMet, ')
          ..write('fatGoalMet: $fatGoalMet, ')
          ..write('avgGlucoseMgDl: $avgGlucoseMgDl, ')
          ..write('avgKetonesMmolL: $avgKetonesMmolL, ')
          ..write('avgGkiScore: $avgGkiScore, ')
          ..write('minGkiScore: $minGkiScore, ')
          ..write('maxGkiScore: $maxGkiScore, ')
          ..write('inKetosis: $inKetosis, ')
          ..write('inTherapeuticKetosis: $inTherapeuticKetosis, ')
          ..write('avgHeartRateBpm: $avgHeartRateBpm, ')
          ..write('avgHrvMs: $avgHrvMs, ')
          ..write('totalSteps: $totalSteps, ')
          ..write('weightKg: $weightKg, ')
          ..write('weightChangeFromStartKg: $weightChangeFromStartKg, ')
          ..write('avgEnergyLevel: $avgEnergyLevel, ')
          ..write('avgMentalClarity: $avgMentalClarity, ')
          ..write('avgMoodRating: $avgMoodRating, ')
          ..write('dietEntriesCount: $dietEntriesCount, ')
          ..write('healthLogsCount: $healthLogsCount, ')
          ..write('lastCalculatedAt: $lastCalculatedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }
}

class $VitalsTable extends Vitals with TableInfo<$VitalsTable, Vital> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VitalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vitalIdMeta =
      const VerificationMeta('vitalId');
  @override
  late final GeneratedColumn<int> vitalId = GeneratedColumn<int>(
      'vital_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<String> recordedAt = GeneratedColumn<String>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _heartRateBpmMeta =
      const VerificationMeta('heartRateBpm');
  @override
  late final GeneratedColumn<int> heartRateBpm = GeneratedColumn<int>(
      'heart_rate_bpm', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _hrvMsMeta = const VerificationMeta('hrvMs');
  @override
  late final GeneratedColumn<double> hrvMs = GeneratedColumn<double>(
      'hrv_ms', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _restingHeartRateBpmMeta =
      const VerificationMeta('restingHeartRateBpm');
  @override
  late final GeneratedColumn<int> restingHeartRateBpm = GeneratedColumn<int>(
      'resting_heart_rate_bpm', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bodyTemperatureCelsiusMeta =
      const VerificationMeta('bodyTemperatureCelsius');
  @override
  late final GeneratedColumn<double> bodyTemperatureCelsius =
      GeneratedColumn<double>('body_temperature_celsius', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _skinTemperatureCelsiusMeta =
      const VerificationMeta('skinTemperatureCelsius');
  @override
  late final GeneratedColumn<double> skinTemperatureCelsius =
      GeneratedColumn<double>('skin_temperature_celsius', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sleepDurationHoursMeta =
      const VerificationMeta('sleepDurationHours');
  @override
  late final GeneratedColumn<double> sleepDurationHours =
      GeneratedColumn<double>('sleep_duration_hours', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _deepSleepHoursMeta =
      const VerificationMeta('deepSleepHours');
  @override
  late final GeneratedColumn<double> deepSleepHours = GeneratedColumn<double>(
      'deep_sleep_hours', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _remSleepHoursMeta =
      const VerificationMeta('remSleepHours');
  @override
  late final GeneratedColumn<double> remSleepHours = GeneratedColumn<double>(
      'rem_sleep_hours', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lightSleepHoursMeta =
      const VerificationMeta('lightSleepHours');
  @override
  late final GeneratedColumn<double> lightSleepHours = GeneratedColumn<double>(
      'light_sleep_hours', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sleepScoreMeta =
      const VerificationMeta('sleepScore');
  @override
  late final GeneratedColumn<int> sleepScore = GeneratedColumn<int>(
      'sleep_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _stepsCountMeta =
      const VerificationMeta('stepsCount');
  @override
  late final GeneratedColumn<int> stepsCount = GeneratedColumn<int>(
      'steps_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _activeCaloriesKcalMeta =
      const VerificationMeta('activeCaloriesKcal');
  @override
  late final GeneratedColumn<double> activeCaloriesKcal =
      GeneratedColumn<double>('active_calories_kcal', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _totalCaloriesKcalMeta =
      const VerificationMeta('totalCaloriesKcal');
  @override
  late final GeneratedColumn<double> totalCaloriesKcal =
      GeneratedColumn<double>('total_calories_kcal', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _distanceKmMeta =
      const VerificationMeta('distanceKm');
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
      'distance_km', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _respiratoryRateBpmMeta =
      const VerificationMeta('respiratoryRateBpm');
  @override
  late final GeneratedColumn<int> respiratoryRateBpm = GeneratedColumn<int>(
      'respiratory_rate_bpm', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _spo2PercentageMeta =
      const VerificationMeta('spo2Percentage');
  @override
  late final GeneratedColumn<double> spo2Percentage = GeneratedColumn<double>(
      'spo2_percentage', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manual'));
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<int> synced = GeneratedColumn<int>(
      'synced', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  @override
  List<GeneratedColumn> get $columns => [
        vitalId,
        userId,
        recordedAt,
        date,
        heartRateBpm,
        hrvMs,
        restingHeartRateBpm,
        bodyTemperatureCelsius,
        skinTemperatureCelsius,
        sleepDurationHours,
        deepSleepHours,
        remSleepHours,
        lightSleepHours,
        sleepScore,
        stepsCount,
        activeCaloriesKcal,
        totalCaloriesKcal,
        distanceKm,
        respiratoryRateBpm,
        spo2Percentage,
        source,
        deviceId,
        synced,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vitals';
  @override
  VerificationContext validateIntegrity(Insertable<Vital> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vital_id')) {
      context.handle(_vitalIdMeta,
          vitalId.isAcceptableOrUnknown(data['vital_id']!, _vitalIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('heart_rate_bpm')) {
      context.handle(
          _heartRateBpmMeta,
          heartRateBpm.isAcceptableOrUnknown(
              data['heart_rate_bpm']!, _heartRateBpmMeta));
    }
    if (data.containsKey('hrv_ms')) {
      context.handle(
          _hrvMsMeta, hrvMs.isAcceptableOrUnknown(data['hrv_ms']!, _hrvMsMeta));
    }
    if (data.containsKey('resting_heart_rate_bpm')) {
      context.handle(
          _restingHeartRateBpmMeta,
          restingHeartRateBpm.isAcceptableOrUnknown(
              data['resting_heart_rate_bpm']!, _restingHeartRateBpmMeta));
    }
    if (data.containsKey('body_temperature_celsius')) {
      context.handle(
          _bodyTemperatureCelsiusMeta,
          bodyTemperatureCelsius.isAcceptableOrUnknown(
              data['body_temperature_celsius']!, _bodyTemperatureCelsiusMeta));
    }
    if (data.containsKey('skin_temperature_celsius')) {
      context.handle(
          _skinTemperatureCelsiusMeta,
          skinTemperatureCelsius.isAcceptableOrUnknown(
              data['skin_temperature_celsius']!, _skinTemperatureCelsiusMeta));
    }
    if (data.containsKey('sleep_duration_hours')) {
      context.handle(
          _sleepDurationHoursMeta,
          sleepDurationHours.isAcceptableOrUnknown(
              data['sleep_duration_hours']!, _sleepDurationHoursMeta));
    }
    if (data.containsKey('deep_sleep_hours')) {
      context.handle(
          _deepSleepHoursMeta,
          deepSleepHours.isAcceptableOrUnknown(
              data['deep_sleep_hours']!, _deepSleepHoursMeta));
    }
    if (data.containsKey('rem_sleep_hours')) {
      context.handle(
          _remSleepHoursMeta,
          remSleepHours.isAcceptableOrUnknown(
              data['rem_sleep_hours']!, _remSleepHoursMeta));
    }
    if (data.containsKey('light_sleep_hours')) {
      context.handle(
          _lightSleepHoursMeta,
          lightSleepHours.isAcceptableOrUnknown(
              data['light_sleep_hours']!, _lightSleepHoursMeta));
    }
    if (data.containsKey('sleep_score')) {
      context.handle(
          _sleepScoreMeta,
          sleepScore.isAcceptableOrUnknown(
              data['sleep_score']!, _sleepScoreMeta));
    }
    if (data.containsKey('steps_count')) {
      context.handle(
          _stepsCountMeta,
          stepsCount.isAcceptableOrUnknown(
              data['steps_count']!, _stepsCountMeta));
    }
    if (data.containsKey('active_calories_kcal')) {
      context.handle(
          _activeCaloriesKcalMeta,
          activeCaloriesKcal.isAcceptableOrUnknown(
              data['active_calories_kcal']!, _activeCaloriesKcalMeta));
    }
    if (data.containsKey('total_calories_kcal')) {
      context.handle(
          _totalCaloriesKcalMeta,
          totalCaloriesKcal.isAcceptableOrUnknown(
              data['total_calories_kcal']!, _totalCaloriesKcalMeta));
    }
    if (data.containsKey('distance_km')) {
      context.handle(
          _distanceKmMeta,
          distanceKm.isAcceptableOrUnknown(
              data['distance_km']!, _distanceKmMeta));
    }
    if (data.containsKey('respiratory_rate_bpm')) {
      context.handle(
          _respiratoryRateBpmMeta,
          respiratoryRateBpm.isAcceptableOrUnknown(
              data['respiratory_rate_bpm']!, _respiratoryRateBpmMeta));
    }
    if (data.containsKey('spo2_percentage')) {
      context.handle(
          _spo2PercentageMeta,
          spo2Percentage.isAcceptableOrUnknown(
              data['spo2_percentage']!, _spo2PercentageMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vitalId};
  @override
  Vital map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vital(
      vitalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vital_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recorded_at'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      heartRateBpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}heart_rate_bpm']),
      hrvMs: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hrv_ms']),
      restingHeartRateBpm: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}resting_heart_rate_bpm']),
      bodyTemperatureCelsius: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}body_temperature_celsius']),
      skinTemperatureCelsius: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}skin_temperature_celsius']),
      sleepDurationHours: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}sleep_duration_hours']),
      deepSleepHours: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}deep_sleep_hours']),
      remSleepHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rem_sleep_hours']),
      lightSleepHours: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}light_sleep_hours']),
      sleepScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_score']),
      stepsCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps_count']),
      activeCaloriesKcal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}active_calories_kcal']),
      totalCaloriesKcal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_calories_kcal']),
      distanceKm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance_km']),
      respiratoryRateBpm: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}respiratory_rate_bpm']),
      spo2Percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}spo2_percentage']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $VitalsTable createAlias(String alias) {
    return $VitalsTable(attachedDatabase, alias);
  }
}

class Vital extends DataClass implements Insertable<Vital> {
  final int vitalId;
  final int userId;
  final String recordedAt;
  final String date;
  final int? heartRateBpm;
  final double? hrvMs;
  final int? restingHeartRateBpm;
  final double? bodyTemperatureCelsius;
  final double? skinTemperatureCelsius;
  final double? sleepDurationHours;
  final double? deepSleepHours;
  final double? remSleepHours;
  final double? lightSleepHours;
  final int? sleepScore;
  final int? stepsCount;
  final double? activeCaloriesKcal;
  final double? totalCaloriesKcal;
  final double? distanceKm;
  final int? respiratoryRateBpm;
  final double? spo2Percentage;
  final String source;
  final String? deviceId;
  final int synced;
  final String createdAt;
  const Vital(
      {required this.vitalId,
      required this.userId,
      required this.recordedAt,
      required this.date,
      this.heartRateBpm,
      this.hrvMs,
      this.restingHeartRateBpm,
      this.bodyTemperatureCelsius,
      this.skinTemperatureCelsius,
      this.sleepDurationHours,
      this.deepSleepHours,
      this.remSleepHours,
      this.lightSleepHours,
      this.sleepScore,
      this.stepsCount,
      this.activeCaloriesKcal,
      this.totalCaloriesKcal,
      this.distanceKm,
      this.respiratoryRateBpm,
      this.spo2Percentage,
      required this.source,
      this.deviceId,
      required this.synced,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vital_id'] = Variable<int>(vitalId);
    map['user_id'] = Variable<int>(userId);
    map['recorded_at'] = Variable<String>(recordedAt);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || heartRateBpm != null) {
      map['heart_rate_bpm'] = Variable<int>(heartRateBpm);
    }
    if (!nullToAbsent || hrvMs != null) {
      map['hrv_ms'] = Variable<double>(hrvMs);
    }
    if (!nullToAbsent || restingHeartRateBpm != null) {
      map['resting_heart_rate_bpm'] = Variable<int>(restingHeartRateBpm);
    }
    if (!nullToAbsent || bodyTemperatureCelsius != null) {
      map['body_temperature_celsius'] =
          Variable<double>(bodyTemperatureCelsius);
    }
    if (!nullToAbsent || skinTemperatureCelsius != null) {
      map['skin_temperature_celsius'] =
          Variable<double>(skinTemperatureCelsius);
    }
    if (!nullToAbsent || sleepDurationHours != null) {
      map['sleep_duration_hours'] = Variable<double>(sleepDurationHours);
    }
    if (!nullToAbsent || deepSleepHours != null) {
      map['deep_sleep_hours'] = Variable<double>(deepSleepHours);
    }
    if (!nullToAbsent || remSleepHours != null) {
      map['rem_sleep_hours'] = Variable<double>(remSleepHours);
    }
    if (!nullToAbsent || lightSleepHours != null) {
      map['light_sleep_hours'] = Variable<double>(lightSleepHours);
    }
    if (!nullToAbsent || sleepScore != null) {
      map['sleep_score'] = Variable<int>(sleepScore);
    }
    if (!nullToAbsent || stepsCount != null) {
      map['steps_count'] = Variable<int>(stepsCount);
    }
    if (!nullToAbsent || activeCaloriesKcal != null) {
      map['active_calories_kcal'] = Variable<double>(activeCaloriesKcal);
    }
    if (!nullToAbsent || totalCaloriesKcal != null) {
      map['total_calories_kcal'] = Variable<double>(totalCaloriesKcal);
    }
    if (!nullToAbsent || distanceKm != null) {
      map['distance_km'] = Variable<double>(distanceKm);
    }
    if (!nullToAbsent || respiratoryRateBpm != null) {
      map['respiratory_rate_bpm'] = Variable<int>(respiratoryRateBpm);
    }
    if (!nullToAbsent || spo2Percentage != null) {
      map['spo2_percentage'] = Variable<double>(spo2Percentage);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['synced'] = Variable<int>(synced);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  VitalsCompanion toCompanion(bool nullToAbsent) {
    return VitalsCompanion(
      vitalId: Value(vitalId),
      userId: Value(userId),
      recordedAt: Value(recordedAt),
      date: Value(date),
      heartRateBpm: heartRateBpm == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateBpm),
      hrvMs:
          hrvMs == null && nullToAbsent ? const Value.absent() : Value(hrvMs),
      restingHeartRateBpm: restingHeartRateBpm == null && nullToAbsent
          ? const Value.absent()
          : Value(restingHeartRateBpm),
      bodyTemperatureCelsius: bodyTemperatureCelsius == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyTemperatureCelsius),
      skinTemperatureCelsius: skinTemperatureCelsius == null && nullToAbsent
          ? const Value.absent()
          : Value(skinTemperatureCelsius),
      sleepDurationHours: sleepDurationHours == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepDurationHours),
      deepSleepHours: deepSleepHours == null && nullToAbsent
          ? const Value.absent()
          : Value(deepSleepHours),
      remSleepHours: remSleepHours == null && nullToAbsent
          ? const Value.absent()
          : Value(remSleepHours),
      lightSleepHours: lightSleepHours == null && nullToAbsent
          ? const Value.absent()
          : Value(lightSleepHours),
      sleepScore: sleepScore == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepScore),
      stepsCount: stepsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(stepsCount),
      activeCaloriesKcal: activeCaloriesKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(activeCaloriesKcal),
      totalCaloriesKcal: totalCaloriesKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(totalCaloriesKcal),
      distanceKm: distanceKm == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceKm),
      respiratoryRateBpm: respiratoryRateBpm == null && nullToAbsent
          ? const Value.absent()
          : Value(respiratoryRateBpm),
      spo2Percentage: spo2Percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(spo2Percentage),
      source: Value(source),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      synced: Value(synced),
      createdAt: Value(createdAt),
    );
  }

  factory Vital.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vital(
      vitalId: serializer.fromJson<int>(json['vitalId']),
      userId: serializer.fromJson<int>(json['userId']),
      recordedAt: serializer.fromJson<String>(json['recordedAt']),
      date: serializer.fromJson<String>(json['date']),
      heartRateBpm: serializer.fromJson<int?>(json['heartRateBpm']),
      hrvMs: serializer.fromJson<double?>(json['hrvMs']),
      restingHeartRateBpm:
          serializer.fromJson<int?>(json['restingHeartRateBpm']),
      bodyTemperatureCelsius:
          serializer.fromJson<double?>(json['bodyTemperatureCelsius']),
      skinTemperatureCelsius:
          serializer.fromJson<double?>(json['skinTemperatureCelsius']),
      sleepDurationHours:
          serializer.fromJson<double?>(json['sleepDurationHours']),
      deepSleepHours: serializer.fromJson<double?>(json['deepSleepHours']),
      remSleepHours: serializer.fromJson<double?>(json['remSleepHours']),
      lightSleepHours: serializer.fromJson<double?>(json['lightSleepHours']),
      sleepScore: serializer.fromJson<int?>(json['sleepScore']),
      stepsCount: serializer.fromJson<int?>(json['stepsCount']),
      activeCaloriesKcal:
          serializer.fromJson<double?>(json['activeCaloriesKcal']),
      totalCaloriesKcal:
          serializer.fromJson<double?>(json['totalCaloriesKcal']),
      distanceKm: serializer.fromJson<double?>(json['distanceKm']),
      respiratoryRateBpm: serializer.fromJson<int?>(json['respiratoryRateBpm']),
      spo2Percentage: serializer.fromJson<double?>(json['spo2Percentage']),
      source: serializer.fromJson<String>(json['source']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      synced: serializer.fromJson<int>(json['synced']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vitalId': serializer.toJson<int>(vitalId),
      'userId': serializer.toJson<int>(userId),
      'recordedAt': serializer.toJson<String>(recordedAt),
      'date': serializer.toJson<String>(date),
      'heartRateBpm': serializer.toJson<int?>(heartRateBpm),
      'hrvMs': serializer.toJson<double?>(hrvMs),
      'restingHeartRateBpm': serializer.toJson<int?>(restingHeartRateBpm),
      'bodyTemperatureCelsius':
          serializer.toJson<double?>(bodyTemperatureCelsius),
      'skinTemperatureCelsius':
          serializer.toJson<double?>(skinTemperatureCelsius),
      'sleepDurationHours': serializer.toJson<double?>(sleepDurationHours),
      'deepSleepHours': serializer.toJson<double?>(deepSleepHours),
      'remSleepHours': serializer.toJson<double?>(remSleepHours),
      'lightSleepHours': serializer.toJson<double?>(lightSleepHours),
      'sleepScore': serializer.toJson<int?>(sleepScore),
      'stepsCount': serializer.toJson<int?>(stepsCount),
      'activeCaloriesKcal': serializer.toJson<double?>(activeCaloriesKcal),
      'totalCaloriesKcal': serializer.toJson<double?>(totalCaloriesKcal),
      'distanceKm': serializer.toJson<double?>(distanceKm),
      'respiratoryRateBpm': serializer.toJson<int?>(respiratoryRateBpm),
      'spo2Percentage': serializer.toJson<double?>(spo2Percentage),
      'source': serializer.toJson<String>(source),
      'deviceId': serializer.toJson<String?>(deviceId),
      'synced': serializer.toJson<int>(synced),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Vital copyWith(
          {int? vitalId,
          int? userId,
          String? recordedAt,
          String? date,
          Value<int?> heartRateBpm = const Value.absent(),
          Value<double?> hrvMs = const Value.absent(),
          Value<int?> restingHeartRateBpm = const Value.absent(),
          Value<double?> bodyTemperatureCelsius = const Value.absent(),
          Value<double?> skinTemperatureCelsius = const Value.absent(),
          Value<double?> sleepDurationHours = const Value.absent(),
          Value<double?> deepSleepHours = const Value.absent(),
          Value<double?> remSleepHours = const Value.absent(),
          Value<double?> lightSleepHours = const Value.absent(),
          Value<int?> sleepScore = const Value.absent(),
          Value<int?> stepsCount = const Value.absent(),
          Value<double?> activeCaloriesKcal = const Value.absent(),
          Value<double?> totalCaloriesKcal = const Value.absent(),
          Value<double?> distanceKm = const Value.absent(),
          Value<int?> respiratoryRateBpm = const Value.absent(),
          Value<double?> spo2Percentage = const Value.absent(),
          String? source,
          Value<String?> deviceId = const Value.absent(),
          int? synced,
          String? createdAt}) =>
      Vital(
        vitalId: vitalId ?? this.vitalId,
        userId: userId ?? this.userId,
        recordedAt: recordedAt ?? this.recordedAt,
        date: date ?? this.date,
        heartRateBpm:
            heartRateBpm.present ? heartRateBpm.value : this.heartRateBpm,
        hrvMs: hrvMs.present ? hrvMs.value : this.hrvMs,
        restingHeartRateBpm: restingHeartRateBpm.present
            ? restingHeartRateBpm.value
            : this.restingHeartRateBpm,
        bodyTemperatureCelsius: bodyTemperatureCelsius.present
            ? bodyTemperatureCelsius.value
            : this.bodyTemperatureCelsius,
        skinTemperatureCelsius: skinTemperatureCelsius.present
            ? skinTemperatureCelsius.value
            : this.skinTemperatureCelsius,
        sleepDurationHours: sleepDurationHours.present
            ? sleepDurationHours.value
            : this.sleepDurationHours,
        deepSleepHours:
            deepSleepHours.present ? deepSleepHours.value : this.deepSleepHours,
        remSleepHours:
            remSleepHours.present ? remSleepHours.value : this.remSleepHours,
        lightSleepHours: lightSleepHours.present
            ? lightSleepHours.value
            : this.lightSleepHours,
        sleepScore: sleepScore.present ? sleepScore.value : this.sleepScore,
        stepsCount: stepsCount.present ? stepsCount.value : this.stepsCount,
        activeCaloriesKcal: activeCaloriesKcal.present
            ? activeCaloriesKcal.value
            : this.activeCaloriesKcal,
        totalCaloriesKcal: totalCaloriesKcal.present
            ? totalCaloriesKcal.value
            : this.totalCaloriesKcal,
        distanceKm: distanceKm.present ? distanceKm.value : this.distanceKm,
        respiratoryRateBpm: respiratoryRateBpm.present
            ? respiratoryRateBpm.value
            : this.respiratoryRateBpm,
        spo2Percentage:
            spo2Percentage.present ? spo2Percentage.value : this.spo2Percentage,
        source: source ?? this.source,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        synced: synced ?? this.synced,
        createdAt: createdAt ?? this.createdAt,
      );
  Vital copyWithCompanion(VitalsCompanion data) {
    return Vital(
      vitalId: data.vitalId.present ? data.vitalId.value : this.vitalId,
      userId: data.userId.present ? data.userId.value : this.userId,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      date: data.date.present ? data.date.value : this.date,
      heartRateBpm: data.heartRateBpm.present
          ? data.heartRateBpm.value
          : this.heartRateBpm,
      hrvMs: data.hrvMs.present ? data.hrvMs.value : this.hrvMs,
      restingHeartRateBpm: data.restingHeartRateBpm.present
          ? data.restingHeartRateBpm.value
          : this.restingHeartRateBpm,
      bodyTemperatureCelsius: data.bodyTemperatureCelsius.present
          ? data.bodyTemperatureCelsius.value
          : this.bodyTemperatureCelsius,
      skinTemperatureCelsius: data.skinTemperatureCelsius.present
          ? data.skinTemperatureCelsius.value
          : this.skinTemperatureCelsius,
      sleepDurationHours: data.sleepDurationHours.present
          ? data.sleepDurationHours.value
          : this.sleepDurationHours,
      deepSleepHours: data.deepSleepHours.present
          ? data.deepSleepHours.value
          : this.deepSleepHours,
      remSleepHours: data.remSleepHours.present
          ? data.remSleepHours.value
          : this.remSleepHours,
      lightSleepHours: data.lightSleepHours.present
          ? data.lightSleepHours.value
          : this.lightSleepHours,
      sleepScore:
          data.sleepScore.present ? data.sleepScore.value : this.sleepScore,
      stepsCount:
          data.stepsCount.present ? data.stepsCount.value : this.stepsCount,
      activeCaloriesKcal: data.activeCaloriesKcal.present
          ? data.activeCaloriesKcal.value
          : this.activeCaloriesKcal,
      totalCaloriesKcal: data.totalCaloriesKcal.present
          ? data.totalCaloriesKcal.value
          : this.totalCaloriesKcal,
      distanceKm:
          data.distanceKm.present ? data.distanceKm.value : this.distanceKm,
      respiratoryRateBpm: data.respiratoryRateBpm.present
          ? data.respiratoryRateBpm.value
          : this.respiratoryRateBpm,
      spo2Percentage: data.spo2Percentage.present
          ? data.spo2Percentage.value
          : this.spo2Percentage,
      source: data.source.present ? data.source.value : this.source,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vital(')
          ..write('vitalId: $vitalId, ')
          ..write('userId: $userId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('date: $date, ')
          ..write('heartRateBpm: $heartRateBpm, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('restingHeartRateBpm: $restingHeartRateBpm, ')
          ..write('bodyTemperatureCelsius: $bodyTemperatureCelsius, ')
          ..write('skinTemperatureCelsius: $skinTemperatureCelsius, ')
          ..write('sleepDurationHours: $sleepDurationHours, ')
          ..write('deepSleepHours: $deepSleepHours, ')
          ..write('remSleepHours: $remSleepHours, ')
          ..write('lightSleepHours: $lightSleepHours, ')
          ..write('sleepScore: $sleepScore, ')
          ..write('stepsCount: $stepsCount, ')
          ..write('activeCaloriesKcal: $activeCaloriesKcal, ')
          ..write('totalCaloriesKcal: $totalCaloriesKcal, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('respiratoryRateBpm: $respiratoryRateBpm, ')
          ..write('spo2Percentage: $spo2Percentage, ')
          ..write('source: $source, ')
          ..write('deviceId: $deviceId, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        vitalId,
        userId,
        recordedAt,
        date,
        heartRateBpm,
        hrvMs,
        restingHeartRateBpm,
        bodyTemperatureCelsius,
        skinTemperatureCelsius,
        sleepDurationHours,
        deepSleepHours,
        remSleepHours,
        lightSleepHours,
        sleepScore,
        stepsCount,
        activeCaloriesKcal,
        totalCaloriesKcal,
        distanceKm,
        respiratoryRateBpm,
        spo2Percentage,
        source,
        deviceId,
        synced,
        createdAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vital &&
          other.vitalId == this.vitalId &&
          other.userId == this.userId &&
          other.recordedAt == this.recordedAt &&
          other.date == this.date &&
          other.heartRateBpm == this.heartRateBpm &&
          other.hrvMs == this.hrvMs &&
          other.restingHeartRateBpm == this.restingHeartRateBpm &&
          other.bodyTemperatureCelsius == this.bodyTemperatureCelsius &&
          other.skinTemperatureCelsius == this.skinTemperatureCelsius &&
          other.sleepDurationHours == this.sleepDurationHours &&
          other.deepSleepHours == this.deepSleepHours &&
          other.remSleepHours == this.remSleepHours &&
          other.lightSleepHours == this.lightSleepHours &&
          other.sleepScore == this.sleepScore &&
          other.stepsCount == this.stepsCount &&
          other.activeCaloriesKcal == this.activeCaloriesKcal &&
          other.totalCaloriesKcal == this.totalCaloriesKcal &&
          other.distanceKm == this.distanceKm &&
          other.respiratoryRateBpm == this.respiratoryRateBpm &&
          other.spo2Percentage == this.spo2Percentage &&
          other.source == this.source &&
          other.deviceId == this.deviceId &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt);
}

class VitalsCompanion extends UpdateCompanion<Vital> {
  final Value<int> vitalId;
  final Value<int> userId;
  final Value<String> recordedAt;
  final Value<String> date;
  final Value<int?> heartRateBpm;
  final Value<double?> hrvMs;
  final Value<int?> restingHeartRateBpm;
  final Value<double?> bodyTemperatureCelsius;
  final Value<double?> skinTemperatureCelsius;
  final Value<double?> sleepDurationHours;
  final Value<double?> deepSleepHours;
  final Value<double?> remSleepHours;
  final Value<double?> lightSleepHours;
  final Value<int?> sleepScore;
  final Value<int?> stepsCount;
  final Value<double?> activeCaloriesKcal;
  final Value<double?> totalCaloriesKcal;
  final Value<double?> distanceKm;
  final Value<int?> respiratoryRateBpm;
  final Value<double?> spo2Percentage;
  final Value<String> source;
  final Value<String?> deviceId;
  final Value<int> synced;
  final Value<String> createdAt;
  const VitalsCompanion({
    this.vitalId = const Value.absent(),
    this.userId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.date = const Value.absent(),
    this.heartRateBpm = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.restingHeartRateBpm = const Value.absent(),
    this.bodyTemperatureCelsius = const Value.absent(),
    this.skinTemperatureCelsius = const Value.absent(),
    this.sleepDurationHours = const Value.absent(),
    this.deepSleepHours = const Value.absent(),
    this.remSleepHours = const Value.absent(),
    this.lightSleepHours = const Value.absent(),
    this.sleepScore = const Value.absent(),
    this.stepsCount = const Value.absent(),
    this.activeCaloriesKcal = const Value.absent(),
    this.totalCaloriesKcal = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.respiratoryRateBpm = const Value.absent(),
    this.spo2Percentage = const Value.absent(),
    this.source = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VitalsCompanion.insert({
    this.vitalId = const Value.absent(),
    required int userId,
    required String recordedAt,
    required String date,
    this.heartRateBpm = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.restingHeartRateBpm = const Value.absent(),
    this.bodyTemperatureCelsius = const Value.absent(),
    this.skinTemperatureCelsius = const Value.absent(),
    this.sleepDurationHours = const Value.absent(),
    this.deepSleepHours = const Value.absent(),
    this.remSleepHours = const Value.absent(),
    this.lightSleepHours = const Value.absent(),
    this.sleepScore = const Value.absent(),
    this.stepsCount = const Value.absent(),
    this.activeCaloriesKcal = const Value.absent(),
    this.totalCaloriesKcal = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.respiratoryRateBpm = const Value.absent(),
    this.spo2Percentage = const Value.absent(),
    this.source = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        recordedAt = Value(recordedAt),
        date = Value(date);
  static Insertable<Vital> custom({
    Expression<int>? vitalId,
    Expression<int>? userId,
    Expression<String>? recordedAt,
    Expression<String>? date,
    Expression<int>? heartRateBpm,
    Expression<double>? hrvMs,
    Expression<int>? restingHeartRateBpm,
    Expression<double>? bodyTemperatureCelsius,
    Expression<double>? skinTemperatureCelsius,
    Expression<double>? sleepDurationHours,
    Expression<double>? deepSleepHours,
    Expression<double>? remSleepHours,
    Expression<double>? lightSleepHours,
    Expression<int>? sleepScore,
    Expression<int>? stepsCount,
    Expression<double>? activeCaloriesKcal,
    Expression<double>? totalCaloriesKcal,
    Expression<double>? distanceKm,
    Expression<int>? respiratoryRateBpm,
    Expression<double>? spo2Percentage,
    Expression<String>? source,
    Expression<String>? deviceId,
    Expression<int>? synced,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (vitalId != null) 'vital_id': vitalId,
      if (userId != null) 'user_id': userId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (date != null) 'date': date,
      if (heartRateBpm != null) 'heart_rate_bpm': heartRateBpm,
      if (hrvMs != null) 'hrv_ms': hrvMs,
      if (restingHeartRateBpm != null)
        'resting_heart_rate_bpm': restingHeartRateBpm,
      if (bodyTemperatureCelsius != null)
        'body_temperature_celsius': bodyTemperatureCelsius,
      if (skinTemperatureCelsius != null)
        'skin_temperature_celsius': skinTemperatureCelsius,
      if (sleepDurationHours != null)
        'sleep_duration_hours': sleepDurationHours,
      if (deepSleepHours != null) 'deep_sleep_hours': deepSleepHours,
      if (remSleepHours != null) 'rem_sleep_hours': remSleepHours,
      if (lightSleepHours != null) 'light_sleep_hours': lightSleepHours,
      if (sleepScore != null) 'sleep_score': sleepScore,
      if (stepsCount != null) 'steps_count': stepsCount,
      if (activeCaloriesKcal != null)
        'active_calories_kcal': activeCaloriesKcal,
      if (totalCaloriesKcal != null) 'total_calories_kcal': totalCaloriesKcal,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (respiratoryRateBpm != null)
        'respiratory_rate_bpm': respiratoryRateBpm,
      if (spo2Percentage != null) 'spo2_percentage': spo2Percentage,
      if (source != null) 'source': source,
      if (deviceId != null) 'device_id': deviceId,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VitalsCompanion copyWith(
      {Value<int>? vitalId,
      Value<int>? userId,
      Value<String>? recordedAt,
      Value<String>? date,
      Value<int?>? heartRateBpm,
      Value<double?>? hrvMs,
      Value<int?>? restingHeartRateBpm,
      Value<double?>? bodyTemperatureCelsius,
      Value<double?>? skinTemperatureCelsius,
      Value<double?>? sleepDurationHours,
      Value<double?>? deepSleepHours,
      Value<double?>? remSleepHours,
      Value<double?>? lightSleepHours,
      Value<int?>? sleepScore,
      Value<int?>? stepsCount,
      Value<double?>? activeCaloriesKcal,
      Value<double?>? totalCaloriesKcal,
      Value<double?>? distanceKm,
      Value<int?>? respiratoryRateBpm,
      Value<double?>? spo2Percentage,
      Value<String>? source,
      Value<String?>? deviceId,
      Value<int>? synced,
      Value<String>? createdAt}) {
    return VitalsCompanion(
      vitalId: vitalId ?? this.vitalId,
      userId: userId ?? this.userId,
      recordedAt: recordedAt ?? this.recordedAt,
      date: date ?? this.date,
      heartRateBpm: heartRateBpm ?? this.heartRateBpm,
      hrvMs: hrvMs ?? this.hrvMs,
      restingHeartRateBpm: restingHeartRateBpm ?? this.restingHeartRateBpm,
      bodyTemperatureCelsius:
          bodyTemperatureCelsius ?? this.bodyTemperatureCelsius,
      skinTemperatureCelsius:
          skinTemperatureCelsius ?? this.skinTemperatureCelsius,
      sleepDurationHours: sleepDurationHours ?? this.sleepDurationHours,
      deepSleepHours: deepSleepHours ?? this.deepSleepHours,
      remSleepHours: remSleepHours ?? this.remSleepHours,
      lightSleepHours: lightSleepHours ?? this.lightSleepHours,
      sleepScore: sleepScore ?? this.sleepScore,
      stepsCount: stepsCount ?? this.stepsCount,
      activeCaloriesKcal: activeCaloriesKcal ?? this.activeCaloriesKcal,
      totalCaloriesKcal: totalCaloriesKcal ?? this.totalCaloriesKcal,
      distanceKm: distanceKm ?? this.distanceKm,
      respiratoryRateBpm: respiratoryRateBpm ?? this.respiratoryRateBpm,
      spo2Percentage: spo2Percentage ?? this.spo2Percentage,
      source: source ?? this.source,
      deviceId: deviceId ?? this.deviceId,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vitalId.present) {
      map['vital_id'] = Variable<int>(vitalId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<String>(recordedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (heartRateBpm.present) {
      map['heart_rate_bpm'] = Variable<int>(heartRateBpm.value);
    }
    if (hrvMs.present) {
      map['hrv_ms'] = Variable<double>(hrvMs.value);
    }
    if (restingHeartRateBpm.present) {
      map['resting_heart_rate_bpm'] = Variable<int>(restingHeartRateBpm.value);
    }
    if (bodyTemperatureCelsius.present) {
      map['body_temperature_celsius'] =
          Variable<double>(bodyTemperatureCelsius.value);
    }
    if (skinTemperatureCelsius.present) {
      map['skin_temperature_celsius'] =
          Variable<double>(skinTemperatureCelsius.value);
    }
    if (sleepDurationHours.present) {
      map['sleep_duration_hours'] = Variable<double>(sleepDurationHours.value);
    }
    if (deepSleepHours.present) {
      map['deep_sleep_hours'] = Variable<double>(deepSleepHours.value);
    }
    if (remSleepHours.present) {
      map['rem_sleep_hours'] = Variable<double>(remSleepHours.value);
    }
    if (lightSleepHours.present) {
      map['light_sleep_hours'] = Variable<double>(lightSleepHours.value);
    }
    if (sleepScore.present) {
      map['sleep_score'] = Variable<int>(sleepScore.value);
    }
    if (stepsCount.present) {
      map['steps_count'] = Variable<int>(stepsCount.value);
    }
    if (activeCaloriesKcal.present) {
      map['active_calories_kcal'] = Variable<double>(activeCaloriesKcal.value);
    }
    if (totalCaloriesKcal.present) {
      map['total_calories_kcal'] = Variable<double>(totalCaloriesKcal.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (respiratoryRateBpm.present) {
      map['respiratory_rate_bpm'] = Variable<int>(respiratoryRateBpm.value);
    }
    if (spo2Percentage.present) {
      map['spo2_percentage'] = Variable<double>(spo2Percentage.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (synced.present) {
      map['synced'] = Variable<int>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VitalsCompanion(')
          ..write('vitalId: $vitalId, ')
          ..write('userId: $userId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('date: $date, ')
          ..write('heartRateBpm: $heartRateBpm, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('restingHeartRateBpm: $restingHeartRateBpm, ')
          ..write('bodyTemperatureCelsius: $bodyTemperatureCelsius, ')
          ..write('skinTemperatureCelsius: $skinTemperatureCelsius, ')
          ..write('sleepDurationHours: $sleepDurationHours, ')
          ..write('deepSleepHours: $deepSleepHours, ')
          ..write('remSleepHours: $remSleepHours, ')
          ..write('lightSleepHours: $lightSleepHours, ')
          ..write('sleepScore: $sleepScore, ')
          ..write('stepsCount: $stepsCount, ')
          ..write('activeCaloriesKcal: $activeCaloriesKcal, ')
          ..write('totalCaloriesKcal: $totalCaloriesKcal, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('respiratoryRateBpm: $respiratoryRateBpm, ')
          ..write('spo2Percentage: $spo2Percentage, ')
          ..write('source: $source, ')
          ..write('deviceId: $deviceId, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SymptomsTable extends Symptoms with TableInfo<$SymptomsTable, Symptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _symptomIdMeta =
      const VerificationMeta('symptomId');
  @override
  late final GeneratedColumn<int> symptomId = GeneratedColumn<int>(
      'symptom_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<String> recordedAt = GeneratedColumn<String>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _headacheSeverityMeta =
      const VerificationMeta('headacheSeverity');
  @override
  late final GeneratedColumn<int> headacheSeverity = GeneratedColumn<int>(
      'headache_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fatigueSeverityMeta =
      const VerificationMeta('fatigueSeverity');
  @override
  late final GeneratedColumn<int> fatigueSeverity = GeneratedColumn<int>(
      'fatigue_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nauseaSeverityMeta =
      const VerificationMeta('nauseaSeverity');
  @override
  late final GeneratedColumn<int> nauseaSeverity = GeneratedColumn<int>(
      'nausea_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dizzinessSeverityMeta =
      const VerificationMeta('dizzinessSeverity');
  @override
  late final GeneratedColumn<int> dizzinessSeverity = GeneratedColumn<int>(
      'dizziness_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _brainFogSeverityMeta =
      const VerificationMeta('brainFogSeverity');
  @override
  late final GeneratedColumn<int> brainFogSeverity = GeneratedColumn<int>(
      'brain_fog_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _irritabilitySeverityMeta =
      const VerificationMeta('irritabilitySeverity');
  @override
  late final GeneratedColumn<int> irritabilitySeverity = GeneratedColumn<int>(
      'irritability_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _muscleCrampsSeverityMeta =
      const VerificationMeta('muscleCrampsSeverity');
  @override
  late final GeneratedColumn<int> muscleCrampsSeverity = GeneratedColumn<int>(
      'muscle_cramps_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _energyLevelMeta =
      const VerificationMeta('energyLevel');
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
      'energy_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _mentalClarityMeta =
      const VerificationMeta('mentalClarity');
  @override
  late final GeneratedColumn<int> mentalClarity = GeneratedColumn<int>(
      'mental_clarity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _moodRatingMeta =
      const VerificationMeta('moodRating');
  @override
  late final GeneratedColumn<int> moodRating = GeneratedColumn<int>(
      'mood_rating', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _hungerLevelMeta =
      const VerificationMeta('hungerLevel');
  @override
  late final GeneratedColumn<int> hungerLevel = GeneratedColumn<int>(
      'hunger_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _satietyLevelMeta =
      const VerificationMeta('satietyLevel');
  @override
  late final GeneratedColumn<int> satietyLevel = GeneratedColumn<int>(
      'satiety_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bloatingSeverityMeta =
      const VerificationMeta('bloatingSeverity');
  @override
  late final GeneratedColumn<int> bloatingSeverity = GeneratedColumn<int>(
      'bloating_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _digestionQualityMeta =
      const VerificationMeta('digestionQuality');
  @override
  late final GeneratedColumn<int> digestionQuality = GeneratedColumn<int>(
      'digestion_quality', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _customSymptomsMeta =
      const VerificationMeta('customSymptoms');
  @override
  late final GeneratedColumn<String> customSymptoms = GeneratedColumn<String>(
      'custom_symptoms', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _additionalNotesMeta =
      const VerificationMeta('additionalNotes');
  @override
  late final GeneratedColumn<String> additionalNotes = GeneratedColumn<String>(
      'additional_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<int> synced = GeneratedColumn<int>(
      'synced', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().toIso8601String()));
  @override
  List<GeneratedColumn> get $columns => [
        symptomId,
        userId,
        recordedAt,
        date,
        headacheSeverity,
        fatigueSeverity,
        nauseaSeverity,
        dizzinessSeverity,
        brainFogSeverity,
        irritabilitySeverity,
        muscleCrampsSeverity,
        energyLevel,
        mentalClarity,
        moodRating,
        hungerLevel,
        satietyLevel,
        bloatingSeverity,
        digestionQuality,
        customSymptoms,
        additionalNotes,
        synced,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<Symptom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('symptom_id')) {
      context.handle(_symptomIdMeta,
          symptomId.isAcceptableOrUnknown(data['symptom_id']!, _symptomIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('headache_severity')) {
      context.handle(
          _headacheSeverityMeta,
          headacheSeverity.isAcceptableOrUnknown(
              data['headache_severity']!, _headacheSeverityMeta));
    }
    if (data.containsKey('fatigue_severity')) {
      context.handle(
          _fatigueSeverityMeta,
          fatigueSeverity.isAcceptableOrUnknown(
              data['fatigue_severity']!, _fatigueSeverityMeta));
    }
    if (data.containsKey('nausea_severity')) {
      context.handle(
          _nauseaSeverityMeta,
          nauseaSeverity.isAcceptableOrUnknown(
              data['nausea_severity']!, _nauseaSeverityMeta));
    }
    if (data.containsKey('dizziness_severity')) {
      context.handle(
          _dizzinessSeverityMeta,
          dizzinessSeverity.isAcceptableOrUnknown(
              data['dizziness_severity']!, _dizzinessSeverityMeta));
    }
    if (data.containsKey('brain_fog_severity')) {
      context.handle(
          _brainFogSeverityMeta,
          brainFogSeverity.isAcceptableOrUnknown(
              data['brain_fog_severity']!, _brainFogSeverityMeta));
    }
    if (data.containsKey('irritability_severity')) {
      context.handle(
          _irritabilitySeverityMeta,
          irritabilitySeverity.isAcceptableOrUnknown(
              data['irritability_severity']!, _irritabilitySeverityMeta));
    }
    if (data.containsKey('muscle_cramps_severity')) {
      context.handle(
          _muscleCrampsSeverityMeta,
          muscleCrampsSeverity.isAcceptableOrUnknown(
              data['muscle_cramps_severity']!, _muscleCrampsSeverityMeta));
    }
    if (data.containsKey('energy_level')) {
      context.handle(
          _energyLevelMeta,
          energyLevel.isAcceptableOrUnknown(
              data['energy_level']!, _energyLevelMeta));
    }
    if (data.containsKey('mental_clarity')) {
      context.handle(
          _mentalClarityMeta,
          mentalClarity.isAcceptableOrUnknown(
              data['mental_clarity']!, _mentalClarityMeta));
    }
    if (data.containsKey('mood_rating')) {
      context.handle(
          _moodRatingMeta,
          moodRating.isAcceptableOrUnknown(
              data['mood_rating']!, _moodRatingMeta));
    }
    if (data.containsKey('hunger_level')) {
      context.handle(
          _hungerLevelMeta,
          hungerLevel.isAcceptableOrUnknown(
              data['hunger_level']!, _hungerLevelMeta));
    }
    if (data.containsKey('satiety_level')) {
      context.handle(
          _satietyLevelMeta,
          satietyLevel.isAcceptableOrUnknown(
              data['satiety_level']!, _satietyLevelMeta));
    }
    if (data.containsKey('bloating_severity')) {
      context.handle(
          _bloatingSeverityMeta,
          bloatingSeverity.isAcceptableOrUnknown(
              data['bloating_severity']!, _bloatingSeverityMeta));
    }
    if (data.containsKey('digestion_quality')) {
      context.handle(
          _digestionQualityMeta,
          digestionQuality.isAcceptableOrUnknown(
              data['digestion_quality']!, _digestionQualityMeta));
    }
    if (data.containsKey('custom_symptoms')) {
      context.handle(
          _customSymptomsMeta,
          customSymptoms.isAcceptableOrUnknown(
              data['custom_symptoms']!, _customSymptomsMeta));
    }
    if (data.containsKey('additional_notes')) {
      context.handle(
          _additionalNotesMeta,
          additionalNotes.isAcceptableOrUnknown(
              data['additional_notes']!, _additionalNotesMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {symptomId};
  @override
  Symptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Symptom(
      symptomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}symptom_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recorded_at'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      headacheSeverity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}headache_severity']),
      fatigueSeverity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fatigue_severity']),
      nauseaSeverity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nausea_severity']),
      dizzinessSeverity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dizziness_severity']),
      brainFogSeverity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}brain_fog_severity']),
      irritabilitySeverity: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}irritability_severity']),
      muscleCrampsSeverity: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}muscle_cramps_severity']),
      energyLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}energy_level']),
      mentalClarity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mental_clarity']),
      moodRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mood_rating']),
      hungerLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hunger_level']),
      satietyLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}satiety_level']),
      bloatingSeverity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bloating_severity']),
      digestionQuality: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}digestion_quality']),
      customSymptoms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}custom_symptoms']),
      additionalNotes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}additional_notes']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SymptomsTable createAlias(String alias) {
    return $SymptomsTable(attachedDatabase, alias);
  }
}

class Symptom extends DataClass implements Insertable<Symptom> {
  final int symptomId;
  final int userId;
  final String recordedAt;
  final String date;
  final int? headacheSeverity;
  final int? fatigueSeverity;
  final int? nauseaSeverity;
  final int? dizzinessSeverity;
  final int? brainFogSeverity;
  final int? irritabilitySeverity;
  final int? muscleCrampsSeverity;
  final int? energyLevel;
  final int? mentalClarity;
  final int? moodRating;
  final int? hungerLevel;
  final int? satietyLevel;
  final int? bloatingSeverity;
  final int? digestionQuality;
  final String? customSymptoms;
  final String? additionalNotes;
  final int synced;
  final String createdAt;
  const Symptom(
      {required this.symptomId,
      required this.userId,
      required this.recordedAt,
      required this.date,
      this.headacheSeverity,
      this.fatigueSeverity,
      this.nauseaSeverity,
      this.dizzinessSeverity,
      this.brainFogSeverity,
      this.irritabilitySeverity,
      this.muscleCrampsSeverity,
      this.energyLevel,
      this.mentalClarity,
      this.moodRating,
      this.hungerLevel,
      this.satietyLevel,
      this.bloatingSeverity,
      this.digestionQuality,
      this.customSymptoms,
      this.additionalNotes,
      required this.synced,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['symptom_id'] = Variable<int>(symptomId);
    map['user_id'] = Variable<int>(userId);
    map['recorded_at'] = Variable<String>(recordedAt);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || headacheSeverity != null) {
      map['headache_severity'] = Variable<int>(headacheSeverity);
    }
    if (!nullToAbsent || fatigueSeverity != null) {
      map['fatigue_severity'] = Variable<int>(fatigueSeverity);
    }
    if (!nullToAbsent || nauseaSeverity != null) {
      map['nausea_severity'] = Variable<int>(nauseaSeverity);
    }
    if (!nullToAbsent || dizzinessSeverity != null) {
      map['dizziness_severity'] = Variable<int>(dizzinessSeverity);
    }
    if (!nullToAbsent || brainFogSeverity != null) {
      map['brain_fog_severity'] = Variable<int>(brainFogSeverity);
    }
    if (!nullToAbsent || irritabilitySeverity != null) {
      map['irritability_severity'] = Variable<int>(irritabilitySeverity);
    }
    if (!nullToAbsent || muscleCrampsSeverity != null) {
      map['muscle_cramps_severity'] = Variable<int>(muscleCrampsSeverity);
    }
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<int>(energyLevel);
    }
    if (!nullToAbsent || mentalClarity != null) {
      map['mental_clarity'] = Variable<int>(mentalClarity);
    }
    if (!nullToAbsent || moodRating != null) {
      map['mood_rating'] = Variable<int>(moodRating);
    }
    if (!nullToAbsent || hungerLevel != null) {
      map['hunger_level'] = Variable<int>(hungerLevel);
    }
    if (!nullToAbsent || satietyLevel != null) {
      map['satiety_level'] = Variable<int>(satietyLevel);
    }
    if (!nullToAbsent || bloatingSeverity != null) {
      map['bloating_severity'] = Variable<int>(bloatingSeverity);
    }
    if (!nullToAbsent || digestionQuality != null) {
      map['digestion_quality'] = Variable<int>(digestionQuality);
    }
    if (!nullToAbsent || customSymptoms != null) {
      map['custom_symptoms'] = Variable<String>(customSymptoms);
    }
    if (!nullToAbsent || additionalNotes != null) {
      map['additional_notes'] = Variable<String>(additionalNotes);
    }
    map['synced'] = Variable<int>(synced);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  SymptomsCompanion toCompanion(bool nullToAbsent) {
    return SymptomsCompanion(
      symptomId: Value(symptomId),
      userId: Value(userId),
      recordedAt: Value(recordedAt),
      date: Value(date),
      headacheSeverity: headacheSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(headacheSeverity),
      fatigueSeverity: fatigueSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(fatigueSeverity),
      nauseaSeverity: nauseaSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(nauseaSeverity),
      dizzinessSeverity: dizzinessSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(dizzinessSeverity),
      brainFogSeverity: brainFogSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(brainFogSeverity),
      irritabilitySeverity: irritabilitySeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(irritabilitySeverity),
      muscleCrampsSeverity: muscleCrampsSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleCrampsSeverity),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      mentalClarity: mentalClarity == null && nullToAbsent
          ? const Value.absent()
          : Value(mentalClarity),
      moodRating: moodRating == null && nullToAbsent
          ? const Value.absent()
          : Value(moodRating),
      hungerLevel: hungerLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(hungerLevel),
      satietyLevel: satietyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(satietyLevel),
      bloatingSeverity: bloatingSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(bloatingSeverity),
      digestionQuality: digestionQuality == null && nullToAbsent
          ? const Value.absent()
          : Value(digestionQuality),
      customSymptoms: customSymptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(customSymptoms),
      additionalNotes: additionalNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(additionalNotes),
      synced: Value(synced),
      createdAt: Value(createdAt),
    );
  }

  factory Symptom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Symptom(
      symptomId: serializer.fromJson<int>(json['symptomId']),
      userId: serializer.fromJson<int>(json['userId']),
      recordedAt: serializer.fromJson<String>(json['recordedAt']),
      date: serializer.fromJson<String>(json['date']),
      headacheSeverity: serializer.fromJson<int?>(json['headacheSeverity']),
      fatigueSeverity: serializer.fromJson<int?>(json['fatigueSeverity']),
      nauseaSeverity: serializer.fromJson<int?>(json['nauseaSeverity']),
      dizzinessSeverity: serializer.fromJson<int?>(json['dizzinessSeverity']),
      brainFogSeverity: serializer.fromJson<int?>(json['brainFogSeverity']),
      irritabilitySeverity:
          serializer.fromJson<int?>(json['irritabilitySeverity']),
      muscleCrampsSeverity:
          serializer.fromJson<int?>(json['muscleCrampsSeverity']),
      energyLevel: serializer.fromJson<int?>(json['energyLevel']),
      mentalClarity: serializer.fromJson<int?>(json['mentalClarity']),
      moodRating: serializer.fromJson<int?>(json['moodRating']),
      hungerLevel: serializer.fromJson<int?>(json['hungerLevel']),
      satietyLevel: serializer.fromJson<int?>(json['satietyLevel']),
      bloatingSeverity: serializer.fromJson<int?>(json['bloatingSeverity']),
      digestionQuality: serializer.fromJson<int?>(json['digestionQuality']),
      customSymptoms: serializer.fromJson<String?>(json['customSymptoms']),
      additionalNotes: serializer.fromJson<String?>(json['additionalNotes']),
      synced: serializer.fromJson<int>(json['synced']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'symptomId': serializer.toJson<int>(symptomId),
      'userId': serializer.toJson<int>(userId),
      'recordedAt': serializer.toJson<String>(recordedAt),
      'date': serializer.toJson<String>(date),
      'headacheSeverity': serializer.toJson<int?>(headacheSeverity),
      'fatigueSeverity': serializer.toJson<int?>(fatigueSeverity),
      'nauseaSeverity': serializer.toJson<int?>(nauseaSeverity),
      'dizzinessSeverity': serializer.toJson<int?>(dizzinessSeverity),
      'brainFogSeverity': serializer.toJson<int?>(brainFogSeverity),
      'irritabilitySeverity': serializer.toJson<int?>(irritabilitySeverity),
      'muscleCrampsSeverity': serializer.toJson<int?>(muscleCrampsSeverity),
      'energyLevel': serializer.toJson<int?>(energyLevel),
      'mentalClarity': serializer.toJson<int?>(mentalClarity),
      'moodRating': serializer.toJson<int?>(moodRating),
      'hungerLevel': serializer.toJson<int?>(hungerLevel),
      'satietyLevel': serializer.toJson<int?>(satietyLevel),
      'bloatingSeverity': serializer.toJson<int?>(bloatingSeverity),
      'digestionQuality': serializer.toJson<int?>(digestionQuality),
      'customSymptoms': serializer.toJson<String?>(customSymptoms),
      'additionalNotes': serializer.toJson<String?>(additionalNotes),
      'synced': serializer.toJson<int>(synced),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Symptom copyWith(
          {int? symptomId,
          int? userId,
          String? recordedAt,
          String? date,
          Value<int?> headacheSeverity = const Value.absent(),
          Value<int?> fatigueSeverity = const Value.absent(),
          Value<int?> nauseaSeverity = const Value.absent(),
          Value<int?> dizzinessSeverity = const Value.absent(),
          Value<int?> brainFogSeverity = const Value.absent(),
          Value<int?> irritabilitySeverity = const Value.absent(),
          Value<int?> muscleCrampsSeverity = const Value.absent(),
          Value<int?> energyLevel = const Value.absent(),
          Value<int?> mentalClarity = const Value.absent(),
          Value<int?> moodRating = const Value.absent(),
          Value<int?> hungerLevel = const Value.absent(),
          Value<int?> satietyLevel = const Value.absent(),
          Value<int?> bloatingSeverity = const Value.absent(),
          Value<int?> digestionQuality = const Value.absent(),
          Value<String?> customSymptoms = const Value.absent(),
          Value<String?> additionalNotes = const Value.absent(),
          int? synced,
          String? createdAt}) =>
      Symptom(
        symptomId: symptomId ?? this.symptomId,
        userId: userId ?? this.userId,
        recordedAt: recordedAt ?? this.recordedAt,
        date: date ?? this.date,
        headacheSeverity: headacheSeverity.present
            ? headacheSeverity.value
            : this.headacheSeverity,
        fatigueSeverity: fatigueSeverity.present
            ? fatigueSeverity.value
            : this.fatigueSeverity,
        nauseaSeverity:
            nauseaSeverity.present ? nauseaSeverity.value : this.nauseaSeverity,
        dizzinessSeverity: dizzinessSeverity.present
            ? dizzinessSeverity.value
            : this.dizzinessSeverity,
        brainFogSeverity: brainFogSeverity.present
            ? brainFogSeverity.value
            : this.brainFogSeverity,
        irritabilitySeverity: irritabilitySeverity.present
            ? irritabilitySeverity.value
            : this.irritabilitySeverity,
        muscleCrampsSeverity: muscleCrampsSeverity.present
            ? muscleCrampsSeverity.value
            : this.muscleCrampsSeverity,
        energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
        mentalClarity:
            mentalClarity.present ? mentalClarity.value : this.mentalClarity,
        moodRating: moodRating.present ? moodRating.value : this.moodRating,
        hungerLevel: hungerLevel.present ? hungerLevel.value : this.hungerLevel,
        satietyLevel:
            satietyLevel.present ? satietyLevel.value : this.satietyLevel,
        bloatingSeverity: bloatingSeverity.present
            ? bloatingSeverity.value
            : this.bloatingSeverity,
        digestionQuality: digestionQuality.present
            ? digestionQuality.value
            : this.digestionQuality,
        customSymptoms:
            customSymptoms.present ? customSymptoms.value : this.customSymptoms,
        additionalNotes: additionalNotes.present
            ? additionalNotes.value
            : this.additionalNotes,
        synced: synced ?? this.synced,
        createdAt: createdAt ?? this.createdAt,
      );
  Symptom copyWithCompanion(SymptomsCompanion data) {
    return Symptom(
      symptomId: data.symptomId.present ? data.symptomId.value : this.symptomId,
      userId: data.userId.present ? data.userId.value : this.userId,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      date: data.date.present ? data.date.value : this.date,
      headacheSeverity: data.headacheSeverity.present
          ? data.headacheSeverity.value
          : this.headacheSeverity,
      fatigueSeverity: data.fatigueSeverity.present
          ? data.fatigueSeverity.value
          : this.fatigueSeverity,
      nauseaSeverity: data.nauseaSeverity.present
          ? data.nauseaSeverity.value
          : this.nauseaSeverity,
      dizzinessSeverity: data.dizzinessSeverity.present
          ? data.dizzinessSeverity.value
          : this.dizzinessSeverity,
      brainFogSeverity: data.brainFogSeverity.present
          ? data.brainFogSeverity.value
          : this.brainFogSeverity,
      irritabilitySeverity: data.irritabilitySeverity.present
          ? data.irritabilitySeverity.value
          : this.irritabilitySeverity,
      muscleCrampsSeverity: data.muscleCrampsSeverity.present
          ? data.muscleCrampsSeverity.value
          : this.muscleCrampsSeverity,
      energyLevel:
          data.energyLevel.present ? data.energyLevel.value : this.energyLevel,
      mentalClarity: data.mentalClarity.present
          ? data.mentalClarity.value
          : this.mentalClarity,
      moodRating:
          data.moodRating.present ? data.moodRating.value : this.moodRating,
      hungerLevel:
          data.hungerLevel.present ? data.hungerLevel.value : this.hungerLevel,
      satietyLevel: data.satietyLevel.present
          ? data.satietyLevel.value
          : this.satietyLevel,
      bloatingSeverity: data.bloatingSeverity.present
          ? data.bloatingSeverity.value
          : this.bloatingSeverity,
      digestionQuality: data.digestionQuality.present
          ? data.digestionQuality.value
          : this.digestionQuality,
      customSymptoms: data.customSymptoms.present
          ? data.customSymptoms.value
          : this.customSymptoms,
      additionalNotes: data.additionalNotes.present
          ? data.additionalNotes.value
          : this.additionalNotes,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Symptom(')
          ..write('symptomId: $symptomId, ')
          ..write('userId: $userId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('date: $date, ')
          ..write('headacheSeverity: $headacheSeverity, ')
          ..write('fatigueSeverity: $fatigueSeverity, ')
          ..write('nauseaSeverity: $nauseaSeverity, ')
          ..write('dizzinessSeverity: $dizzinessSeverity, ')
          ..write('brainFogSeverity: $brainFogSeverity, ')
          ..write('irritabilitySeverity: $irritabilitySeverity, ')
          ..write('muscleCrampsSeverity: $muscleCrampsSeverity, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('mentalClarity: $mentalClarity, ')
          ..write('moodRating: $moodRating, ')
          ..write('hungerLevel: $hungerLevel, ')
          ..write('satietyLevel: $satietyLevel, ')
          ..write('bloatingSeverity: $bloatingSeverity, ')
          ..write('digestionQuality: $digestionQuality, ')
          ..write('customSymptoms: $customSymptoms, ')
          ..write('additionalNotes: $additionalNotes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        symptomId,
        userId,
        recordedAt,
        date,
        headacheSeverity,
        fatigueSeverity,
        nauseaSeverity,
        dizzinessSeverity,
        brainFogSeverity,
        irritabilitySeverity,
        muscleCrampsSeverity,
        energyLevel,
        mentalClarity,
        moodRating,
        hungerLevel,
        satietyLevel,
        bloatingSeverity,
        digestionQuality,
        customSymptoms,
        additionalNotes,
        synced,
        createdAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Symptom &&
          other.symptomId == this.symptomId &&
          other.userId == this.userId &&
          other.recordedAt == this.recordedAt &&
          other.date == this.date &&
          other.headacheSeverity == this.headacheSeverity &&
          other.fatigueSeverity == this.fatigueSeverity &&
          other.nauseaSeverity == this.nauseaSeverity &&
          other.dizzinessSeverity == this.dizzinessSeverity &&
          other.brainFogSeverity == this.brainFogSeverity &&
          other.irritabilitySeverity == this.irritabilitySeverity &&
          other.muscleCrampsSeverity == this.muscleCrampsSeverity &&
          other.energyLevel == this.energyLevel &&
          other.mentalClarity == this.mentalClarity &&
          other.moodRating == this.moodRating &&
          other.hungerLevel == this.hungerLevel &&
          other.satietyLevel == this.satietyLevel &&
          other.bloatingSeverity == this.bloatingSeverity &&
          other.digestionQuality == this.digestionQuality &&
          other.customSymptoms == this.customSymptoms &&
          other.additionalNotes == this.additionalNotes &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt);
}

class SymptomsCompanion extends UpdateCompanion<Symptom> {
  final Value<int> symptomId;
  final Value<int> userId;
  final Value<String> recordedAt;
  final Value<String> date;
  final Value<int?> headacheSeverity;
  final Value<int?> fatigueSeverity;
  final Value<int?> nauseaSeverity;
  final Value<int?> dizzinessSeverity;
  final Value<int?> brainFogSeverity;
  final Value<int?> irritabilitySeverity;
  final Value<int?> muscleCrampsSeverity;
  final Value<int?> energyLevel;
  final Value<int?> mentalClarity;
  final Value<int?> moodRating;
  final Value<int?> hungerLevel;
  final Value<int?> satietyLevel;
  final Value<int?> bloatingSeverity;
  final Value<int?> digestionQuality;
  final Value<String?> customSymptoms;
  final Value<String?> additionalNotes;
  final Value<int> synced;
  final Value<String> createdAt;
  const SymptomsCompanion({
    this.symptomId = const Value.absent(),
    this.userId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.date = const Value.absent(),
    this.headacheSeverity = const Value.absent(),
    this.fatigueSeverity = const Value.absent(),
    this.nauseaSeverity = const Value.absent(),
    this.dizzinessSeverity = const Value.absent(),
    this.brainFogSeverity = const Value.absent(),
    this.irritabilitySeverity = const Value.absent(),
    this.muscleCrampsSeverity = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.mentalClarity = const Value.absent(),
    this.moodRating = const Value.absent(),
    this.hungerLevel = const Value.absent(),
    this.satietyLevel = const Value.absent(),
    this.bloatingSeverity = const Value.absent(),
    this.digestionQuality = const Value.absent(),
    this.customSymptoms = const Value.absent(),
    this.additionalNotes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SymptomsCompanion.insert({
    this.symptomId = const Value.absent(),
    required int userId,
    required String recordedAt,
    required String date,
    this.headacheSeverity = const Value.absent(),
    this.fatigueSeverity = const Value.absent(),
    this.nauseaSeverity = const Value.absent(),
    this.dizzinessSeverity = const Value.absent(),
    this.brainFogSeverity = const Value.absent(),
    this.irritabilitySeverity = const Value.absent(),
    this.muscleCrampsSeverity = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.mentalClarity = const Value.absent(),
    this.moodRating = const Value.absent(),
    this.hungerLevel = const Value.absent(),
    this.satietyLevel = const Value.absent(),
    this.bloatingSeverity = const Value.absent(),
    this.digestionQuality = const Value.absent(),
    this.customSymptoms = const Value.absent(),
    this.additionalNotes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        recordedAt = Value(recordedAt),
        date = Value(date);
  static Insertable<Symptom> custom({
    Expression<int>? symptomId,
    Expression<int>? userId,
    Expression<String>? recordedAt,
    Expression<String>? date,
    Expression<int>? headacheSeverity,
    Expression<int>? fatigueSeverity,
    Expression<int>? nauseaSeverity,
    Expression<int>? dizzinessSeverity,
    Expression<int>? brainFogSeverity,
    Expression<int>? irritabilitySeverity,
    Expression<int>? muscleCrampsSeverity,
    Expression<int>? energyLevel,
    Expression<int>? mentalClarity,
    Expression<int>? moodRating,
    Expression<int>? hungerLevel,
    Expression<int>? satietyLevel,
    Expression<int>? bloatingSeverity,
    Expression<int>? digestionQuality,
    Expression<String>? customSymptoms,
    Expression<String>? additionalNotes,
    Expression<int>? synced,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (symptomId != null) 'symptom_id': symptomId,
      if (userId != null) 'user_id': userId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (date != null) 'date': date,
      if (headacheSeverity != null) 'headache_severity': headacheSeverity,
      if (fatigueSeverity != null) 'fatigue_severity': fatigueSeverity,
      if (nauseaSeverity != null) 'nausea_severity': nauseaSeverity,
      if (dizzinessSeverity != null) 'dizziness_severity': dizzinessSeverity,
      if (brainFogSeverity != null) 'brain_fog_severity': brainFogSeverity,
      if (irritabilitySeverity != null)
        'irritability_severity': irritabilitySeverity,
      if (muscleCrampsSeverity != null)
        'muscle_cramps_severity': muscleCrampsSeverity,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (mentalClarity != null) 'mental_clarity': mentalClarity,
      if (moodRating != null) 'mood_rating': moodRating,
      if (hungerLevel != null) 'hunger_level': hungerLevel,
      if (satietyLevel != null) 'satiety_level': satietyLevel,
      if (bloatingSeverity != null) 'bloating_severity': bloatingSeverity,
      if (digestionQuality != null) 'digestion_quality': digestionQuality,
      if (customSymptoms != null) 'custom_symptoms': customSymptoms,
      if (additionalNotes != null) 'additional_notes': additionalNotes,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SymptomsCompanion copyWith(
      {Value<int>? symptomId,
      Value<int>? userId,
      Value<String>? recordedAt,
      Value<String>? date,
      Value<int?>? headacheSeverity,
      Value<int?>? fatigueSeverity,
      Value<int?>? nauseaSeverity,
      Value<int?>? dizzinessSeverity,
      Value<int?>? brainFogSeverity,
      Value<int?>? irritabilitySeverity,
      Value<int?>? muscleCrampsSeverity,
      Value<int?>? energyLevel,
      Value<int?>? mentalClarity,
      Value<int?>? moodRating,
      Value<int?>? hungerLevel,
      Value<int?>? satietyLevel,
      Value<int?>? bloatingSeverity,
      Value<int?>? digestionQuality,
      Value<String?>? customSymptoms,
      Value<String?>? additionalNotes,
      Value<int>? synced,
      Value<String>? createdAt}) {
    return SymptomsCompanion(
      symptomId: symptomId ?? this.symptomId,
      userId: userId ?? this.userId,
      recordedAt: recordedAt ?? this.recordedAt,
      date: date ?? this.date,
      headacheSeverity: headacheSeverity ?? this.headacheSeverity,
      fatigueSeverity: fatigueSeverity ?? this.fatigueSeverity,
      nauseaSeverity: nauseaSeverity ?? this.nauseaSeverity,
      dizzinessSeverity: dizzinessSeverity ?? this.dizzinessSeverity,
      brainFogSeverity: brainFogSeverity ?? this.brainFogSeverity,
      irritabilitySeverity: irritabilitySeverity ?? this.irritabilitySeverity,
      muscleCrampsSeverity: muscleCrampsSeverity ?? this.muscleCrampsSeverity,
      energyLevel: energyLevel ?? this.energyLevel,
      mentalClarity: mentalClarity ?? this.mentalClarity,
      moodRating: moodRating ?? this.moodRating,
      hungerLevel: hungerLevel ?? this.hungerLevel,
      satietyLevel: satietyLevel ?? this.satietyLevel,
      bloatingSeverity: bloatingSeverity ?? this.bloatingSeverity,
      digestionQuality: digestionQuality ?? this.digestionQuality,
      customSymptoms: customSymptoms ?? this.customSymptoms,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (symptomId.present) {
      map['symptom_id'] = Variable<int>(symptomId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<String>(recordedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (headacheSeverity.present) {
      map['headache_severity'] = Variable<int>(headacheSeverity.value);
    }
    if (fatigueSeverity.present) {
      map['fatigue_severity'] = Variable<int>(fatigueSeverity.value);
    }
    if (nauseaSeverity.present) {
      map['nausea_severity'] = Variable<int>(nauseaSeverity.value);
    }
    if (dizzinessSeverity.present) {
      map['dizziness_severity'] = Variable<int>(dizzinessSeverity.value);
    }
    if (brainFogSeverity.present) {
      map['brain_fog_severity'] = Variable<int>(brainFogSeverity.value);
    }
    if (irritabilitySeverity.present) {
      map['irritability_severity'] = Variable<int>(irritabilitySeverity.value);
    }
    if (muscleCrampsSeverity.present) {
      map['muscle_cramps_severity'] = Variable<int>(muscleCrampsSeverity.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (mentalClarity.present) {
      map['mental_clarity'] = Variable<int>(mentalClarity.value);
    }
    if (moodRating.present) {
      map['mood_rating'] = Variable<int>(moodRating.value);
    }
    if (hungerLevel.present) {
      map['hunger_level'] = Variable<int>(hungerLevel.value);
    }
    if (satietyLevel.present) {
      map['satiety_level'] = Variable<int>(satietyLevel.value);
    }
    if (bloatingSeverity.present) {
      map['bloating_severity'] = Variable<int>(bloatingSeverity.value);
    }
    if (digestionQuality.present) {
      map['digestion_quality'] = Variable<int>(digestionQuality.value);
    }
    if (customSymptoms.present) {
      map['custom_symptoms'] = Variable<String>(customSymptoms.value);
    }
    if (additionalNotes.present) {
      map['additional_notes'] = Variable<String>(additionalNotes.value);
    }
    if (synced.present) {
      map['synced'] = Variable<int>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsCompanion(')
          ..write('symptomId: $symptomId, ')
          ..write('userId: $userId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('date: $date, ')
          ..write('headacheSeverity: $headacheSeverity, ')
          ..write('fatigueSeverity: $fatigueSeverity, ')
          ..write('nauseaSeverity: $nauseaSeverity, ')
          ..write('dizzinessSeverity: $dizzinessSeverity, ')
          ..write('brainFogSeverity: $brainFogSeverity, ')
          ..write('irritabilitySeverity: $irritabilitySeverity, ')
          ..write('muscleCrampsSeverity: $muscleCrampsSeverity, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('mentalClarity: $mentalClarity, ')
          ..write('moodRating: $moodRating, ')
          ..write('hungerLevel: $hungerLevel, ')
          ..write('satietyLevel: $satietyLevel, ')
          ..write('bloatingSeverity: $bloatingSeverity, ')
          ..write('digestionQuality: $digestionQuality, ')
          ..write('customSymptoms: $customSymptoms, ')
          ..write('additionalNotes: $additionalNotes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $FoodsTable foods = $FoodsTable(this);
  late final $FoodPortionsTable foodPortions = $FoodPortionsTable(this);
  late final $DietEntriesTable dietEntries = $DietEntriesTable(this);
  late final $HealthLogsTable healthLogs = $HealthLogsTable(this);
  late final $DailySummariesTable dailySummaries = $DailySummariesTable(this);
  late final $VitalsTable vitals = $VitalsTable(this);
  late final $SymptomsTable symptoms = $SymptomsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        foods,
        foodPortions,
        dietEntries,
        healthLogs,
        dailySummaries,
        vitals,
        symptoms
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> userId,
  required String email,
  required String passwordHash,
  Value<int> emailVerified,
  Value<String?> fullName,
  Value<String?> dateOfBirth,
  Value<String?> gender,
  Value<double?> heightCm,
  Value<double?> initialWeightKg,
  Value<double> targetNetCarbs,
  Value<double?> targetProtein,
  Value<double?> targetFat,
  Value<double?> targetCalories,
  Value<String?> ketoStartDate,
  Value<String?> medicalConditions,
  Value<String?> goals,
  Value<String?> iotDevices,
  Value<int> foodCreationCount,
  Value<String?> foodCreationWindowStart,
  Value<int> maxFoodsPerWindow,
  Value<int> windowDurationDays,
  Value<int> researchConsent,
  Value<int> dataSharingConsent,
  Value<String?> anonymousId,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String?> lastLogin,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> userId,
  Value<String> email,
  Value<String> passwordHash,
  Value<int> emailVerified,
  Value<String?> fullName,
  Value<String?> dateOfBirth,
  Value<String?> gender,
  Value<double?> heightCm,
  Value<double?> initialWeightKg,
  Value<double> targetNetCarbs,
  Value<double?> targetProtein,
  Value<double?> targetFat,
  Value<double?> targetCalories,
  Value<String?> ketoStartDate,
  Value<String?> medicalConditions,
  Value<String?> goals,
  Value<String?> iotDevices,
  Value<int> foodCreationCount,
  Value<String?> foodCreationWindowStart,
  Value<int> maxFoodsPerWindow,
  Value<int> windowDurationDays,
  Value<int> researchConsent,
  Value<int> dataSharingConsent,
  Value<String?> anonymousId,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String?> lastLogin,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get emailVerified => $composableBuilder(
      column: $table.emailVerified, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get initialWeightKg => $composableBuilder(
      column: $table.initialWeightKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetNetCarbs => $composableBuilder(
      column: $table.targetNetCarbs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetProtein => $composableBuilder(
      column: $table.targetProtein, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetFat => $composableBuilder(
      column: $table.targetFat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetCalories => $composableBuilder(
      column: $table.targetCalories,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ketoStartDate => $composableBuilder(
      column: $table.ketoStartDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicalConditions => $composableBuilder(
      column: $table.medicalConditions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goals => $composableBuilder(
      column: $table.goals, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iotDevices => $composableBuilder(
      column: $table.iotDevices, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get foodCreationCount => $composableBuilder(
      column: $table.foodCreationCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodCreationWindowStart => $composableBuilder(
      column: $table.foodCreationWindowStart,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxFoodsPerWindow => $composableBuilder(
      column: $table.maxFoodsPerWindow,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get windowDurationDays => $composableBuilder(
      column: $table.windowDurationDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get researchConsent => $composableBuilder(
      column: $table.researchConsent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dataSharingConsent => $composableBuilder(
      column: $table.dataSharingConsent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get anonymousId => $composableBuilder(
      column: $table.anonymousId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastLogin => $composableBuilder(
      column: $table.lastLogin, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get emailVerified => $composableBuilder(
      column: $table.emailVerified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get initialWeightKg => $composableBuilder(
      column: $table.initialWeightKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetNetCarbs => $composableBuilder(
      column: $table.targetNetCarbs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetProtein => $composableBuilder(
      column: $table.targetProtein,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetFat => $composableBuilder(
      column: $table.targetFat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetCalories => $composableBuilder(
      column: $table.targetCalories,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ketoStartDate => $composableBuilder(
      column: $table.ketoStartDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicalConditions => $composableBuilder(
      column: $table.medicalConditions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goals => $composableBuilder(
      column: $table.goals, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iotDevices => $composableBuilder(
      column: $table.iotDevices, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get foodCreationCount => $composableBuilder(
      column: $table.foodCreationCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodCreationWindowStart => $composableBuilder(
      column: $table.foodCreationWindowStart,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxFoodsPerWindow => $composableBuilder(
      column: $table.maxFoodsPerWindow,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get windowDurationDays => $composableBuilder(
      column: $table.windowDurationDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get researchConsent => $composableBuilder(
      column: $table.researchConsent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dataSharingConsent => $composableBuilder(
      column: $table.dataSharingConsent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get anonymousId => $composableBuilder(
      column: $table.anonymousId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastLogin => $composableBuilder(
      column: $table.lastLogin, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<int> get emailVerified => $composableBuilder(
      column: $table.emailVerified, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get initialWeightKg => $composableBuilder(
      column: $table.initialWeightKg, builder: (column) => column);

  GeneratedColumn<double> get targetNetCarbs => $composableBuilder(
      column: $table.targetNetCarbs, builder: (column) => column);

  GeneratedColumn<double> get targetProtein => $composableBuilder(
      column: $table.targetProtein, builder: (column) => column);

  GeneratedColumn<double> get targetFat =>
      $composableBuilder(column: $table.targetFat, builder: (column) => column);

  GeneratedColumn<double> get targetCalories => $composableBuilder(
      column: $table.targetCalories, builder: (column) => column);

  GeneratedColumn<String> get ketoStartDate => $composableBuilder(
      column: $table.ketoStartDate, builder: (column) => column);

  GeneratedColumn<String> get medicalConditions => $composableBuilder(
      column: $table.medicalConditions, builder: (column) => column);

  GeneratedColumn<String> get goals =>
      $composableBuilder(column: $table.goals, builder: (column) => column);

  GeneratedColumn<String> get iotDevices => $composableBuilder(
      column: $table.iotDevices, builder: (column) => column);

  GeneratedColumn<int> get foodCreationCount => $composableBuilder(
      column: $table.foodCreationCount, builder: (column) => column);

  GeneratedColumn<String> get foodCreationWindowStart => $composableBuilder(
      column: $table.foodCreationWindowStart, builder: (column) => column);

  GeneratedColumn<int> get maxFoodsPerWindow => $composableBuilder(
      column: $table.maxFoodsPerWindow, builder: (column) => column);

  GeneratedColumn<int> get windowDurationDays => $composableBuilder(
      column: $table.windowDurationDays, builder: (column) => column);

  GeneratedColumn<int> get researchConsent => $composableBuilder(
      column: $table.researchConsent, builder: (column) => column);

  GeneratedColumn<int> get dataSharingConsent => $composableBuilder(
      column: $table.dataSharingConsent, builder: (column) => column);

  GeneratedColumn<String> get anonymousId => $composableBuilder(
      column: $table.anonymousId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get lastLogin =>
      $composableBuilder(column: $table.lastLogin, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> userId = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<int> emailVerified = const Value.absent(),
            Value<String?> fullName = const Value.absent(),
            Value<String?> dateOfBirth = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> heightCm = const Value.absent(),
            Value<double?> initialWeightKg = const Value.absent(),
            Value<double> targetNetCarbs = const Value.absent(),
            Value<double?> targetProtein = const Value.absent(),
            Value<double?> targetFat = const Value.absent(),
            Value<double?> targetCalories = const Value.absent(),
            Value<String?> ketoStartDate = const Value.absent(),
            Value<String?> medicalConditions = const Value.absent(),
            Value<String?> goals = const Value.absent(),
            Value<String?> iotDevices = const Value.absent(),
            Value<int> foodCreationCount = const Value.absent(),
            Value<String?> foodCreationWindowStart = const Value.absent(),
            Value<int> maxFoodsPerWindow = const Value.absent(),
            Value<int> windowDurationDays = const Value.absent(),
            Value<int> researchConsent = const Value.absent(),
            Value<int> dataSharingConsent = const Value.absent(),
            Value<String?> anonymousId = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String?> lastLogin = const Value.absent(),
          }) =>
              UsersCompanion(
            userId: userId,
            email: email,
            passwordHash: passwordHash,
            emailVerified: emailVerified,
            fullName: fullName,
            dateOfBirth: dateOfBirth,
            gender: gender,
            heightCm: heightCm,
            initialWeightKg: initialWeightKg,
            targetNetCarbs: targetNetCarbs,
            targetProtein: targetProtein,
            targetFat: targetFat,
            targetCalories: targetCalories,
            ketoStartDate: ketoStartDate,
            medicalConditions: medicalConditions,
            goals: goals,
            iotDevices: iotDevices,
            foodCreationCount: foodCreationCount,
            foodCreationWindowStart: foodCreationWindowStart,
            maxFoodsPerWindow: maxFoodsPerWindow,
            windowDurationDays: windowDurationDays,
            researchConsent: researchConsent,
            dataSharingConsent: dataSharingConsent,
            anonymousId: anonymousId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastLogin: lastLogin,
          ),
          createCompanionCallback: ({
            Value<int> userId = const Value.absent(),
            required String email,
            required String passwordHash,
            Value<int> emailVerified = const Value.absent(),
            Value<String?> fullName = const Value.absent(),
            Value<String?> dateOfBirth = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> heightCm = const Value.absent(),
            Value<double?> initialWeightKg = const Value.absent(),
            Value<double> targetNetCarbs = const Value.absent(),
            Value<double?> targetProtein = const Value.absent(),
            Value<double?> targetFat = const Value.absent(),
            Value<double?> targetCalories = const Value.absent(),
            Value<String?> ketoStartDate = const Value.absent(),
            Value<String?> medicalConditions = const Value.absent(),
            Value<String?> goals = const Value.absent(),
            Value<String?> iotDevices = const Value.absent(),
            Value<int> foodCreationCount = const Value.absent(),
            Value<String?> foodCreationWindowStart = const Value.absent(),
            Value<int> maxFoodsPerWindow = const Value.absent(),
            Value<int> windowDurationDays = const Value.absent(),
            Value<int> researchConsent = const Value.absent(),
            Value<int> dataSharingConsent = const Value.absent(),
            Value<String?> anonymousId = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String?> lastLogin = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            userId: userId,
            email: email,
            passwordHash: passwordHash,
            emailVerified: emailVerified,
            fullName: fullName,
            dateOfBirth: dateOfBirth,
            gender: gender,
            heightCm: heightCm,
            initialWeightKg: initialWeightKg,
            targetNetCarbs: targetNetCarbs,
            targetProtein: targetProtein,
            targetFat: targetFat,
            targetCalories: targetCalories,
            ketoStartDate: ketoStartDate,
            medicalConditions: medicalConditions,
            goals: goals,
            iotDevices: iotDevices,
            foodCreationCount: foodCreationCount,
            foodCreationWindowStart: foodCreationWindowStart,
            maxFoodsPerWindow: maxFoodsPerWindow,
            windowDurationDays: windowDurationDays,
            researchConsent: researchConsent,
            dataSharingConsent: dataSharingConsent,
            anonymousId: anonymousId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastLogin: lastLogin,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$FoodsTableCreateCompanionBuilder = FoodsCompanion Function({
  Value<int> foodId,
  Value<String?> keylist,
  required String foodDescription,
  Value<String> source,
  Value<int?> createdByUserId,
  Value<int> isVerified,
  Value<int?> isKetoFriendly,
  required double energyKcal,
  required double totalProteinG,
  required double totalFatG,
  required double totalCarbohydrateG,
  Value<double> dietaryFiberG,
  Value<double> sugarG,
  Value<double> addedSugarG,
  Value<double?> netCarbsG,
  Value<double?> saturatedFatG,
  Value<double?> monounsaturatedFatG,
  Value<double?> polyunsaturatedFatG,
  Value<double?> transFatG,
  Value<double?> cholesterolMg,
  Value<double?> sodiumMg,
  Value<double?> potassiumMg,
  Value<double?> magnesiumMg,
  Value<double?> calciumMg,
  Value<int?> glycemicIndex,
  Value<double?> glycemicLoad,
  Value<String?> vitamins,
  Value<String?> minerals,
  Value<String?> foodPhotoUrl,
  Value<String?> barcode,
  Value<String> createdAt,
  Value<String> updatedAt,
});
typedef $$FoodsTableUpdateCompanionBuilder = FoodsCompanion Function({
  Value<int> foodId,
  Value<String?> keylist,
  Value<String> foodDescription,
  Value<String> source,
  Value<int?> createdByUserId,
  Value<int> isVerified,
  Value<int?> isKetoFriendly,
  Value<double> energyKcal,
  Value<double> totalProteinG,
  Value<double> totalFatG,
  Value<double> totalCarbohydrateG,
  Value<double> dietaryFiberG,
  Value<double> sugarG,
  Value<double> addedSugarG,
  Value<double?> netCarbsG,
  Value<double?> saturatedFatG,
  Value<double?> monounsaturatedFatG,
  Value<double?> polyunsaturatedFatG,
  Value<double?> transFatG,
  Value<double?> cholesterolMg,
  Value<double?> sodiumMg,
  Value<double?> potassiumMg,
  Value<double?> magnesiumMg,
  Value<double?> calciumMg,
  Value<int?> glycemicIndex,
  Value<double?> glycemicLoad,
  Value<String?> vitamins,
  Value<String?> minerals,
  Value<String?> foodPhotoUrl,
  Value<String?> barcode,
  Value<String> createdAt,
  Value<String> updatedAt,
});

class $$FoodsTableFilterComposer extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get keylist => $composableBuilder(
      column: $table.keylist, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodDescription => $composableBuilder(
      column: $table.foodDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdByUserId => $composableBuilder(
      column: $table.createdByUserId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isKetoFriendly => $composableBuilder(
      column: $table.isKetoFriendly,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get energyKcal => $composableBuilder(
      column: $table.energyKcal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFatG => $composableBuilder(
      column: $table.totalFatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dietaryFiberG => $composableBuilder(
      column: $table.dietaryFiberG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sugarG => $composableBuilder(
      column: $table.sugarG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get addedSugarG => $composableBuilder(
      column: $table.addedSugarG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get netCarbsG => $composableBuilder(
      column: $table.netCarbsG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get saturatedFatG => $composableBuilder(
      column: $table.saturatedFatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monounsaturatedFatG => $composableBuilder(
      column: $table.monounsaturatedFatG,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get polyunsaturatedFatG => $composableBuilder(
      column: $table.polyunsaturatedFatG,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get transFatG => $composableBuilder(
      column: $table.transFatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cholesterolMg => $composableBuilder(
      column: $table.cholesterolMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sodiumMg => $composableBuilder(
      column: $table.sodiumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get potassiumMg => $composableBuilder(
      column: $table.potassiumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get magnesiumMg => $composableBuilder(
      column: $table.magnesiumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get calciumMg => $composableBuilder(
      column: $table.calciumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get glycemicIndex => $composableBuilder(
      column: $table.glycemicIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get glycemicLoad => $composableBuilder(
      column: $table.glycemicLoad, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vitamins => $composableBuilder(
      column: $table.vitamins, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get minerals => $composableBuilder(
      column: $table.minerals, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodPhotoUrl => $composableBuilder(
      column: $table.foodPhotoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$FoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get keylist => $composableBuilder(
      column: $table.keylist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodDescription => $composableBuilder(
      column: $table.foodDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdByUserId => $composableBuilder(
      column: $table.createdByUserId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isKetoFriendly => $composableBuilder(
      column: $table.isKetoFriendly,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get energyKcal => $composableBuilder(
      column: $table.energyKcal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFatG => $composableBuilder(
      column: $table.totalFatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dietaryFiberG => $composableBuilder(
      column: $table.dietaryFiberG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sugarG => $composableBuilder(
      column: $table.sugarG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get addedSugarG => $composableBuilder(
      column: $table.addedSugarG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get netCarbsG => $composableBuilder(
      column: $table.netCarbsG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get saturatedFatG => $composableBuilder(
      column: $table.saturatedFatG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monounsaturatedFatG => $composableBuilder(
      column: $table.monounsaturatedFatG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get polyunsaturatedFatG => $composableBuilder(
      column: $table.polyunsaturatedFatG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get transFatG => $composableBuilder(
      column: $table.transFatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cholesterolMg => $composableBuilder(
      column: $table.cholesterolMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sodiumMg => $composableBuilder(
      column: $table.sodiumMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get potassiumMg => $composableBuilder(
      column: $table.potassiumMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get magnesiumMg => $composableBuilder(
      column: $table.magnesiumMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get calciumMg => $composableBuilder(
      column: $table.calciumMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get glycemicIndex => $composableBuilder(
      column: $table.glycemicIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get glycemicLoad => $composableBuilder(
      column: $table.glycemicLoad,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vitamins => $composableBuilder(
      column: $table.vitamins, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get minerals => $composableBuilder(
      column: $table.minerals, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodPhotoUrl => $composableBuilder(
      column: $table.foodPhotoUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$FoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get keylist =>
      $composableBuilder(column: $table.keylist, builder: (column) => column);

  GeneratedColumn<String> get foodDescription => $composableBuilder(
      column: $table.foodDescription, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get createdByUserId => $composableBuilder(
      column: $table.createdByUserId, builder: (column) => column);

  GeneratedColumn<int> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => column);

  GeneratedColumn<int> get isKetoFriendly => $composableBuilder(
      column: $table.isKetoFriendly, builder: (column) => column);

  GeneratedColumn<double> get energyKcal => $composableBuilder(
      column: $table.energyKcal, builder: (column) => column);

  GeneratedColumn<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG, builder: (column) => column);

  GeneratedColumn<double> get totalFatG =>
      $composableBuilder(column: $table.totalFatG, builder: (column) => column);

  GeneratedColumn<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG, builder: (column) => column);

  GeneratedColumn<double> get dietaryFiberG => $composableBuilder(
      column: $table.dietaryFiberG, builder: (column) => column);

  GeneratedColumn<double> get sugarG =>
      $composableBuilder(column: $table.sugarG, builder: (column) => column);

  GeneratedColumn<double> get addedSugarG => $composableBuilder(
      column: $table.addedSugarG, builder: (column) => column);

  GeneratedColumn<double> get netCarbsG =>
      $composableBuilder(column: $table.netCarbsG, builder: (column) => column);

  GeneratedColumn<double> get saturatedFatG => $composableBuilder(
      column: $table.saturatedFatG, builder: (column) => column);

  GeneratedColumn<double> get monounsaturatedFatG => $composableBuilder(
      column: $table.monounsaturatedFatG, builder: (column) => column);

  GeneratedColumn<double> get polyunsaturatedFatG => $composableBuilder(
      column: $table.polyunsaturatedFatG, builder: (column) => column);

  GeneratedColumn<double> get transFatG =>
      $composableBuilder(column: $table.transFatG, builder: (column) => column);

  GeneratedColumn<double> get cholesterolMg => $composableBuilder(
      column: $table.cholesterolMg, builder: (column) => column);

  GeneratedColumn<double> get sodiumMg =>
      $composableBuilder(column: $table.sodiumMg, builder: (column) => column);

  GeneratedColumn<double> get potassiumMg => $composableBuilder(
      column: $table.potassiumMg, builder: (column) => column);

  GeneratedColumn<double> get magnesiumMg => $composableBuilder(
      column: $table.magnesiumMg, builder: (column) => column);

  GeneratedColumn<double> get calciumMg =>
      $composableBuilder(column: $table.calciumMg, builder: (column) => column);

  GeneratedColumn<int> get glycemicIndex => $composableBuilder(
      column: $table.glycemicIndex, builder: (column) => column);

  GeneratedColumn<double> get glycemicLoad => $composableBuilder(
      column: $table.glycemicLoad, builder: (column) => column);

  GeneratedColumn<String> get vitamins =>
      $composableBuilder(column: $table.vitamins, builder: (column) => column);

  GeneratedColumn<String> get minerals =>
      $composableBuilder(column: $table.minerals, builder: (column) => column);

  GeneratedColumn<String> get foodPhotoUrl => $composableBuilder(
      column: $table.foodPhotoUrl, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FoodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodsTable,
    Food,
    $$FoodsTableFilterComposer,
    $$FoodsTableOrderingComposer,
    $$FoodsTableAnnotationComposer,
    $$FoodsTableCreateCompanionBuilder,
    $$FoodsTableUpdateCompanionBuilder,
    (Food, BaseReferences<_$AppDatabase, $FoodsTable, Food>),
    Food,
    PrefetchHooks Function()> {
  $$FoodsTableTableManager(_$AppDatabase db, $FoodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> foodId = const Value.absent(),
            Value<String?> keylist = const Value.absent(),
            Value<String> foodDescription = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<int?> createdByUserId = const Value.absent(),
            Value<int> isVerified = const Value.absent(),
            Value<int?> isKetoFriendly = const Value.absent(),
            Value<double> energyKcal = const Value.absent(),
            Value<double> totalProteinG = const Value.absent(),
            Value<double> totalFatG = const Value.absent(),
            Value<double> totalCarbohydrateG = const Value.absent(),
            Value<double> dietaryFiberG = const Value.absent(),
            Value<double> sugarG = const Value.absent(),
            Value<double> addedSugarG = const Value.absent(),
            Value<double?> netCarbsG = const Value.absent(),
            Value<double?> saturatedFatG = const Value.absent(),
            Value<double?> monounsaturatedFatG = const Value.absent(),
            Value<double?> polyunsaturatedFatG = const Value.absent(),
            Value<double?> transFatG = const Value.absent(),
            Value<double?> cholesterolMg = const Value.absent(),
            Value<double?> sodiumMg = const Value.absent(),
            Value<double?> potassiumMg = const Value.absent(),
            Value<double?> magnesiumMg = const Value.absent(),
            Value<double?> calciumMg = const Value.absent(),
            Value<int?> glycemicIndex = const Value.absent(),
            Value<double?> glycemicLoad = const Value.absent(),
            Value<String?> vitamins = const Value.absent(),
            Value<String?> minerals = const Value.absent(),
            Value<String?> foodPhotoUrl = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              FoodsCompanion(
            foodId: foodId,
            keylist: keylist,
            foodDescription: foodDescription,
            source: source,
            createdByUserId: createdByUserId,
            isVerified: isVerified,
            isKetoFriendly: isKetoFriendly,
            energyKcal: energyKcal,
            totalProteinG: totalProteinG,
            totalFatG: totalFatG,
            totalCarbohydrateG: totalCarbohydrateG,
            dietaryFiberG: dietaryFiberG,
            sugarG: sugarG,
            addedSugarG: addedSugarG,
            netCarbsG: netCarbsG,
            saturatedFatG: saturatedFatG,
            monounsaturatedFatG: monounsaturatedFatG,
            polyunsaturatedFatG: polyunsaturatedFatG,
            transFatG: transFatG,
            cholesterolMg: cholesterolMg,
            sodiumMg: sodiumMg,
            potassiumMg: potassiumMg,
            magnesiumMg: magnesiumMg,
            calciumMg: calciumMg,
            glycemicIndex: glycemicIndex,
            glycemicLoad: glycemicLoad,
            vitamins: vitamins,
            minerals: minerals,
            foodPhotoUrl: foodPhotoUrl,
            barcode: barcode,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> foodId = const Value.absent(),
            Value<String?> keylist = const Value.absent(),
            required String foodDescription,
            Value<String> source = const Value.absent(),
            Value<int?> createdByUserId = const Value.absent(),
            Value<int> isVerified = const Value.absent(),
            Value<int?> isKetoFriendly = const Value.absent(),
            required double energyKcal,
            required double totalProteinG,
            required double totalFatG,
            required double totalCarbohydrateG,
            Value<double> dietaryFiberG = const Value.absent(),
            Value<double> sugarG = const Value.absent(),
            Value<double> addedSugarG = const Value.absent(),
            Value<double?> netCarbsG = const Value.absent(),
            Value<double?> saturatedFatG = const Value.absent(),
            Value<double?> monounsaturatedFatG = const Value.absent(),
            Value<double?> polyunsaturatedFatG = const Value.absent(),
            Value<double?> transFatG = const Value.absent(),
            Value<double?> cholesterolMg = const Value.absent(),
            Value<double?> sodiumMg = const Value.absent(),
            Value<double?> potassiumMg = const Value.absent(),
            Value<double?> magnesiumMg = const Value.absent(),
            Value<double?> calciumMg = const Value.absent(),
            Value<int?> glycemicIndex = const Value.absent(),
            Value<double?> glycemicLoad = const Value.absent(),
            Value<String?> vitamins = const Value.absent(),
            Value<String?> minerals = const Value.absent(),
            Value<String?> foodPhotoUrl = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              FoodsCompanion.insert(
            foodId: foodId,
            keylist: keylist,
            foodDescription: foodDescription,
            source: source,
            createdByUserId: createdByUserId,
            isVerified: isVerified,
            isKetoFriendly: isKetoFriendly,
            energyKcal: energyKcal,
            totalProteinG: totalProteinG,
            totalFatG: totalFatG,
            totalCarbohydrateG: totalCarbohydrateG,
            dietaryFiberG: dietaryFiberG,
            sugarG: sugarG,
            addedSugarG: addedSugarG,
            netCarbsG: netCarbsG,
            saturatedFatG: saturatedFatG,
            monounsaturatedFatG: monounsaturatedFatG,
            polyunsaturatedFatG: polyunsaturatedFatG,
            transFatG: transFatG,
            cholesterolMg: cholesterolMg,
            sodiumMg: sodiumMg,
            potassiumMg: potassiumMg,
            magnesiumMg: magnesiumMg,
            calciumMg: calciumMg,
            glycemicIndex: glycemicIndex,
            glycemicLoad: glycemicLoad,
            vitamins: vitamins,
            minerals: minerals,
            foodPhotoUrl: foodPhotoUrl,
            barcode: barcode,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodsTable,
    Food,
    $$FoodsTableFilterComposer,
    $$FoodsTableOrderingComposer,
    $$FoodsTableAnnotationComposer,
    $$FoodsTableCreateCompanionBuilder,
    $$FoodsTableUpdateCompanionBuilder,
    (Food, BaseReferences<_$AppDatabase, $FoodsTable, Food>),
    Food,
    PrefetchHooks Function()>;
typedef $$FoodPortionsTableCreateCompanionBuilder = FoodPortionsCompanion
    Function({
  Value<int> portionId,
  required int foodId,
  required double portionAmount,
  required String portionUnit,
  Value<String?> portionDescription,
  required double portionGramWeight,
  Value<double?> energyKcal,
  Value<double?> proteinG,
  Value<double?> fatG,
  Value<double?> carbohydrateG,
  Value<double?> netCarbsG,
  Value<int> isDefault,
  Value<String> createdAt,
});
typedef $$FoodPortionsTableUpdateCompanionBuilder = FoodPortionsCompanion
    Function({
  Value<int> portionId,
  Value<int> foodId,
  Value<double> portionAmount,
  Value<String> portionUnit,
  Value<String?> portionDescription,
  Value<double> portionGramWeight,
  Value<double?> energyKcal,
  Value<double?> proteinG,
  Value<double?> fatG,
  Value<double?> carbohydrateG,
  Value<double?> netCarbsG,
  Value<int> isDefault,
  Value<String> createdAt,
});

class $$FoodPortionsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodPortionsTable> {
  $$FoodPortionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get portionId => $composableBuilder(
      column: $table.portionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get portionAmount => $composableBuilder(
      column: $table.portionAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get portionUnit => $composableBuilder(
      column: $table.portionUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get portionDescription => $composableBuilder(
      column: $table.portionDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get portionGramWeight => $composableBuilder(
      column: $table.portionGramWeight,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get energyKcal => $composableBuilder(
      column: $table.energyKcal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinG => $composableBuilder(
      column: $table.proteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatG => $composableBuilder(
      column: $table.fatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbohydrateG => $composableBuilder(
      column: $table.carbohydrateG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get netCarbsG => $composableBuilder(
      column: $table.netCarbsG, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$FoodPortionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodPortionsTable> {
  $$FoodPortionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get portionId => $composableBuilder(
      column: $table.portionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get portionAmount => $composableBuilder(
      column: $table.portionAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get portionUnit => $composableBuilder(
      column: $table.portionUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get portionDescription => $composableBuilder(
      column: $table.portionDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get portionGramWeight => $composableBuilder(
      column: $table.portionGramWeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get energyKcal => $composableBuilder(
      column: $table.energyKcal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinG => $composableBuilder(
      column: $table.proteinG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatG => $composableBuilder(
      column: $table.fatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbohydrateG => $composableBuilder(
      column: $table.carbohydrateG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get netCarbsG => $composableBuilder(
      column: $table.netCarbsG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$FoodPortionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodPortionsTable> {
  $$FoodPortionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get portionId =>
      $composableBuilder(column: $table.portionId, builder: (column) => column);

  GeneratedColumn<int> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<double> get portionAmount => $composableBuilder(
      column: $table.portionAmount, builder: (column) => column);

  GeneratedColumn<String> get portionUnit => $composableBuilder(
      column: $table.portionUnit, builder: (column) => column);

  GeneratedColumn<String> get portionDescription => $composableBuilder(
      column: $table.portionDescription, builder: (column) => column);

  GeneratedColumn<double> get portionGramWeight => $composableBuilder(
      column: $table.portionGramWeight, builder: (column) => column);

  GeneratedColumn<double> get energyKcal => $composableBuilder(
      column: $table.energyKcal, builder: (column) => column);

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<double> get carbohydrateG => $composableBuilder(
      column: $table.carbohydrateG, builder: (column) => column);

  GeneratedColumn<double> get netCarbsG =>
      $composableBuilder(column: $table.netCarbsG, builder: (column) => column);

  GeneratedColumn<int> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FoodPortionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodPortionsTable,
    FoodPortion,
    $$FoodPortionsTableFilterComposer,
    $$FoodPortionsTableOrderingComposer,
    $$FoodPortionsTableAnnotationComposer,
    $$FoodPortionsTableCreateCompanionBuilder,
    $$FoodPortionsTableUpdateCompanionBuilder,
    (
      FoodPortion,
      BaseReferences<_$AppDatabase, $FoodPortionsTable, FoodPortion>
    ),
    FoodPortion,
    PrefetchHooks Function()> {
  $$FoodPortionsTableTableManager(_$AppDatabase db, $FoodPortionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodPortionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodPortionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodPortionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> portionId = const Value.absent(),
            Value<int> foodId = const Value.absent(),
            Value<double> portionAmount = const Value.absent(),
            Value<String> portionUnit = const Value.absent(),
            Value<String?> portionDescription = const Value.absent(),
            Value<double> portionGramWeight = const Value.absent(),
            Value<double?> energyKcal = const Value.absent(),
            Value<double?> proteinG = const Value.absent(),
            Value<double?> fatG = const Value.absent(),
            Value<double?> carbohydrateG = const Value.absent(),
            Value<double?> netCarbsG = const Value.absent(),
            Value<int> isDefault = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              FoodPortionsCompanion(
            portionId: portionId,
            foodId: foodId,
            portionAmount: portionAmount,
            portionUnit: portionUnit,
            portionDescription: portionDescription,
            portionGramWeight: portionGramWeight,
            energyKcal: energyKcal,
            proteinG: proteinG,
            fatG: fatG,
            carbohydrateG: carbohydrateG,
            netCarbsG: netCarbsG,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> portionId = const Value.absent(),
            required int foodId,
            required double portionAmount,
            required String portionUnit,
            Value<String?> portionDescription = const Value.absent(),
            required double portionGramWeight,
            Value<double?> energyKcal = const Value.absent(),
            Value<double?> proteinG = const Value.absent(),
            Value<double?> fatG = const Value.absent(),
            Value<double?> carbohydrateG = const Value.absent(),
            Value<double?> netCarbsG = const Value.absent(),
            Value<int> isDefault = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              FoodPortionsCompanion.insert(
            portionId: portionId,
            foodId: foodId,
            portionAmount: portionAmount,
            portionUnit: portionUnit,
            portionDescription: portionDescription,
            portionGramWeight: portionGramWeight,
            energyKcal: energyKcal,
            proteinG: proteinG,
            fatG: fatG,
            carbohydrateG: carbohydrateG,
            netCarbsG: netCarbsG,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodPortionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodPortionsTable,
    FoodPortion,
    $$FoodPortionsTableFilterComposer,
    $$FoodPortionsTableOrderingComposer,
    $$FoodPortionsTableAnnotationComposer,
    $$FoodPortionsTableCreateCompanionBuilder,
    $$FoodPortionsTableUpdateCompanionBuilder,
    (
      FoodPortion,
      BaseReferences<_$AppDatabase, $FoodPortionsTable, FoodPortion>
    ),
    FoodPortion,
    PrefetchHooks Function()>;
typedef $$DietEntriesTableCreateCompanionBuilder = DietEntriesCompanion
    Function({
  Value<int> entryId,
  required int userId,
  required int foodId,
  required String recordedAt,
  required String date,
  Value<int?> portionId,
  Value<double?> customPortionGrams,
  Value<double> servingSizeMultiplier,
  required double totalEnergyKcal,
  required double totalProteinG,
  required double totalFatG,
  required double totalCarbohydrateG,
  required double totalNetCarbsG,
  Value<double?> totalFiberG,
  Value<double?> totalSodiumMg,
  Value<String?> mealContext,
  Value<String?> location,
  Value<String?> notes,
  Value<String?> foodPhotoUrl,
  Value<int> synced,
  Value<String> createdAt,
  Value<String> updatedAt,
});
typedef $$DietEntriesTableUpdateCompanionBuilder = DietEntriesCompanion
    Function({
  Value<int> entryId,
  Value<int> userId,
  Value<int> foodId,
  Value<String> recordedAt,
  Value<String> date,
  Value<int?> portionId,
  Value<double?> customPortionGrams,
  Value<double> servingSizeMultiplier,
  Value<double> totalEnergyKcal,
  Value<double> totalProteinG,
  Value<double> totalFatG,
  Value<double> totalCarbohydrateG,
  Value<double> totalNetCarbsG,
  Value<double?> totalFiberG,
  Value<double?> totalSodiumMg,
  Value<String?> mealContext,
  Value<String?> location,
  Value<String?> notes,
  Value<String?> foodPhotoUrl,
  Value<int> synced,
  Value<String> createdAt,
  Value<String> updatedAt,
});

class $$DietEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DietEntriesTable> {
  $$DietEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get entryId => $composableBuilder(
      column: $table.entryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get portionId => $composableBuilder(
      column: $table.portionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get customPortionGrams => $composableBuilder(
      column: $table.customPortionGrams,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get servingSizeMultiplier => $composableBuilder(
      column: $table.servingSizeMultiplier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalEnergyKcal => $composableBuilder(
      column: $table.totalEnergyKcal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFatG => $composableBuilder(
      column: $table.totalFatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalNetCarbsG => $composableBuilder(
      column: $table.totalNetCarbsG,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalSodiumMg => $composableBuilder(
      column: $table.totalSodiumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mealContext => $composableBuilder(
      column: $table.mealContext, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodPhotoUrl => $composableBuilder(
      column: $table.foodPhotoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DietEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DietEntriesTable> {
  $$DietEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get entryId => $composableBuilder(
      column: $table.entryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get portionId => $composableBuilder(
      column: $table.portionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get customPortionGrams => $composableBuilder(
      column: $table.customPortionGrams,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get servingSizeMultiplier => $composableBuilder(
      column: $table.servingSizeMultiplier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalEnergyKcal => $composableBuilder(
      column: $table.totalEnergyKcal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFatG => $composableBuilder(
      column: $table.totalFatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalNetCarbsG => $composableBuilder(
      column: $table.totalNetCarbsG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalSodiumMg => $composableBuilder(
      column: $table.totalSodiumMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mealContext => $composableBuilder(
      column: $table.mealContext, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodPhotoUrl => $composableBuilder(
      column: $table.foodPhotoUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DietEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DietEntriesTable> {
  $$DietEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get entryId =>
      $composableBuilder(column: $table.entryId, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get portionId =>
      $composableBuilder(column: $table.portionId, builder: (column) => column);

  GeneratedColumn<double> get customPortionGrams => $composableBuilder(
      column: $table.customPortionGrams, builder: (column) => column);

  GeneratedColumn<double> get servingSizeMultiplier => $composableBuilder(
      column: $table.servingSizeMultiplier, builder: (column) => column);

  GeneratedColumn<double> get totalEnergyKcal => $composableBuilder(
      column: $table.totalEnergyKcal, builder: (column) => column);

  GeneratedColumn<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG, builder: (column) => column);

  GeneratedColumn<double> get totalFatG =>
      $composableBuilder(column: $table.totalFatG, builder: (column) => column);

  GeneratedColumn<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG, builder: (column) => column);

  GeneratedColumn<double> get totalNetCarbsG => $composableBuilder(
      column: $table.totalNetCarbsG, builder: (column) => column);

  GeneratedColumn<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => column);

  GeneratedColumn<double> get totalSodiumMg => $composableBuilder(
      column: $table.totalSodiumMg, builder: (column) => column);

  GeneratedColumn<String> get mealContext => $composableBuilder(
      column: $table.mealContext, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get foodPhotoUrl => $composableBuilder(
      column: $table.foodPhotoUrl, builder: (column) => column);

  GeneratedColumn<int> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DietEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DietEntriesTable,
    DietEntry,
    $$DietEntriesTableFilterComposer,
    $$DietEntriesTableOrderingComposer,
    $$DietEntriesTableAnnotationComposer,
    $$DietEntriesTableCreateCompanionBuilder,
    $$DietEntriesTableUpdateCompanionBuilder,
    (DietEntry, BaseReferences<_$AppDatabase, $DietEntriesTable, DietEntry>),
    DietEntry,
    PrefetchHooks Function()> {
  $$DietEntriesTableTableManager(_$AppDatabase db, $DietEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DietEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DietEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DietEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> entryId = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> foodId = const Value.absent(),
            Value<String> recordedAt = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int?> portionId = const Value.absent(),
            Value<double?> customPortionGrams = const Value.absent(),
            Value<double> servingSizeMultiplier = const Value.absent(),
            Value<double> totalEnergyKcal = const Value.absent(),
            Value<double> totalProteinG = const Value.absent(),
            Value<double> totalFatG = const Value.absent(),
            Value<double> totalCarbohydrateG = const Value.absent(),
            Value<double> totalNetCarbsG = const Value.absent(),
            Value<double?> totalFiberG = const Value.absent(),
            Value<double?> totalSodiumMg = const Value.absent(),
            Value<String?> mealContext = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> foodPhotoUrl = const Value.absent(),
            Value<int> synced = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              DietEntriesCompanion(
            entryId: entryId,
            userId: userId,
            foodId: foodId,
            recordedAt: recordedAt,
            date: date,
            portionId: portionId,
            customPortionGrams: customPortionGrams,
            servingSizeMultiplier: servingSizeMultiplier,
            totalEnergyKcal: totalEnergyKcal,
            totalProteinG: totalProteinG,
            totalFatG: totalFatG,
            totalCarbohydrateG: totalCarbohydrateG,
            totalNetCarbsG: totalNetCarbsG,
            totalFiberG: totalFiberG,
            totalSodiumMg: totalSodiumMg,
            mealContext: mealContext,
            location: location,
            notes: notes,
            foodPhotoUrl: foodPhotoUrl,
            synced: synced,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> entryId = const Value.absent(),
            required int userId,
            required int foodId,
            required String recordedAt,
            required String date,
            Value<int?> portionId = const Value.absent(),
            Value<double?> customPortionGrams = const Value.absent(),
            Value<double> servingSizeMultiplier = const Value.absent(),
            required double totalEnergyKcal,
            required double totalProteinG,
            required double totalFatG,
            required double totalCarbohydrateG,
            required double totalNetCarbsG,
            Value<double?> totalFiberG = const Value.absent(),
            Value<double?> totalSodiumMg = const Value.absent(),
            Value<String?> mealContext = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> foodPhotoUrl = const Value.absent(),
            Value<int> synced = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              DietEntriesCompanion.insert(
            entryId: entryId,
            userId: userId,
            foodId: foodId,
            recordedAt: recordedAt,
            date: date,
            portionId: portionId,
            customPortionGrams: customPortionGrams,
            servingSizeMultiplier: servingSizeMultiplier,
            totalEnergyKcal: totalEnergyKcal,
            totalProteinG: totalProteinG,
            totalFatG: totalFatG,
            totalCarbohydrateG: totalCarbohydrateG,
            totalNetCarbsG: totalNetCarbsG,
            totalFiberG: totalFiberG,
            totalSodiumMg: totalSodiumMg,
            mealContext: mealContext,
            location: location,
            notes: notes,
            foodPhotoUrl: foodPhotoUrl,
            synced: synced,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DietEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DietEntriesTable,
    DietEntry,
    $$DietEntriesTableFilterComposer,
    $$DietEntriesTableOrderingComposer,
    $$DietEntriesTableAnnotationComposer,
    $$DietEntriesTableCreateCompanionBuilder,
    $$DietEntriesTableUpdateCompanionBuilder,
    (DietEntry, BaseReferences<_$AppDatabase, $DietEntriesTable, DietEntry>),
    DietEntry,
    PrefetchHooks Function()>;
typedef $$HealthLogsTableCreateCompanionBuilder = HealthLogsCompanion Function({
  Value<int> logId,
  required int userId,
  required String recordedAt,
  required String date,
  Value<double?> bloodGlucoseMgDl,
  Value<double?> bloodKetonesMmolL,
  Value<double?> gkiScore,
  Value<double?> lactateMmolL,
  Value<double?> sodiumMmolL,
  Value<int?> bloodPressureSystolic,
  Value<int?> bloodPressureDiastolic,
  Value<double?> weightKg,
  Value<double?> bodyFatPercentage,
  Value<double?> muscleMassKg,
  Value<String> source,
  Value<String?> deviceId,
  Value<String?> notes,
  Value<int> synced,
  Value<String> createdAt,
});
typedef $$HealthLogsTableUpdateCompanionBuilder = HealthLogsCompanion Function({
  Value<int> logId,
  Value<int> userId,
  Value<String> recordedAt,
  Value<String> date,
  Value<double?> bloodGlucoseMgDl,
  Value<double?> bloodKetonesMmolL,
  Value<double?> gkiScore,
  Value<double?> lactateMmolL,
  Value<double?> sodiumMmolL,
  Value<int?> bloodPressureSystolic,
  Value<int?> bloodPressureDiastolic,
  Value<double?> weightKg,
  Value<double?> bodyFatPercentage,
  Value<double?> muscleMassKg,
  Value<String> source,
  Value<String?> deviceId,
  Value<String?> notes,
  Value<int> synced,
  Value<String> createdAt,
});

class $$HealthLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HealthLogsTable> {
  $$HealthLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get logId => $composableBuilder(
      column: $table.logId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bloodGlucoseMgDl => $composableBuilder(
      column: $table.bloodGlucoseMgDl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bloodKetonesMmolL => $composableBuilder(
      column: $table.bloodKetonesMmolL,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gkiScore => $composableBuilder(
      column: $table.gkiScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lactateMmolL => $composableBuilder(
      column: $table.lactateMmolL, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sodiumMmolL => $composableBuilder(
      column: $table.sodiumMmolL, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bloodPressureSystolic => $composableBuilder(
      column: $table.bloodPressureSystolic,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bloodPressureDiastolic => $composableBuilder(
      column: $table.bloodPressureDiastolic,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bodyFatPercentage => $composableBuilder(
      column: $table.bodyFatPercentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get muscleMassKg => $composableBuilder(
      column: $table.muscleMassKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$HealthLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthLogsTable> {
  $$HealthLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get logId => $composableBuilder(
      column: $table.logId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bloodGlucoseMgDl => $composableBuilder(
      column: $table.bloodGlucoseMgDl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bloodKetonesMmolL => $composableBuilder(
      column: $table.bloodKetonesMmolL,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gkiScore => $composableBuilder(
      column: $table.gkiScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lactateMmolL => $composableBuilder(
      column: $table.lactateMmolL,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sodiumMmolL => $composableBuilder(
      column: $table.sodiumMmolL, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bloodPressureSystolic => $composableBuilder(
      column: $table.bloodPressureSystolic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bloodPressureDiastolic => $composableBuilder(
      column: $table.bloodPressureDiastolic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bodyFatPercentage => $composableBuilder(
      column: $table.bodyFatPercentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get muscleMassKg => $composableBuilder(
      column: $table.muscleMassKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$HealthLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthLogsTable> {
  $$HealthLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get logId =>
      $composableBuilder(column: $table.logId, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get bloodGlucoseMgDl => $composableBuilder(
      column: $table.bloodGlucoseMgDl, builder: (column) => column);

  GeneratedColumn<double> get bloodKetonesMmolL => $composableBuilder(
      column: $table.bloodKetonesMmolL, builder: (column) => column);

  GeneratedColumn<double> get gkiScore =>
      $composableBuilder(column: $table.gkiScore, builder: (column) => column);

  GeneratedColumn<double> get lactateMmolL => $composableBuilder(
      column: $table.lactateMmolL, builder: (column) => column);

  GeneratedColumn<double> get sodiumMmolL => $composableBuilder(
      column: $table.sodiumMmolL, builder: (column) => column);

  GeneratedColumn<int> get bloodPressureSystolic => $composableBuilder(
      column: $table.bloodPressureSystolic, builder: (column) => column);

  GeneratedColumn<int> get bloodPressureDiastolic => $composableBuilder(
      column: $table.bloodPressureDiastolic, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get bodyFatPercentage => $composableBuilder(
      column: $table.bodyFatPercentage, builder: (column) => column);

  GeneratedColumn<double> get muscleMassKg => $composableBuilder(
      column: $table.muscleMassKg, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HealthLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HealthLogsTable,
    HealthLog,
    $$HealthLogsTableFilterComposer,
    $$HealthLogsTableOrderingComposer,
    $$HealthLogsTableAnnotationComposer,
    $$HealthLogsTableCreateCompanionBuilder,
    $$HealthLogsTableUpdateCompanionBuilder,
    (HealthLog, BaseReferences<_$AppDatabase, $HealthLogsTable, HealthLog>),
    HealthLog,
    PrefetchHooks Function()> {
  $$HealthLogsTableTableManager(_$AppDatabase db, $HealthLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HealthLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HealthLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> logId = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> recordedAt = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double?> bloodGlucoseMgDl = const Value.absent(),
            Value<double?> bloodKetonesMmolL = const Value.absent(),
            Value<double?> gkiScore = const Value.absent(),
            Value<double?> lactateMmolL = const Value.absent(),
            Value<double?> sodiumMmolL = const Value.absent(),
            Value<int?> bloodPressureSystolic = const Value.absent(),
            Value<int?> bloodPressureDiastolic = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<double?> bodyFatPercentage = const Value.absent(),
            Value<double?> muscleMassKg = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> synced = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              HealthLogsCompanion(
            logId: logId,
            userId: userId,
            recordedAt: recordedAt,
            date: date,
            bloodGlucoseMgDl: bloodGlucoseMgDl,
            bloodKetonesMmolL: bloodKetonesMmolL,
            gkiScore: gkiScore,
            lactateMmolL: lactateMmolL,
            sodiumMmolL: sodiumMmolL,
            bloodPressureSystolic: bloodPressureSystolic,
            bloodPressureDiastolic: bloodPressureDiastolic,
            weightKg: weightKg,
            bodyFatPercentage: bodyFatPercentage,
            muscleMassKg: muscleMassKg,
            source: source,
            deviceId: deviceId,
            notes: notes,
            synced: synced,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> logId = const Value.absent(),
            required int userId,
            required String recordedAt,
            required String date,
            Value<double?> bloodGlucoseMgDl = const Value.absent(),
            Value<double?> bloodKetonesMmolL = const Value.absent(),
            Value<double?> gkiScore = const Value.absent(),
            Value<double?> lactateMmolL = const Value.absent(),
            Value<double?> sodiumMmolL = const Value.absent(),
            Value<int?> bloodPressureSystolic = const Value.absent(),
            Value<int?> bloodPressureDiastolic = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<double?> bodyFatPercentage = const Value.absent(),
            Value<double?> muscleMassKg = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> synced = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              HealthLogsCompanion.insert(
            logId: logId,
            userId: userId,
            recordedAt: recordedAt,
            date: date,
            bloodGlucoseMgDl: bloodGlucoseMgDl,
            bloodKetonesMmolL: bloodKetonesMmolL,
            gkiScore: gkiScore,
            lactateMmolL: lactateMmolL,
            sodiumMmolL: sodiumMmolL,
            bloodPressureSystolic: bloodPressureSystolic,
            bloodPressureDiastolic: bloodPressureDiastolic,
            weightKg: weightKg,
            bodyFatPercentage: bodyFatPercentage,
            muscleMassKg: muscleMassKg,
            source: source,
            deviceId: deviceId,
            notes: notes,
            synced: synced,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HealthLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HealthLogsTable,
    HealthLog,
    $$HealthLogsTableFilterComposer,
    $$HealthLogsTableOrderingComposer,
    $$HealthLogsTableAnnotationComposer,
    $$HealthLogsTableCreateCompanionBuilder,
    $$HealthLogsTableUpdateCompanionBuilder,
    (HealthLog, BaseReferences<_$AppDatabase, $HealthLogsTable, HealthLog>),
    HealthLog,
    PrefetchHooks Function()>;
typedef $$DailySummariesTableCreateCompanionBuilder = DailySummariesCompanion
    Function({
  Value<int> summaryId,
  required int userId,
  required String date,
  Value<double> totalEnergyKcal,
  Value<double> totalProteinG,
  Value<double> totalFatG,
  Value<double> totalCarbohydrateG,
  Value<double> totalNetCarbsG,
  Value<double> totalFiberG,
  Value<double> totalSodiumMg,
  Value<double> totalPotassiumMg,
  Value<double> totalMagnesiumMg,
  Value<int> carbGoalMet,
  Value<int> proteinGoalMet,
  Value<int> fatGoalMet,
  Value<double?> avgGlucoseMgDl,
  Value<double?> avgKetonesMmolL,
  Value<double?> avgGkiScore,
  Value<double?> minGkiScore,
  Value<double?> maxGkiScore,
  Value<int> inKetosis,
  Value<int> inTherapeuticKetosis,
  Value<int?> avgHeartRateBpm,
  Value<double?> avgHrvMs,
  Value<int?> totalSteps,
  Value<double?> weightKg,
  Value<double?> weightChangeFromStartKg,
  Value<double?> avgEnergyLevel,
  Value<double?> avgMentalClarity,
  Value<double?> avgMoodRating,
  Value<int> dietEntriesCount,
  Value<int> healthLogsCount,
  Value<String> lastCalculatedAt,
  Value<int> synced,
});
typedef $$DailySummariesTableUpdateCompanionBuilder = DailySummariesCompanion
    Function({
  Value<int> summaryId,
  Value<int> userId,
  Value<String> date,
  Value<double> totalEnergyKcal,
  Value<double> totalProteinG,
  Value<double> totalFatG,
  Value<double> totalCarbohydrateG,
  Value<double> totalNetCarbsG,
  Value<double> totalFiberG,
  Value<double> totalSodiumMg,
  Value<double> totalPotassiumMg,
  Value<double> totalMagnesiumMg,
  Value<int> carbGoalMet,
  Value<int> proteinGoalMet,
  Value<int> fatGoalMet,
  Value<double?> avgGlucoseMgDl,
  Value<double?> avgKetonesMmolL,
  Value<double?> avgGkiScore,
  Value<double?> minGkiScore,
  Value<double?> maxGkiScore,
  Value<int> inKetosis,
  Value<int> inTherapeuticKetosis,
  Value<int?> avgHeartRateBpm,
  Value<double?> avgHrvMs,
  Value<int?> totalSteps,
  Value<double?> weightKg,
  Value<double?> weightChangeFromStartKg,
  Value<double?> avgEnergyLevel,
  Value<double?> avgMentalClarity,
  Value<double?> avgMoodRating,
  Value<int> dietEntriesCount,
  Value<int> healthLogsCount,
  Value<String> lastCalculatedAt,
  Value<int> synced,
});

class $$DailySummariesTableFilterComposer
    extends Composer<_$AppDatabase, $DailySummariesTable> {
  $$DailySummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get summaryId => $composableBuilder(
      column: $table.summaryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalEnergyKcal => $composableBuilder(
      column: $table.totalEnergyKcal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFatG => $composableBuilder(
      column: $table.totalFatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalNetCarbsG => $composableBuilder(
      column: $table.totalNetCarbsG,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalSodiumMg => $composableBuilder(
      column: $table.totalSodiumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalPotassiumMg => $composableBuilder(
      column: $table.totalPotassiumMg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalMagnesiumMg => $composableBuilder(
      column: $table.totalMagnesiumMg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get carbGoalMet => $composableBuilder(
      column: $table.carbGoalMet, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get proteinGoalMet => $composableBuilder(
      column: $table.proteinGoalMet,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fatGoalMet => $composableBuilder(
      column: $table.fatGoalMet, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgGlucoseMgDl => $composableBuilder(
      column: $table.avgGlucoseMgDl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgKetonesMmolL => $composableBuilder(
      column: $table.avgKetonesMmolL,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgGkiScore => $composableBuilder(
      column: $table.avgGkiScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minGkiScore => $composableBuilder(
      column: $table.minGkiScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxGkiScore => $composableBuilder(
      column: $table.maxGkiScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get inKetosis => $composableBuilder(
      column: $table.inKetosis, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get inTherapeuticKetosis => $composableBuilder(
      column: $table.inTherapeuticKetosis,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get avgHeartRateBpm => $composableBuilder(
      column: $table.avgHeartRateBpm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgHrvMs => $composableBuilder(
      column: $table.avgHrvMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalSteps => $composableBuilder(
      column: $table.totalSteps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightChangeFromStartKg => $composableBuilder(
      column: $table.weightChangeFromStartKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgEnergyLevel => $composableBuilder(
      column: $table.avgEnergyLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgMentalClarity => $composableBuilder(
      column: $table.avgMentalClarity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgMoodRating => $composableBuilder(
      column: $table.avgMoodRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dietEntriesCount => $composableBuilder(
      column: $table.dietEntriesCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get healthLogsCount => $composableBuilder(
      column: $table.healthLogsCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastCalculatedAt => $composableBuilder(
      column: $table.lastCalculatedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));
}

class $$DailySummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailySummariesTable> {
  $$DailySummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get summaryId => $composableBuilder(
      column: $table.summaryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalEnergyKcal => $composableBuilder(
      column: $table.totalEnergyKcal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFatG => $composableBuilder(
      column: $table.totalFatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalNetCarbsG => $composableBuilder(
      column: $table.totalNetCarbsG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalSodiumMg => $composableBuilder(
      column: $table.totalSodiumMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalPotassiumMg => $composableBuilder(
      column: $table.totalPotassiumMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalMagnesiumMg => $composableBuilder(
      column: $table.totalMagnesiumMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get carbGoalMet => $composableBuilder(
      column: $table.carbGoalMet, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get proteinGoalMet => $composableBuilder(
      column: $table.proteinGoalMet,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fatGoalMet => $composableBuilder(
      column: $table.fatGoalMet, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgGlucoseMgDl => $composableBuilder(
      column: $table.avgGlucoseMgDl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgKetonesMmolL => $composableBuilder(
      column: $table.avgKetonesMmolL,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgGkiScore => $composableBuilder(
      column: $table.avgGkiScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minGkiScore => $composableBuilder(
      column: $table.minGkiScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxGkiScore => $composableBuilder(
      column: $table.maxGkiScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get inKetosis => $composableBuilder(
      column: $table.inKetosis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get inTherapeuticKetosis => $composableBuilder(
      column: $table.inTherapeuticKetosis,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get avgHeartRateBpm => $composableBuilder(
      column: $table.avgHeartRateBpm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgHrvMs => $composableBuilder(
      column: $table.avgHrvMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalSteps => $composableBuilder(
      column: $table.totalSteps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightChangeFromStartKg => $composableBuilder(
      column: $table.weightChangeFromStartKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgEnergyLevel => $composableBuilder(
      column: $table.avgEnergyLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgMentalClarity => $composableBuilder(
      column: $table.avgMentalClarity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgMoodRating => $composableBuilder(
      column: $table.avgMoodRating,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dietEntriesCount => $composableBuilder(
      column: $table.dietEntriesCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get healthLogsCount => $composableBuilder(
      column: $table.healthLogsCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastCalculatedAt => $composableBuilder(
      column: $table.lastCalculatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));
}

class $$DailySummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailySummariesTable> {
  $$DailySummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get summaryId =>
      $composableBuilder(column: $table.summaryId, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get totalEnergyKcal => $composableBuilder(
      column: $table.totalEnergyKcal, builder: (column) => column);

  GeneratedColumn<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG, builder: (column) => column);

  GeneratedColumn<double> get totalFatG =>
      $composableBuilder(column: $table.totalFatG, builder: (column) => column);

  GeneratedColumn<double> get totalCarbohydrateG => $composableBuilder(
      column: $table.totalCarbohydrateG, builder: (column) => column);

  GeneratedColumn<double> get totalNetCarbsG => $composableBuilder(
      column: $table.totalNetCarbsG, builder: (column) => column);

  GeneratedColumn<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => column);

  GeneratedColumn<double> get totalSodiumMg => $composableBuilder(
      column: $table.totalSodiumMg, builder: (column) => column);

  GeneratedColumn<double> get totalPotassiumMg => $composableBuilder(
      column: $table.totalPotassiumMg, builder: (column) => column);

  GeneratedColumn<double> get totalMagnesiumMg => $composableBuilder(
      column: $table.totalMagnesiumMg, builder: (column) => column);

  GeneratedColumn<int> get carbGoalMet => $composableBuilder(
      column: $table.carbGoalMet, builder: (column) => column);

  GeneratedColumn<int> get proteinGoalMet => $composableBuilder(
      column: $table.proteinGoalMet, builder: (column) => column);

  GeneratedColumn<int> get fatGoalMet => $composableBuilder(
      column: $table.fatGoalMet, builder: (column) => column);

  GeneratedColumn<double> get avgGlucoseMgDl => $composableBuilder(
      column: $table.avgGlucoseMgDl, builder: (column) => column);

  GeneratedColumn<double> get avgKetonesMmolL => $composableBuilder(
      column: $table.avgKetonesMmolL, builder: (column) => column);

  GeneratedColumn<double> get avgGkiScore => $composableBuilder(
      column: $table.avgGkiScore, builder: (column) => column);

  GeneratedColumn<double> get minGkiScore => $composableBuilder(
      column: $table.minGkiScore, builder: (column) => column);

  GeneratedColumn<double> get maxGkiScore => $composableBuilder(
      column: $table.maxGkiScore, builder: (column) => column);

  GeneratedColumn<int> get inKetosis =>
      $composableBuilder(column: $table.inKetosis, builder: (column) => column);

  GeneratedColumn<int> get inTherapeuticKetosis => $composableBuilder(
      column: $table.inTherapeuticKetosis, builder: (column) => column);

  GeneratedColumn<int> get avgHeartRateBpm => $composableBuilder(
      column: $table.avgHeartRateBpm, builder: (column) => column);

  GeneratedColumn<double> get avgHrvMs =>
      $composableBuilder(column: $table.avgHrvMs, builder: (column) => column);

  GeneratedColumn<int> get totalSteps => $composableBuilder(
      column: $table.totalSteps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get weightChangeFromStartKg => $composableBuilder(
      column: $table.weightChangeFromStartKg, builder: (column) => column);

  GeneratedColumn<double> get avgEnergyLevel => $composableBuilder(
      column: $table.avgEnergyLevel, builder: (column) => column);

  GeneratedColumn<double> get avgMentalClarity => $composableBuilder(
      column: $table.avgMentalClarity, builder: (column) => column);

  GeneratedColumn<double> get avgMoodRating => $composableBuilder(
      column: $table.avgMoodRating, builder: (column) => column);

  GeneratedColumn<int> get dietEntriesCount => $composableBuilder(
      column: $table.dietEntriesCount, builder: (column) => column);

  GeneratedColumn<int> get healthLogsCount => $composableBuilder(
      column: $table.healthLogsCount, builder: (column) => column);

  GeneratedColumn<String> get lastCalculatedAt => $composableBuilder(
      column: $table.lastCalculatedAt, builder: (column) => column);

  GeneratedColumn<int> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$DailySummariesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailySummariesTable,
    DailySummary,
    $$DailySummariesTableFilterComposer,
    $$DailySummariesTableOrderingComposer,
    $$DailySummariesTableAnnotationComposer,
    $$DailySummariesTableCreateCompanionBuilder,
    $$DailySummariesTableUpdateCompanionBuilder,
    (
      DailySummary,
      BaseReferences<_$AppDatabase, $DailySummariesTable, DailySummary>
    ),
    DailySummary,
    PrefetchHooks Function()> {
  $$DailySummariesTableTableManager(
      _$AppDatabase db, $DailySummariesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailySummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailySummariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailySummariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> summaryId = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double> totalEnergyKcal = const Value.absent(),
            Value<double> totalProteinG = const Value.absent(),
            Value<double> totalFatG = const Value.absent(),
            Value<double> totalCarbohydrateG = const Value.absent(),
            Value<double> totalNetCarbsG = const Value.absent(),
            Value<double> totalFiberG = const Value.absent(),
            Value<double> totalSodiumMg = const Value.absent(),
            Value<double> totalPotassiumMg = const Value.absent(),
            Value<double> totalMagnesiumMg = const Value.absent(),
            Value<int> carbGoalMet = const Value.absent(),
            Value<int> proteinGoalMet = const Value.absent(),
            Value<int> fatGoalMet = const Value.absent(),
            Value<double?> avgGlucoseMgDl = const Value.absent(),
            Value<double?> avgKetonesMmolL = const Value.absent(),
            Value<double?> avgGkiScore = const Value.absent(),
            Value<double?> minGkiScore = const Value.absent(),
            Value<double?> maxGkiScore = const Value.absent(),
            Value<int> inKetosis = const Value.absent(),
            Value<int> inTherapeuticKetosis = const Value.absent(),
            Value<int?> avgHeartRateBpm = const Value.absent(),
            Value<double?> avgHrvMs = const Value.absent(),
            Value<int?> totalSteps = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<double?> weightChangeFromStartKg = const Value.absent(),
            Value<double?> avgEnergyLevel = const Value.absent(),
            Value<double?> avgMentalClarity = const Value.absent(),
            Value<double?> avgMoodRating = const Value.absent(),
            Value<int> dietEntriesCount = const Value.absent(),
            Value<int> healthLogsCount = const Value.absent(),
            Value<String> lastCalculatedAt = const Value.absent(),
            Value<int> synced = const Value.absent(),
          }) =>
              DailySummariesCompanion(
            summaryId: summaryId,
            userId: userId,
            date: date,
            totalEnergyKcal: totalEnergyKcal,
            totalProteinG: totalProteinG,
            totalFatG: totalFatG,
            totalCarbohydrateG: totalCarbohydrateG,
            totalNetCarbsG: totalNetCarbsG,
            totalFiberG: totalFiberG,
            totalSodiumMg: totalSodiumMg,
            totalPotassiumMg: totalPotassiumMg,
            totalMagnesiumMg: totalMagnesiumMg,
            carbGoalMet: carbGoalMet,
            proteinGoalMet: proteinGoalMet,
            fatGoalMet: fatGoalMet,
            avgGlucoseMgDl: avgGlucoseMgDl,
            avgKetonesMmolL: avgKetonesMmolL,
            avgGkiScore: avgGkiScore,
            minGkiScore: minGkiScore,
            maxGkiScore: maxGkiScore,
            inKetosis: inKetosis,
            inTherapeuticKetosis: inTherapeuticKetosis,
            avgHeartRateBpm: avgHeartRateBpm,
            avgHrvMs: avgHrvMs,
            totalSteps: totalSteps,
            weightKg: weightKg,
            weightChangeFromStartKg: weightChangeFromStartKg,
            avgEnergyLevel: avgEnergyLevel,
            avgMentalClarity: avgMentalClarity,
            avgMoodRating: avgMoodRating,
            dietEntriesCount: dietEntriesCount,
            healthLogsCount: healthLogsCount,
            lastCalculatedAt: lastCalculatedAt,
            synced: synced,
          ),
          createCompanionCallback: ({
            Value<int> summaryId = const Value.absent(),
            required int userId,
            required String date,
            Value<double> totalEnergyKcal = const Value.absent(),
            Value<double> totalProteinG = const Value.absent(),
            Value<double> totalFatG = const Value.absent(),
            Value<double> totalCarbohydrateG = const Value.absent(),
            Value<double> totalNetCarbsG = const Value.absent(),
            Value<double> totalFiberG = const Value.absent(),
            Value<double> totalSodiumMg = const Value.absent(),
            Value<double> totalPotassiumMg = const Value.absent(),
            Value<double> totalMagnesiumMg = const Value.absent(),
            Value<int> carbGoalMet = const Value.absent(),
            Value<int> proteinGoalMet = const Value.absent(),
            Value<int> fatGoalMet = const Value.absent(),
            Value<double?> avgGlucoseMgDl = const Value.absent(),
            Value<double?> avgKetonesMmolL = const Value.absent(),
            Value<double?> avgGkiScore = const Value.absent(),
            Value<double?> minGkiScore = const Value.absent(),
            Value<double?> maxGkiScore = const Value.absent(),
            Value<int> inKetosis = const Value.absent(),
            Value<int> inTherapeuticKetosis = const Value.absent(),
            Value<int?> avgHeartRateBpm = const Value.absent(),
            Value<double?> avgHrvMs = const Value.absent(),
            Value<int?> totalSteps = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<double?> weightChangeFromStartKg = const Value.absent(),
            Value<double?> avgEnergyLevel = const Value.absent(),
            Value<double?> avgMentalClarity = const Value.absent(),
            Value<double?> avgMoodRating = const Value.absent(),
            Value<int> dietEntriesCount = const Value.absent(),
            Value<int> healthLogsCount = const Value.absent(),
            Value<String> lastCalculatedAt = const Value.absent(),
            Value<int> synced = const Value.absent(),
          }) =>
              DailySummariesCompanion.insert(
            summaryId: summaryId,
            userId: userId,
            date: date,
            totalEnergyKcal: totalEnergyKcal,
            totalProteinG: totalProteinG,
            totalFatG: totalFatG,
            totalCarbohydrateG: totalCarbohydrateG,
            totalNetCarbsG: totalNetCarbsG,
            totalFiberG: totalFiberG,
            totalSodiumMg: totalSodiumMg,
            totalPotassiumMg: totalPotassiumMg,
            totalMagnesiumMg: totalMagnesiumMg,
            carbGoalMet: carbGoalMet,
            proteinGoalMet: proteinGoalMet,
            fatGoalMet: fatGoalMet,
            avgGlucoseMgDl: avgGlucoseMgDl,
            avgKetonesMmolL: avgKetonesMmolL,
            avgGkiScore: avgGkiScore,
            minGkiScore: minGkiScore,
            maxGkiScore: maxGkiScore,
            inKetosis: inKetosis,
            inTherapeuticKetosis: inTherapeuticKetosis,
            avgHeartRateBpm: avgHeartRateBpm,
            avgHrvMs: avgHrvMs,
            totalSteps: totalSteps,
            weightKg: weightKg,
            weightChangeFromStartKg: weightChangeFromStartKg,
            avgEnergyLevel: avgEnergyLevel,
            avgMentalClarity: avgMentalClarity,
            avgMoodRating: avgMoodRating,
            dietEntriesCount: dietEntriesCount,
            healthLogsCount: healthLogsCount,
            lastCalculatedAt: lastCalculatedAt,
            synced: synced,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailySummariesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailySummariesTable,
    DailySummary,
    $$DailySummariesTableFilterComposer,
    $$DailySummariesTableOrderingComposer,
    $$DailySummariesTableAnnotationComposer,
    $$DailySummariesTableCreateCompanionBuilder,
    $$DailySummariesTableUpdateCompanionBuilder,
    (
      DailySummary,
      BaseReferences<_$AppDatabase, $DailySummariesTable, DailySummary>
    ),
    DailySummary,
    PrefetchHooks Function()>;
typedef $$VitalsTableCreateCompanionBuilder = VitalsCompanion Function({
  Value<int> vitalId,
  required int userId,
  required String recordedAt,
  required String date,
  Value<int?> heartRateBpm,
  Value<double?> hrvMs,
  Value<int?> restingHeartRateBpm,
  Value<double?> bodyTemperatureCelsius,
  Value<double?> skinTemperatureCelsius,
  Value<double?> sleepDurationHours,
  Value<double?> deepSleepHours,
  Value<double?> remSleepHours,
  Value<double?> lightSleepHours,
  Value<int?> sleepScore,
  Value<int?> stepsCount,
  Value<double?> activeCaloriesKcal,
  Value<double?> totalCaloriesKcal,
  Value<double?> distanceKm,
  Value<int?> respiratoryRateBpm,
  Value<double?> spo2Percentage,
  Value<String> source,
  Value<String?> deviceId,
  Value<int> synced,
  Value<String> createdAt,
});
typedef $$VitalsTableUpdateCompanionBuilder = VitalsCompanion Function({
  Value<int> vitalId,
  Value<int> userId,
  Value<String> recordedAt,
  Value<String> date,
  Value<int?> heartRateBpm,
  Value<double?> hrvMs,
  Value<int?> restingHeartRateBpm,
  Value<double?> bodyTemperatureCelsius,
  Value<double?> skinTemperatureCelsius,
  Value<double?> sleepDurationHours,
  Value<double?> deepSleepHours,
  Value<double?> remSleepHours,
  Value<double?> lightSleepHours,
  Value<int?> sleepScore,
  Value<int?> stepsCount,
  Value<double?> activeCaloriesKcal,
  Value<double?> totalCaloriesKcal,
  Value<double?> distanceKm,
  Value<int?> respiratoryRateBpm,
  Value<double?> spo2Percentage,
  Value<String> source,
  Value<String?> deviceId,
  Value<int> synced,
  Value<String> createdAt,
});

class $$VitalsTableFilterComposer
    extends Composer<_$AppDatabase, $VitalsTable> {
  $$VitalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get vitalId => $composableBuilder(
      column: $table.vitalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get heartRateBpm => $composableBuilder(
      column: $table.heartRateBpm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hrvMs => $composableBuilder(
      column: $table.hrvMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restingHeartRateBpm => $composableBuilder(
      column: $table.restingHeartRateBpm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bodyTemperatureCelsius => $composableBuilder(
      column: $table.bodyTemperatureCelsius,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get skinTemperatureCelsius => $composableBuilder(
      column: $table.skinTemperatureCelsius,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sleepDurationHours => $composableBuilder(
      column: $table.sleepDurationHours,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get deepSleepHours => $composableBuilder(
      column: $table.deepSleepHours,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get remSleepHours => $composableBuilder(
      column: $table.remSleepHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lightSleepHours => $composableBuilder(
      column: $table.lightSleepHours,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepScore => $composableBuilder(
      column: $table.sleepScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stepsCount => $composableBuilder(
      column: $table.stepsCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get activeCaloriesKcal => $composableBuilder(
      column: $table.activeCaloriesKcal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCaloriesKcal => $composableBuilder(
      column: $table.totalCaloriesKcal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get respiratoryRateBpm => $composableBuilder(
      column: $table.respiratoryRateBpm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get spo2Percentage => $composableBuilder(
      column: $table.spo2Percentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$VitalsTableOrderingComposer
    extends Composer<_$AppDatabase, $VitalsTable> {
  $$VitalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get vitalId => $composableBuilder(
      column: $table.vitalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get heartRateBpm => $composableBuilder(
      column: $table.heartRateBpm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hrvMs => $composableBuilder(
      column: $table.hrvMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restingHeartRateBpm => $composableBuilder(
      column: $table.restingHeartRateBpm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bodyTemperatureCelsius => $composableBuilder(
      column: $table.bodyTemperatureCelsius,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get skinTemperatureCelsius => $composableBuilder(
      column: $table.skinTemperatureCelsius,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sleepDurationHours => $composableBuilder(
      column: $table.sleepDurationHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get deepSleepHours => $composableBuilder(
      column: $table.deepSleepHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get remSleepHours => $composableBuilder(
      column: $table.remSleepHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lightSleepHours => $composableBuilder(
      column: $table.lightSleepHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepScore => $composableBuilder(
      column: $table.sleepScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stepsCount => $composableBuilder(
      column: $table.stepsCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get activeCaloriesKcal => $composableBuilder(
      column: $table.activeCaloriesKcal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCaloriesKcal => $composableBuilder(
      column: $table.totalCaloriesKcal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get respiratoryRateBpm => $composableBuilder(
      column: $table.respiratoryRateBpm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get spo2Percentage => $composableBuilder(
      column: $table.spo2Percentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$VitalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VitalsTable> {
  $$VitalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get vitalId =>
      $composableBuilder(column: $table.vitalId, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get heartRateBpm => $composableBuilder(
      column: $table.heartRateBpm, builder: (column) => column);

  GeneratedColumn<double> get hrvMs =>
      $composableBuilder(column: $table.hrvMs, builder: (column) => column);

  GeneratedColumn<int> get restingHeartRateBpm => $composableBuilder(
      column: $table.restingHeartRateBpm, builder: (column) => column);

  GeneratedColumn<double> get bodyTemperatureCelsius => $composableBuilder(
      column: $table.bodyTemperatureCelsius, builder: (column) => column);

  GeneratedColumn<double> get skinTemperatureCelsius => $composableBuilder(
      column: $table.skinTemperatureCelsius, builder: (column) => column);

  GeneratedColumn<double> get sleepDurationHours => $composableBuilder(
      column: $table.sleepDurationHours, builder: (column) => column);

  GeneratedColumn<double> get deepSleepHours => $composableBuilder(
      column: $table.deepSleepHours, builder: (column) => column);

  GeneratedColumn<double> get remSleepHours => $composableBuilder(
      column: $table.remSleepHours, builder: (column) => column);

  GeneratedColumn<double> get lightSleepHours => $composableBuilder(
      column: $table.lightSleepHours, builder: (column) => column);

  GeneratedColumn<int> get sleepScore => $composableBuilder(
      column: $table.sleepScore, builder: (column) => column);

  GeneratedColumn<int> get stepsCount => $composableBuilder(
      column: $table.stepsCount, builder: (column) => column);

  GeneratedColumn<double> get activeCaloriesKcal => $composableBuilder(
      column: $table.activeCaloriesKcal, builder: (column) => column);

  GeneratedColumn<double> get totalCaloriesKcal => $composableBuilder(
      column: $table.totalCaloriesKcal, builder: (column) => column);

  GeneratedColumn<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => column);

  GeneratedColumn<int> get respiratoryRateBpm => $composableBuilder(
      column: $table.respiratoryRateBpm, builder: (column) => column);

  GeneratedColumn<double> get spo2Percentage => $composableBuilder(
      column: $table.spo2Percentage, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$VitalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VitalsTable,
    Vital,
    $$VitalsTableFilterComposer,
    $$VitalsTableOrderingComposer,
    $$VitalsTableAnnotationComposer,
    $$VitalsTableCreateCompanionBuilder,
    $$VitalsTableUpdateCompanionBuilder,
    (Vital, BaseReferences<_$AppDatabase, $VitalsTable, Vital>),
    Vital,
    PrefetchHooks Function()> {
  $$VitalsTableTableManager(_$AppDatabase db, $VitalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VitalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VitalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VitalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> vitalId = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> recordedAt = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int?> heartRateBpm = const Value.absent(),
            Value<double?> hrvMs = const Value.absent(),
            Value<int?> restingHeartRateBpm = const Value.absent(),
            Value<double?> bodyTemperatureCelsius = const Value.absent(),
            Value<double?> skinTemperatureCelsius = const Value.absent(),
            Value<double?> sleepDurationHours = const Value.absent(),
            Value<double?> deepSleepHours = const Value.absent(),
            Value<double?> remSleepHours = const Value.absent(),
            Value<double?> lightSleepHours = const Value.absent(),
            Value<int?> sleepScore = const Value.absent(),
            Value<int?> stepsCount = const Value.absent(),
            Value<double?> activeCaloriesKcal = const Value.absent(),
            Value<double?> totalCaloriesKcal = const Value.absent(),
            Value<double?> distanceKm = const Value.absent(),
            Value<int?> respiratoryRateBpm = const Value.absent(),
            Value<double?> spo2Percentage = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int> synced = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              VitalsCompanion(
            vitalId: vitalId,
            userId: userId,
            recordedAt: recordedAt,
            date: date,
            heartRateBpm: heartRateBpm,
            hrvMs: hrvMs,
            restingHeartRateBpm: restingHeartRateBpm,
            bodyTemperatureCelsius: bodyTemperatureCelsius,
            skinTemperatureCelsius: skinTemperatureCelsius,
            sleepDurationHours: sleepDurationHours,
            deepSleepHours: deepSleepHours,
            remSleepHours: remSleepHours,
            lightSleepHours: lightSleepHours,
            sleepScore: sleepScore,
            stepsCount: stepsCount,
            activeCaloriesKcal: activeCaloriesKcal,
            totalCaloriesKcal: totalCaloriesKcal,
            distanceKm: distanceKm,
            respiratoryRateBpm: respiratoryRateBpm,
            spo2Percentage: spo2Percentage,
            source: source,
            deviceId: deviceId,
            synced: synced,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> vitalId = const Value.absent(),
            required int userId,
            required String recordedAt,
            required String date,
            Value<int?> heartRateBpm = const Value.absent(),
            Value<double?> hrvMs = const Value.absent(),
            Value<int?> restingHeartRateBpm = const Value.absent(),
            Value<double?> bodyTemperatureCelsius = const Value.absent(),
            Value<double?> skinTemperatureCelsius = const Value.absent(),
            Value<double?> sleepDurationHours = const Value.absent(),
            Value<double?> deepSleepHours = const Value.absent(),
            Value<double?> remSleepHours = const Value.absent(),
            Value<double?> lightSleepHours = const Value.absent(),
            Value<int?> sleepScore = const Value.absent(),
            Value<int?> stepsCount = const Value.absent(),
            Value<double?> activeCaloriesKcal = const Value.absent(),
            Value<double?> totalCaloriesKcal = const Value.absent(),
            Value<double?> distanceKm = const Value.absent(),
            Value<int?> respiratoryRateBpm = const Value.absent(),
            Value<double?> spo2Percentage = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int> synced = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              VitalsCompanion.insert(
            vitalId: vitalId,
            userId: userId,
            recordedAt: recordedAt,
            date: date,
            heartRateBpm: heartRateBpm,
            hrvMs: hrvMs,
            restingHeartRateBpm: restingHeartRateBpm,
            bodyTemperatureCelsius: bodyTemperatureCelsius,
            skinTemperatureCelsius: skinTemperatureCelsius,
            sleepDurationHours: sleepDurationHours,
            deepSleepHours: deepSleepHours,
            remSleepHours: remSleepHours,
            lightSleepHours: lightSleepHours,
            sleepScore: sleepScore,
            stepsCount: stepsCount,
            activeCaloriesKcal: activeCaloriesKcal,
            totalCaloriesKcal: totalCaloriesKcal,
            distanceKm: distanceKm,
            respiratoryRateBpm: respiratoryRateBpm,
            spo2Percentage: spo2Percentage,
            source: source,
            deviceId: deviceId,
            synced: synced,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VitalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VitalsTable,
    Vital,
    $$VitalsTableFilterComposer,
    $$VitalsTableOrderingComposer,
    $$VitalsTableAnnotationComposer,
    $$VitalsTableCreateCompanionBuilder,
    $$VitalsTableUpdateCompanionBuilder,
    (Vital, BaseReferences<_$AppDatabase, $VitalsTable, Vital>),
    Vital,
    PrefetchHooks Function()>;
typedef $$SymptomsTableCreateCompanionBuilder = SymptomsCompanion Function({
  Value<int> symptomId,
  required int userId,
  required String recordedAt,
  required String date,
  Value<int?> headacheSeverity,
  Value<int?> fatigueSeverity,
  Value<int?> nauseaSeverity,
  Value<int?> dizzinessSeverity,
  Value<int?> brainFogSeverity,
  Value<int?> irritabilitySeverity,
  Value<int?> muscleCrampsSeverity,
  Value<int?> energyLevel,
  Value<int?> mentalClarity,
  Value<int?> moodRating,
  Value<int?> hungerLevel,
  Value<int?> satietyLevel,
  Value<int?> bloatingSeverity,
  Value<int?> digestionQuality,
  Value<String?> customSymptoms,
  Value<String?> additionalNotes,
  Value<int> synced,
  Value<String> createdAt,
});
typedef $$SymptomsTableUpdateCompanionBuilder = SymptomsCompanion Function({
  Value<int> symptomId,
  Value<int> userId,
  Value<String> recordedAt,
  Value<String> date,
  Value<int?> headacheSeverity,
  Value<int?> fatigueSeverity,
  Value<int?> nauseaSeverity,
  Value<int?> dizzinessSeverity,
  Value<int?> brainFogSeverity,
  Value<int?> irritabilitySeverity,
  Value<int?> muscleCrampsSeverity,
  Value<int?> energyLevel,
  Value<int?> mentalClarity,
  Value<int?> moodRating,
  Value<int?> hungerLevel,
  Value<int?> satietyLevel,
  Value<int?> bloatingSeverity,
  Value<int?> digestionQuality,
  Value<String?> customSymptoms,
  Value<String?> additionalNotes,
  Value<int> synced,
  Value<String> createdAt,
});

class $$SymptomsTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get symptomId => $composableBuilder(
      column: $table.symptomId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get headacheSeverity => $composableBuilder(
      column: $table.headacheSeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fatigueSeverity => $composableBuilder(
      column: $table.fatigueSeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nauseaSeverity => $composableBuilder(
      column: $table.nauseaSeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dizzinessSeverity => $composableBuilder(
      column: $table.dizzinessSeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get brainFogSeverity => $composableBuilder(
      column: $table.brainFogSeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get irritabilitySeverity => $composableBuilder(
      column: $table.irritabilitySeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get muscleCrampsSeverity => $composableBuilder(
      column: $table.muscleCrampsSeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mentalClarity => $composableBuilder(
      column: $table.mentalClarity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get moodRating => $composableBuilder(
      column: $table.moodRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hungerLevel => $composableBuilder(
      column: $table.hungerLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get satietyLevel => $composableBuilder(
      column: $table.satietyLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bloatingSeverity => $composableBuilder(
      column: $table.bloatingSeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get digestionQuality => $composableBuilder(
      column: $table.digestionQuality,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customSymptoms => $composableBuilder(
      column: $table.customSymptoms,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get additionalNotes => $composableBuilder(
      column: $table.additionalNotes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SymptomsTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get symptomId => $composableBuilder(
      column: $table.symptomId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get headacheSeverity => $composableBuilder(
      column: $table.headacheSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fatigueSeverity => $composableBuilder(
      column: $table.fatigueSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nauseaSeverity => $composableBuilder(
      column: $table.nauseaSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dizzinessSeverity => $composableBuilder(
      column: $table.dizzinessSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get brainFogSeverity => $composableBuilder(
      column: $table.brainFogSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get irritabilitySeverity => $composableBuilder(
      column: $table.irritabilitySeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get muscleCrampsSeverity => $composableBuilder(
      column: $table.muscleCrampsSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mentalClarity => $composableBuilder(
      column: $table.mentalClarity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get moodRating => $composableBuilder(
      column: $table.moodRating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hungerLevel => $composableBuilder(
      column: $table.hungerLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get satietyLevel => $composableBuilder(
      column: $table.satietyLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bloatingSeverity => $composableBuilder(
      column: $table.bloatingSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get digestionQuality => $composableBuilder(
      column: $table.digestionQuality,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customSymptoms => $composableBuilder(
      column: $table.customSymptoms,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get additionalNotes => $composableBuilder(
      column: $table.additionalNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SymptomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get symptomId =>
      $composableBuilder(column: $table.symptomId, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get headacheSeverity => $composableBuilder(
      column: $table.headacheSeverity, builder: (column) => column);

  GeneratedColumn<int> get fatigueSeverity => $composableBuilder(
      column: $table.fatigueSeverity, builder: (column) => column);

  GeneratedColumn<int> get nauseaSeverity => $composableBuilder(
      column: $table.nauseaSeverity, builder: (column) => column);

  GeneratedColumn<int> get dizzinessSeverity => $composableBuilder(
      column: $table.dizzinessSeverity, builder: (column) => column);

  GeneratedColumn<int> get brainFogSeverity => $composableBuilder(
      column: $table.brainFogSeverity, builder: (column) => column);

  GeneratedColumn<int> get irritabilitySeverity => $composableBuilder(
      column: $table.irritabilitySeverity, builder: (column) => column);

  GeneratedColumn<int> get muscleCrampsSeverity => $composableBuilder(
      column: $table.muscleCrampsSeverity, builder: (column) => column);

  GeneratedColumn<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => column);

  GeneratedColumn<int> get mentalClarity => $composableBuilder(
      column: $table.mentalClarity, builder: (column) => column);

  GeneratedColumn<int> get moodRating => $composableBuilder(
      column: $table.moodRating, builder: (column) => column);

  GeneratedColumn<int> get hungerLevel => $composableBuilder(
      column: $table.hungerLevel, builder: (column) => column);

  GeneratedColumn<int> get satietyLevel => $composableBuilder(
      column: $table.satietyLevel, builder: (column) => column);

  GeneratedColumn<int> get bloatingSeverity => $composableBuilder(
      column: $table.bloatingSeverity, builder: (column) => column);

  GeneratedColumn<int> get digestionQuality => $composableBuilder(
      column: $table.digestionQuality, builder: (column) => column);

  GeneratedColumn<String> get customSymptoms => $composableBuilder(
      column: $table.customSymptoms, builder: (column) => column);

  GeneratedColumn<String> get additionalNotes => $composableBuilder(
      column: $table.additionalNotes, builder: (column) => column);

  GeneratedColumn<int> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SymptomsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomsTable,
    Symptom,
    $$SymptomsTableFilterComposer,
    $$SymptomsTableOrderingComposer,
    $$SymptomsTableAnnotationComposer,
    $$SymptomsTableCreateCompanionBuilder,
    $$SymptomsTableUpdateCompanionBuilder,
    (Symptom, BaseReferences<_$AppDatabase, $SymptomsTable, Symptom>),
    Symptom,
    PrefetchHooks Function()> {
  $$SymptomsTableTableManager(_$AppDatabase db, $SymptomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> symptomId = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> recordedAt = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int?> headacheSeverity = const Value.absent(),
            Value<int?> fatigueSeverity = const Value.absent(),
            Value<int?> nauseaSeverity = const Value.absent(),
            Value<int?> dizzinessSeverity = const Value.absent(),
            Value<int?> brainFogSeverity = const Value.absent(),
            Value<int?> irritabilitySeverity = const Value.absent(),
            Value<int?> muscleCrampsSeverity = const Value.absent(),
            Value<int?> energyLevel = const Value.absent(),
            Value<int?> mentalClarity = const Value.absent(),
            Value<int?> moodRating = const Value.absent(),
            Value<int?> hungerLevel = const Value.absent(),
            Value<int?> satietyLevel = const Value.absent(),
            Value<int?> bloatingSeverity = const Value.absent(),
            Value<int?> digestionQuality = const Value.absent(),
            Value<String?> customSymptoms = const Value.absent(),
            Value<String?> additionalNotes = const Value.absent(),
            Value<int> synced = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              SymptomsCompanion(
            symptomId: symptomId,
            userId: userId,
            recordedAt: recordedAt,
            date: date,
            headacheSeverity: headacheSeverity,
            fatigueSeverity: fatigueSeverity,
            nauseaSeverity: nauseaSeverity,
            dizzinessSeverity: dizzinessSeverity,
            brainFogSeverity: brainFogSeverity,
            irritabilitySeverity: irritabilitySeverity,
            muscleCrampsSeverity: muscleCrampsSeverity,
            energyLevel: energyLevel,
            mentalClarity: mentalClarity,
            moodRating: moodRating,
            hungerLevel: hungerLevel,
            satietyLevel: satietyLevel,
            bloatingSeverity: bloatingSeverity,
            digestionQuality: digestionQuality,
            customSymptoms: customSymptoms,
            additionalNotes: additionalNotes,
            synced: synced,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> symptomId = const Value.absent(),
            required int userId,
            required String recordedAt,
            required String date,
            Value<int?> headacheSeverity = const Value.absent(),
            Value<int?> fatigueSeverity = const Value.absent(),
            Value<int?> nauseaSeverity = const Value.absent(),
            Value<int?> dizzinessSeverity = const Value.absent(),
            Value<int?> brainFogSeverity = const Value.absent(),
            Value<int?> irritabilitySeverity = const Value.absent(),
            Value<int?> muscleCrampsSeverity = const Value.absent(),
            Value<int?> energyLevel = const Value.absent(),
            Value<int?> mentalClarity = const Value.absent(),
            Value<int?> moodRating = const Value.absent(),
            Value<int?> hungerLevel = const Value.absent(),
            Value<int?> satietyLevel = const Value.absent(),
            Value<int?> bloatingSeverity = const Value.absent(),
            Value<int?> digestionQuality = const Value.absent(),
            Value<String?> customSymptoms = const Value.absent(),
            Value<String?> additionalNotes = const Value.absent(),
            Value<int> synced = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              SymptomsCompanion.insert(
            symptomId: symptomId,
            userId: userId,
            recordedAt: recordedAt,
            date: date,
            headacheSeverity: headacheSeverity,
            fatigueSeverity: fatigueSeverity,
            nauseaSeverity: nauseaSeverity,
            dizzinessSeverity: dizzinessSeverity,
            brainFogSeverity: brainFogSeverity,
            irritabilitySeverity: irritabilitySeverity,
            muscleCrampsSeverity: muscleCrampsSeverity,
            energyLevel: energyLevel,
            mentalClarity: mentalClarity,
            moodRating: moodRating,
            hungerLevel: hungerLevel,
            satietyLevel: satietyLevel,
            bloatingSeverity: bloatingSeverity,
            digestionQuality: digestionQuality,
            customSymptoms: customSymptoms,
            additionalNotes: additionalNotes,
            synced: synced,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SymptomsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomsTable,
    Symptom,
    $$SymptomsTableFilterComposer,
    $$SymptomsTableOrderingComposer,
    $$SymptomsTableAnnotationComposer,
    $$SymptomsTableCreateCompanionBuilder,
    $$SymptomsTableUpdateCompanionBuilder,
    (Symptom, BaseReferences<_$AppDatabase, $SymptomsTable, Symptom>),
    Symptom,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$FoodsTableTableManager get foods =>
      $$FoodsTableTableManager(_db, _db.foods);
  $$FoodPortionsTableTableManager get foodPortions =>
      $$FoodPortionsTableTableManager(_db, _db.foodPortions);
  $$DietEntriesTableTableManager get dietEntries =>
      $$DietEntriesTableTableManager(_db, _db.dietEntries);
  $$HealthLogsTableTableManager get healthLogs =>
      $$HealthLogsTableTableManager(_db, _db.healthLogs);
  $$DailySummariesTableTableManager get dailySummaries =>
      $$DailySummariesTableTableManager(_db, _db.dailySummaries);
  $$VitalsTableTableManager get vitals =>
      $$VitalsTableTableManager(_db, _db.vitals);
  $$SymptomsTableTableManager get symptoms =>
      $$SymptomsTableTableManager(_db, _db.symptoms);
}
