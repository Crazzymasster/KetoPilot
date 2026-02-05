/// Database model for tb_food_portions table
class FoodPortionModel {
  final int? portionId;
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

  FoodPortionModel({
    this.portionId,
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
    this.isDefault = 0,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (portionId != null) 'portion_id': portionId,
      'food_id': foodId,
      'portion_amount': portionAmount,
      'portion_unit': portionUnit,
      'portion_description': portionDescription,
      'portion_gram_weight': portionGramWeight,
      'energy_kcal': energyKcal,
      'protein_g': proteinG,
      'fat_g': fatG,
      'carbohydrate_g': carbohydrateG,
      'net_carbs_g': netCarbsG,
      'is_default': isDefault,
      'created_at': createdAt,
    };
  }

  factory FoodPortionModel.fromMap(Map<String, dynamic> map) {
    return FoodPortionModel(
      portionId: map['portion_id'] as int?,
      foodId: map['food_id'] as int,
      portionAmount: map['portion_amount'] as double,
      portionUnit: map['portion_unit'] as String,
      portionDescription: map['portion_description'] as String?,
      portionGramWeight: map['portion_gram_weight'] as double,
      energyKcal: map['energy_kcal'] as double?,
      proteinG: map['protein_g'] as double?,
      fatG: map['fat_g'] as double?,
      carbohydrateG: map['carbohydrate_g'] as double?,
      netCarbsG: map['net_carbs_g'] as double?,
      isDefault: map['is_default'] as int? ?? 0,
      createdAt: map['created_at'] as String?,
    );
  }
}

