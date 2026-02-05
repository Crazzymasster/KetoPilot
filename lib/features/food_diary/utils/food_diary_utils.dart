import '../data/food_entry_data.dart';

class FoodDiaryUtils {
  //filters entries based on search query
  static List<FoodEntryData> filterEntries(
    List<FoodEntryData> entries,
    String searchQuery,
  ) {
    if (searchQuery.isEmpty) return entries;
    
    return entries.where((e) => 
      e.name.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  //sort entries by specified criteria
  static List<FoodEntryData> sortEntries(
    List<FoodEntryData> entries,
    String sortBy,
    bool ascending,
  ) {
    final sorted = List<FoodEntryData>.from(entries);
    
    sorted.sort((a, b) {
      int comparison;
      switch (sortBy) {
        case 'carbs':
          comparison = a.carbs.compareTo(b.carbs);
          break;
        case 'protein':
          comparison = a.protein.compareTo(b.protein);
          break;
        case 'fat':
          comparison = a.fat.compareTo(b.fat);
          break;
        case 'time':
        default:
          comparison = a.timestamp.compareTo(b.timestamp);
          break;
      }
      return ascending ? comparison : -comparison;
    });
    
    return sorted;
  }

  //calculates total macros from entry list
  static Map<String, double> calculateTotals(List<FoodEntryData> entries) {
    double carbs = 0.0;
    double protein = 0.0;
    double fat = 0.0;
    
    for (final entry in entries) {
      carbs += entry.carbs;
      protein += entry.protein;
      fat += entry.fat;
    }
    
    return {
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
    };
  }

  //converts macro grams to calories using 4-4-9 formula
  static double calculateCalories(double protein, double carbs, double fat) {
    return (protein * 4) + (carbs * 4) + (fat * 9);
  }
}
