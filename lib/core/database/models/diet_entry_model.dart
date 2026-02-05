/// Database model for tb_diet_entries table
class DietEntryModel {
  final int? entryId;
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

  DietEntryModel({
    this.entryId,
    required this.userId,
    required this.foodId,
    required this.recordedAt,
    required this.date,
    this.portionId,
    this.customPortionGrams,
    this.servingSizeMultiplier = 1.0,
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
    this.synced = 0,
    String? createdAt,
    String? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (entryId != null) 'entry_id': entryId,
      'user_id': userId,
      'food_id': foodId,
      'recorded_at': recordedAt,
      'date': date,
      'portion_id': portionId,
      'custom_portion_grams': customPortionGrams,
      'serving_size_multiplier': servingSizeMultiplier,
      'total_energy_kcal': totalEnergyKcal,
      'total_protein_g': totalProteinG,
      'total_fat_g': totalFatG,
      'total_carbohydrate_g': totalCarbohydrateG,
      'total_net_carbs_g': totalNetCarbsG,
      'total_fiber_g': totalFiberG,
      'total_sodium_mg': totalSodiumMg,
      'meal_context': mealContext,
      'location': location,
      'notes': notes,
      'food_photo_url': foodPhotoUrl,
      'synced': synced,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory DietEntryModel.fromMap(Map<String, dynamic> map) {
    return DietEntryModel(
      entryId: map['entry_id'] as int?,
      userId: map['user_id'] as int,
      foodId: map['food_id'] as int,
      recordedAt: map['recorded_at'] as String,
      date: map['date'] as String,
      portionId: map['portion_id'] as int?,
      customPortionGrams: map['custom_portion_grams'] as double?,
      servingSizeMultiplier: map['serving_size_multiplier'] as double? ?? 1.0,
      totalEnergyKcal: map['total_energy_kcal'] as double,
      totalProteinG: map['total_protein_g'] as double,
      totalFatG: map['total_fat_g'] as double,
      totalCarbohydrateG: map['total_carbohydrate_g'] as double,
      totalNetCarbsG: map['total_net_carbs_g'] as double,
      totalFiberG: map['total_fiber_g'] as double?,
      totalSodiumMg: map['total_sodium_mg'] as double?,
      mealContext: map['meal_context'] as String?,
      location: map['location'] as String?,
      notes: map['notes'] as String?,
      foodPhotoUrl: map['food_photo_url'] as String?,
      synced: map['synced'] as int? ?? 0,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }
}

