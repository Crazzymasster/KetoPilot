/// Data validation utilities for database operations
class DataValidator {
  /// Validate food data before insertion
  static void validateFood(Map<String, dynamic> food) {
    // Required fields
    if (food['food_description'] == null ||
        (food['food_description'] as String).isEmpty) {
      throw ValidationException('Food description is required');
    }

    // Numeric ranges
    if (food['energy_kcal'] != null) {
      final energy = (food['energy_kcal'] as num).toDouble();
      if (energy < 0 || energy > 900) {
        // Max 900 kcal per 100g (pure fat)
        throw ValidationException('Invalid energy value: must be between 0 and 900 kcal');
      }
    }

    if (food['total_carbohydrate_g'] != null) {
      final carbs = (food['total_carbohydrate_g'] as num).toDouble();
      if (carbs < 0 || carbs > 100) {
        throw ValidationException('Invalid carbohydrate value: must be between 0 and 100g');
      }
    }

    if (food['total_protein_g'] != null) {
      final protein = (food['total_protein_g'] as num).toDouble();
      if (protein < 0 || protein > 100) {
        throw ValidationException('Invalid protein value: must be between 0 and 100g');
      }
    }

    if (food['total_fat_g'] != null) {
      final fat = (food['total_fat_g'] as num).toDouble();
      if (fat < 0 || fat > 100) {
        throw ValidationException('Invalid fat value: must be between 0 and 100g');
      }
    }

    // Logical consistency
    if (food['dietary_fiber_g'] != null && food['total_carbohydrate_g'] != null) {
      final fiber = (food['dietary_fiber_g'] as num).toDouble();
      final carbs = (food['total_carbohydrate_g'] as num).toDouble();
      if (fiber > carbs) {
        throw ValidationException('Fiber cannot exceed total carbohydrates');
      }
    }

    // Net carbs validation
    if (food['net_carbs_g'] != null &&
        food['total_carbohydrate_g'] != null &&
        food['dietary_fiber_g'] != null) {
      final netCarbs = (food['net_carbs_g'] as num).toDouble();
      final carbs = (food['total_carbohydrate_g'] as num).toDouble();
      final fiber = (food['dietary_fiber_g'] as num).toDouble();
      final expectedNetCarbs = carbs - fiber;

      // Allow small rounding differences
      if ((netCarbs - expectedNetCarbs).abs() > 0.1) {
        throw ValidationException(
          'Net carbs ($netCarbs) does not match calculated value (${carbs - fiber})',
        );
      }
    }
  }

  /// Validate health log data
  static void validateHealthLog(Map<String, dynamic> log) {
    if (log['blood_glucose_mg_dl'] != null) {
      final glucose = (log['blood_glucose_mg_dl'] as num).toDouble();
      if (glucose < 20 || glucose > 400) {
        throw ValidationException('Invalid glucose value: must be between 20 and 400 mg/dL');
      }
    }

    if (log['blood_ketones_mmol_l'] != null) {
      final ketones = (log['blood_ketones_mmol_l'] as num).toDouble();
      if (ketones < 0 || ketones > 8) {
        throw ValidationException('Invalid ketones value: must be between 0 and 8 mmol/L');
      }
    }

    if (log['weight_kg'] != null) {
      final weight = (log['weight_kg'] as num).toDouble();
      if (weight < 30 || weight > 500) {
        throw ValidationException('Invalid weight value: must be between 30 and 500 kg');
      }
    }
  }

  /// Validate symptom severity (0-10 scale)
  static void validateSymptomSeverity(int? severity) {
    if (severity != null && (severity < 0 || severity > 10)) {
      throw ValidationException('Symptom severity must be between 0 and 10');
    }
  }

  /// Validate email format
  static void validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      throw ValidationException('Invalid email format');
    }
  }

  /// Validate date string format (YYYY-MM-DD)
  static void validateDate(String date) {
    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegex.hasMatch(date)) {
      throw ValidationException('Invalid date format: expected YYYY-MM-DD');
    }

    try {
      DateTime.parse(date);
    } catch (e) {
      throw ValidationException('Invalid date: $e');
    }
  }
}

/// Exception thrown when validation fails
class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

