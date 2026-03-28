import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../database/drift_database_service.dart';
import '../database/models/photo_upload_model.dart';
import '../database/models/diet_entry_model.dart';
import '../database/models/food_model.dart';
import '../database/daos/drift_diet_entry_dao.dart';
import '../database/daos/drift_food_dao.dart';
import '../api/api_client.dart';

/// Service for photo food recognition workflow
/// Note: PhotoUpload and UserFoodHistory tables are not yet in Drift
/// TODO: Add photo_uploads and user_food_history tables to Drift schema
class PhotoFoodRecognitionService {
  final DriftDatabaseService _dbService = DriftDatabaseService();
  final DriftDietEntryDao _dietEntryDao = DriftDietEntryDao();
  final DriftFoodDao _foodDao = DriftFoodDao();
  final ApiClient _apiClient;

  PhotoFoodRecognitionService(this._apiClient);

  /// Upload photo and recognize food
  /// TODO: Implement photo_uploads table in Drift to persist photo metadata
  Future<FoodRecognitionResult> uploadAndRecognize({
    required File photo,
    required int userId,
    required DateTime timestamp,
  }) async {
    //step 1: Upload to cloud storage
    final photoUrl = await _uploadToCloudStorage(photo, userId);

    //step 2: AI food recognition
    final response = await _apiClient.dio.post(
      '/api/ai/recognize-food',
      data: {'photo_url': photoUrl},
    );

    final detectedFoods = (response.data['detected_foods'] as List)
        .map((f) => DetectedFood.fromJson(f))
        .toList();

    //NOTE: Photo upload persistence disabled until photo_uploads table added to Drift
    //for now, use a temporary ID based on timestamp
    final tempPhotoId = timestamp.millisecondsSinceEpoch;
    debugPrint('[PHOTO SERVICE] Photo upload not persisted - Drift table not yet created');

    //step 4: Return results for user confirmation
    return FoodRecognitionResult(
      photoId: tempPhotoId,
      photoUrl: photoUrl,
      detectedFoods: detectedFoods,
    );
  }

  /// User confirms food selection and creates diet entry
  Future<int> confirmFoodSelection({
    required int photoId,
    required int foodId,
    required int userId,
    required DateTime timestamp,
    double servingMultiplier = 1.0,
    int? portionId,
    String? photoUrl,
  }) async {
    //get food details
    final food = await _foodDao.getFoodById(foodId);
    if (food == null) {
      throw Exception('Food not found');
    }

    //calculate nutrients based on serving multiplier
    final dateStr = timestamp.toIso8601String().split('T')[0];
    final netCarbs = (food.netCarbsG ?? (food.totalCarbohydrateG - food.dietaryFiberG)) * servingMultiplier;

    //create diet entry
    final entry = DietEntryModel(
      userId: userId,
      foodId: foodId,
      recordedAt: timestamp.toIso8601String(),
      date: dateStr,
      portionId: portionId,
      servingSizeMultiplier: servingMultiplier,
      totalEnergyKcal: food.energyKcal * servingMultiplier,
      totalProteinG: food.totalProteinG * servingMultiplier,
      totalFatG: food.totalFatG * servingMultiplier,
      totalCarbohydrateG: food.totalCarbohydrateG * servingMultiplier,
      totalNetCarbsG: netCarbs,
      totalFiberG: food.dietaryFiberG * servingMultiplier,
      foodPhotoUrl: photoUrl,
      synced: 0,
    );

    final entryId = await _dietEntryDao.insertDietEntry(entry);

    //NOTE: Photo linking and food history disabled until tables added to Drift
    debugPrint('[PHOTO SERVICE] Photo linking and food history not persisted');

    return entryId;
  }

  /// Upload photo to cloud storage
  Future<String> _uploadToCloudStorage(File photo, int userId) async {
    //this would typically upload to S3, Firebase Storage, etc.
    //for now, return a placeholder URL
    final fileName = '${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    return 'https://storage.ketopilot.com/photos/$fileName';
  }
}

/// Result of food recognition
class FoodRecognitionResult {
  final int photoId;
  final String photoUrl;
  final List<DetectedFood> detectedFoods;

  FoodRecognitionResult({
    required this.photoId,
    required this.photoUrl,
    required this.detectedFoods,
  });
}

/// Detected food from AI recognition
class DetectedFood {
  final int foodId;
  final String foodDescription;
  final double confidence;

  DetectedFood({
    required this.foodId,
    required this.foodDescription,
    required this.confidence,
  });

  factory DetectedFood.fromJson(Map<String, dynamic> json) {
    return DetectedFood(
      foodId: json['food_id'] as int,
      foodDescription: json['food_description'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
      'food_description': foodDescription,
      'confidence': confidence,
    };
  }
}

