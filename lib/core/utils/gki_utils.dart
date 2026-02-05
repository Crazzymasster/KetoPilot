/// Utilities for GKI (Glucose Ketone Index) calculation and interpretation
class GkiUtils {
  /// Calculate GKI from glucose and ketones
  /// Formula: GKI = (Blood Glucose mg/dL ÷ 18) ÷ Blood Ketones mmol/L
  static double? calculateGki({
    required double bloodGlucoseMgDl,
    required double bloodKetonesMmolL,
  }) {
    // Prevent division by zero
    if (bloodKetonesMmolL <= 0) {
      return null; // GKI undefined when ketones = 0
    }

    return (bloodGlucoseMgDl / 18.0) / bloodKetonesMmolL;
  }

  /// Get GKI status interpretation
  static GkiStatus getGkiStatus(double? gki) {
    if (gki == null) {
      return GkiStatus.undefined;
    }

    if (gki < 1.0) {
      return GkiStatus.deepTherapeutic;
    } else if (gki < 3.0) {
      return GkiStatus.therapeutic;
    } else if (gki < 6.0) {
      return GkiStatus.moderate;
    } else if (gki < 9.0) {
      return GkiStatus.light;
    } else {
      return GkiStatus.notInKetosis;
    }
  }

  /// Get GKI status description
  static String getGkiStatusDescription(GkiStatus status) {
    return switch (status) {
      GkiStatus.deepTherapeutic => 'Deep therapeutic ketosis (cancer therapy)',
      GkiStatus.therapeutic => 'Therapeutic ketosis (epilepsy, Alzheimer\'s)',
      GkiStatus.moderate => 'Moderate ketosis (weight loss, mental clarity)',
      GkiStatus.light => 'Light ketosis (metabolic benefits)',
      GkiStatus.notInKetosis => 'Not in ketosis',
      GkiStatus.undefined => 'GKI undefined (ketones = 0)',
    };
  }

  /// Get GKI status color (for UI)
  static GkiStatusColor getGkiStatusColor(GkiStatus status) {
    return switch (status) {
      GkiStatus.deepTherapeutic => GkiStatusColor.excellent,
      GkiStatus.therapeutic => GkiStatusColor.excellent,
      GkiStatus.moderate => GkiStatusColor.good,
      GkiStatus.light => GkiStatusColor.fair,
      GkiStatus.notInKetosis => GkiStatusColor.poor,
      GkiStatus.undefined => GkiStatusColor.unknown,
    };
  }

  /// Check if in ketosis (GKI < 9)
  static bool isInKetosis(double? gki) {
    if (gki == null) return false;
    return gki < 9.0;
  }

  /// Check if in therapeutic ketosis (GKI < 3)
  static bool isInTherapeuticKetosis(double? gki) {
    if (gki == null) return false;
    return gki < 3.0;
  }
}

/// GKI status levels
enum GkiStatus {
  deepTherapeutic, // GKI < 1
  therapeutic, // GKI 1-3
  moderate, // GKI 3-6
  light, // GKI 6-9
  notInKetosis, // GKI > 9
  undefined, // Cannot calculate
}

/// GKI status colors for UI
enum GkiStatusColor {
  excellent, // Green
  good, // Blue
  fair, // Yellow
  poor, // Orange
  unknown, // Gray
}

