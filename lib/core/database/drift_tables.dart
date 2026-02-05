import 'package:drift/drift.dart';

/// User table definition for Drift
class Users extends Table {
  IntColumn get userId => integer().autoIncrement()();
  TextColumn get email => text().withLength(min: 1, max: 255)();
  TextColumn get passwordHash => text()();
  IntColumn get emailVerified => integer().withDefault(const Constant(0))();
  
  TextColumn get fullName => text().nullable()();
  TextColumn get dateOfBirth => text().nullable()();
  TextColumn get gender => text().nullable()();
  
  RealColumn get heightCm => real().nullable()();
  RealColumn get initialWeightKg => real().nullable()();
  
  RealColumn get targetNetCarbs => real().withDefault(const Constant(20.0))();
  RealColumn get targetProtein => real().nullable()();
  RealColumn get targetFat => real().nullable()();
  RealColumn get targetCalories => real().nullable()();
  TextColumn get ketoStartDate => text().nullable()();
  
  TextColumn get medicalConditions => text().nullable()();
  TextColumn get goals => text().nullable()();
  TextColumn get iotDevices => text().nullable()();
  
  IntColumn get foodCreationCount => integer().withDefault(const Constant(0))();
  TextColumn get foodCreationWindowStart => text().nullable()();
  IntColumn get maxFoodsPerWindow => integer().withDefault(const Constant(50))();
  IntColumn get windowDurationDays => integer().withDefault(const Constant(21))();
  
  IntColumn get researchConsent => integer().withDefault(const Constant(0))();
  IntColumn get dataSharingConsent => integer().withDefault(const Constant(0))();
  TextColumn get anonymousId => text().nullable().unique()();
  
  TextColumn get createdAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
  TextColumn get updatedAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
  TextColumn get lastLogin => text().nullable()();
}

/// Food table definition for Drift
class Foods extends Table {
  IntColumn get foodId => integer().autoIncrement()();
  TextColumn get keylist => text().nullable().unique()();
  TextColumn get foodDescription => text()();
  
  TextColumn get source => text().withDefault(const Constant('ncc'))();
  IntColumn get createdByUserId => integer().nullable()();
  IntColumn get isVerified => integer().withDefault(const Constant(0))();
  IntColumn get isKetoFriendly => integer().nullable()();
  
  RealColumn get energyKcal => real()();
  RealColumn get totalProteinG => real()();
  RealColumn get totalFatG => real()();
  RealColumn get totalCarbohydrateG => real()();
  
  RealColumn get dietaryFiberG => real().withDefault(const Constant(0))();
  RealColumn get sugarG => real().withDefault(const Constant(0))();
  RealColumn get addedSugarG => real().withDefault(const Constant(0))();
  RealColumn get netCarbsG => real().nullable()();
  
  RealColumn get saturatedFatG => real().nullable()();
  RealColumn get monounsaturatedFatG => real().nullable()();
  RealColumn get polyunsaturatedFatG => real().nullable()();
  RealColumn get transFatG => real().nullable()();
  RealColumn get cholesterolMg => real().nullable()();
  
  RealColumn get sodiumMg => real().nullable()();
  RealColumn get potassiumMg => real().nullable()();
  RealColumn get magnesiumMg => real().nullable()();
  RealColumn get calciumMg => real().nullable()();
  
  IntColumn get glycemicIndex => integer().nullable()();
  RealColumn get glycemicLoad => real().nullable()();
  
  TextColumn get vitamins => text().nullable()();
  TextColumn get minerals => text().nullable()();
  
  TextColumn get foodPhotoUrl => text().nullable()();
  TextColumn get barcode => text().nullable()();
  
  TextColumn get createdAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
  TextColumn get updatedAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
}

/// Diet Entries table definition for Drift
class DietEntries extends Table {
  IntColumn get entryId => integer().autoIncrement()();
  IntColumn get userId => integer()();
  IntColumn get foodId => integer()();
  
  TextColumn get recordedAt => text()();
  TextColumn get date => text()();
  
  IntColumn get portionId => integer().nullable()();
  RealColumn get customPortionGrams => real().nullable()();
  RealColumn get servingSizeMultiplier => real().withDefault(const Constant(1.0))();
  
  RealColumn get totalEnergyKcal => real()();
  RealColumn get totalProteinG => real()();
  RealColumn get totalFatG => real()();
  RealColumn get totalCarbohydrateG => real()();
  RealColumn get totalNetCarbsG => real()();
  RealColumn get totalFiberG => real().nullable()();
  RealColumn get totalSodiumMg => real().nullable()();
  
  TextColumn get mealContext => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get foodPhotoUrl => text().nullable()();
  
  IntColumn get synced => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
  TextColumn get updatedAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
}

/// Health Log table definition for Drift
class HealthLogs extends Table {
  IntColumn get logId => integer().autoIncrement()();
  IntColumn get userId => integer()();
  
  TextColumn get recordedAt => text()();
  TextColumn get date => text()();
  
  RealColumn get bloodGlucoseMgDl => real().nullable()();
  RealColumn get bloodKetonesMmolL => real().nullable()();
  RealColumn get gkiScore => real().nullable()();
  
  RealColumn get lactateMmolL => real().nullable()();
  RealColumn get sodiumMmolL => real().nullable()();
  
  IntColumn get bloodPressureSystolic => integer().nullable()();
  IntColumn get bloodPressureDiastolic => integer().nullable()();
  
  RealColumn get weightKg => real().nullable()();
  RealColumn get bodyFatPercentage => real().nullable()();
  RealColumn get muscleMassKg => real().nullable()();
  
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get deviceId => text().nullable()();
  
  TextColumn get notes => text().nullable()();
  IntColumn get synced => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
}

/// Food Portions table definition for Drift
class FoodPortions extends Table {
  IntColumn get portionId => integer().autoIncrement()();
  IntColumn get foodId => integer()();
  
  RealColumn get portionAmount => real()();
  TextColumn get portionUnit => text()();
  TextColumn get portionDescription => text().nullable()();
  RealColumn get portionGramWeight => real()();
  
  RealColumn get energyKcal => real().nullable()();
  RealColumn get proteinG => real().nullable()();
  RealColumn get fatG => real().nullable()();
  RealColumn get carbohydrateG => real().nullable()();
  RealColumn get netCarbsG => real().nullable()();
  
  IntColumn get isDefault => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
}

/// Daily Summary table definition for Drift
class DailySummaries extends Table {
  IntColumn get summaryId => integer().autoIncrement()();
  IntColumn get userId => integer()();
  TextColumn get date => text()();
  
  RealColumn get totalEnergyKcal => real().withDefault(const Constant(0))();
  RealColumn get totalProteinG => real().withDefault(const Constant(0))();
  RealColumn get totalFatG => real().withDefault(const Constant(0))();
  RealColumn get totalCarbohydrateG => real().withDefault(const Constant(0))();
  RealColumn get totalNetCarbsG => real().withDefault(const Constant(0))();
  RealColumn get totalFiberG => real().withDefault(const Constant(0))();
  RealColumn get totalSodiumMg => real().withDefault(const Constant(0))();
  RealColumn get totalPotassiumMg => real().withDefault(const Constant(0))();
  RealColumn get totalMagnesiumMg => real().withDefault(const Constant(0))();
  
  IntColumn get carbGoalMet => integer().withDefault(const Constant(0))();
  IntColumn get proteinGoalMet => integer().withDefault(const Constant(0))();
  IntColumn get fatGoalMet => integer().withDefault(const Constant(0))();
  
  RealColumn get avgGlucoseMgDl => real().nullable()();
  RealColumn get avgKetonesMmolL => real().nullable()();
  RealColumn get avgGkiScore => real().nullable()();
  RealColumn get minGkiScore => real().nullable()();
  RealColumn get maxGkiScore => real().nullable()();
  
  IntColumn get inKetosis => integer().withDefault(const Constant(0))();
  IntColumn get inTherapeuticKetosis => integer().withDefault(const Constant(0))();
  
  IntColumn get avgHeartRateBpm => integer().nullable()();
  RealColumn get avgHrvMs => real().nullable()();
  IntColumn get totalSteps => integer().nullable()();
  
  RealColumn get weightKg => real().nullable()();
  RealColumn get weightChangeFromStartKg => real().nullable()();
  
  RealColumn get avgEnergyLevel => real().nullable()();
  RealColumn get avgMentalClarity => real().nullable()();
  RealColumn get avgMoodRating => real().nullable()();
  
  IntColumn get dietEntriesCount => integer().withDefault(const Constant(0))();
  IntColumn get healthLogsCount => integer().withDefault(const Constant(0))();
  
  TextColumn get lastCalculatedAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
  IntColumn get synced => integer().withDefault(const Constant(0))();
}

/// Vitals table definition for Drift
class Vitals extends Table {
  IntColumn get vitalId => integer().autoIncrement()();
  IntColumn get userId => integer()();
  
  TextColumn get recordedAt => text()();
  TextColumn get date => text()();
  
  IntColumn get heartRateBpm => integer().nullable()();
  RealColumn get hrvMs => real().nullable()();
  IntColumn get restingHeartRateBpm => integer().nullable()();
  
  RealColumn get bodyTemperatureCelsius => real().nullable()();
  RealColumn get skinTemperatureCelsius => real().nullable()();
  
  RealColumn get sleepDurationHours => real().nullable()();
  RealColumn get deepSleepHours => real().nullable()();
  RealColumn get remSleepHours => real().nullable()();
  RealColumn get lightSleepHours => real().nullable()();
  IntColumn get sleepScore => integer().nullable()();
  
  IntColumn get stepsCount => integer().nullable()();
  RealColumn get activeCaloriesKcal => real().nullable()();
  RealColumn get totalCaloriesKcal => real().nullable()();
  RealColumn get distanceKm => real().nullable()();
  
  IntColumn get respiratoryRateBpm => integer().nullable()();
  RealColumn get spo2Percentage => real().nullable()();
  
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get deviceId => text().nullable()();
  
  IntColumn get synced => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
}

/// Symptoms table definition for Drift
class Symptoms extends Table {
  IntColumn get symptomId => integer().autoIncrement()();
  IntColumn get userId => integer()();
  
  TextColumn get recordedAt => text()();
  TextColumn get date => text()();
  
  IntColumn get headacheSeverity => integer().nullable()();
  IntColumn get fatigueSeverity => integer().nullable()();
  IntColumn get nauseaSeverity => integer().nullable()();
  IntColumn get dizzinessSeverity => integer().nullable()();
  IntColumn get brainFogSeverity => integer().nullable()();
  IntColumn get irritabilitySeverity => integer().nullable()();
  IntColumn get muscleCrampsSeverity => integer().nullable()();
  
  IntColumn get energyLevel => integer().nullable()();
  IntColumn get mentalClarity => integer().nullable()();
  IntColumn get moodRating => integer().nullable()();
  IntColumn get hungerLevel => integer().nullable()();
  IntColumn get satietyLevel => integer().nullable()();
  
  IntColumn get bloatingSeverity => integer().nullable()();
  IntColumn get digestionQuality => integer().nullable()();
  
  TextColumn get customSymptoms => text().nullable()();
  TextColumn get additionalNotes => text().nullable()();
  
  IntColumn get synced => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text().withDefault(Constant(DateTime.now().toIso8601String()))();
}


