class FoodEntryData {
  final String name;
  final double carbs;
  final double protein;
  final double fat;
  final double calories;
  final DateTime timestamp;
  final String servingSize;
  final int entryId;

  FoodEntryData({
    required this.name,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.timestamp,
    required this.servingSize,
    required this.entryId,
  });
}
