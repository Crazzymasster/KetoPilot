/// Database model for tb_food table
class FoodModel {
  final int? foodId;
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
  final String? vitamins; // JSON string
  final String? minerals; // JSON string
  final String? foodPhotoUrl;
  final String? barcode;
  final String createdAt;
  final String updatedAt;

  FoodModel({
    this.foodId,
    this.keylist,
    required this.foodDescription,
    this.source = 'ncc',
    this.createdByUserId,
    this.isVerified = 0,
    this.isKetoFriendly,
    required this.energyKcal,
    required this.totalProteinG,
    required this.totalFatG,
    required this.totalCarbohydrateG,
    this.dietaryFiberG = 0,
    this.sugarG = 0,
    this.addedSugarG = 0,
    double? netCarbsG,
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
    String? createdAt,
    String? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updatedAt ?? DateTime.now().toIso8601String(),
        netCarbsG = netCarbsG ?? (totalCarbohydrateG - dietaryFiberG);

  Map<String, dynamic> toMap() {
    return {
      if (foodId != null) 'food_id': foodId,
      'keylist': keylist,
      'food_description': foodDescription,
      'source': source,
      'created_by_user_id': createdByUserId,
      'is_verified': isVerified,
      'is_keto_friendly': isKetoFriendly,
      'energy_kcal': energyKcal,
      'total_protein_g': totalProteinG,
      'total_fat_g': totalFatG,
      'total_carbohydrate_g': totalCarbohydrateG,
      'dietary_fiber_g': dietaryFiberG,
      'sugar_g': sugarG,
      'added_sugar_g': addedSugarG,
      'net_carbs_g': netCarbsG ?? (totalCarbohydrateG - dietaryFiberG),
      'saturated_fat_g': saturatedFatG,
      'monounsaturated_fat_g': monounsaturatedFatG,
      'polyunsaturated_fat_g': polyunsaturatedFatG,
      'trans_fat_g': transFatG,
      'cholesterol_mg': cholesterolMg,
      'sodium_mg': sodiumMg,
      'potassium_mg': potassiumMg,
      'magnesium_mg': magnesiumMg,
      'calcium_mg': calciumMg,
      'glycemic_index': glycemicIndex,
      'glycemic_load': glycemicLoad,
      'vitamins': vitamins,
      'minerals': minerals,
      'food_photo_url': foodPhotoUrl,
      'barcode': barcode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      foodId: map['food_id'] as int?,
      keylist: map['keylist'] as String?,
      foodDescription: map['food_description'] as String,
      source: map['source'] as String? ?? 'ncc',
      createdByUserId: map['created_by_user_id'] as int?,
      isVerified: map['is_verified'] as int? ?? 0,
      isKetoFriendly: map['is_keto_friendly'] as int?,
      energyKcal: map['energy_kcal'] as double,
      totalProteinG: map['total_protein_g'] as double,
      totalFatG: map['total_fat_g'] as double,
      totalCarbohydrateG: map['total_carbohydrate_g'] as double,
      dietaryFiberG: map['dietary_fiber_g'] as double? ?? 0,
      sugarG: map['sugar_g'] as double? ?? 0,
      addedSugarG: map['added_sugar_g'] as double? ?? 0,
      netCarbsG: map['net_carbs_g'] as double?,
      saturatedFatG: map['saturated_fat_g'] as double?,
      monounsaturatedFatG: map['monounsaturated_fat_g'] as double?,
      polyunsaturatedFatG: map['polyunsaturated_fat_g'] as double?,
      transFatG: map['trans_fat_g'] as double?,
      cholesterolMg: map['cholesterol_mg'] as double?,
      sodiumMg: map['sodium_mg'] as double?,
      potassiumMg: map['potassium_mg'] as double?,
      magnesiumMg: map['magnesium_mg'] as double?,
      calciumMg: map['calcium_mg'] as double?,
      glycemicIndex: map['glycemic_index'] as int?,
      glycemicLoad: map['glycemic_load'] as double?,
      vitamins: map['vitamins'] as String?,
      minerals: map['minerals'] as String?,
      foodPhotoUrl: map['food_photo_url'] as String?,
      barcode: map['barcode'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  FoodModel copyWith({
    int? foodId,
    String? keylist,
    String? foodDescription,
    String? source,
    int? createdByUserId,
    int? isVerified,
    int? isKetoFriendly,
    double? energyKcal,
    double? totalProteinG,
    double? totalFatG,
    double? totalCarbohydrateG,
    double? dietaryFiberG,
    double? sugarG,
    double? addedSugarG,
    double? netCarbsG,
    double? saturatedFatG,
    double? monounsaturatedFatG,
    double? polyunsaturatedFatG,
    double? transFatG,
    double? cholesterolMg,
    double? sodiumMg,
    double? potassiumMg,
    double? magnesiumMg,
    double? calciumMg,
    int? glycemicIndex,
    double? glycemicLoad,
    String? vitamins,
    String? minerals,
    String? foodPhotoUrl,
    String? barcode,
    String? createdAt,
    String? updatedAt,
  }) {
    return FoodModel(
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
}

