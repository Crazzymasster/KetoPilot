class WeeklyNutritionUtils {
  //calculates start and end dates for current week (Monday to Sunday)
  static Map<String, DateTime> getCurrentWeekRange() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    
    return {
      'start': weekStart,
      'end': weekEnd,
    };
  }

  //formats DateTime to ISO date string for database queries
  static String toDateString(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }

  //creates map with all 7 days initialized to zero
  static Map<String, Map<String, double>> initializeWeekData(DateTime weekStart) {
    final dailyData = <String, Map<String, double>>{};
    
    for (int i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      final dateStr = toDateString(date);
      dailyData[dateStr] = {
        'carbs': 0.0,
        'protein': 0.0,
        'fat': 0.0,
        'calories': 0.0,
      };
    }
    
    return dailyData;
  }

  //converts 3-letter day abbreviation from date
  static String getDayName(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[date.weekday - 1];
    } catch (e) {
      return dateStr.substring(dateStr.length - 2);
    }
  }
}
