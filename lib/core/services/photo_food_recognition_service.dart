import 'dart:convert';
import 'dart:io';
import '../database/database_service.dart';
import '../database/models/photo_upload_model.dart';
import '../database/models/diet_entry_model.dart';
import '../database/models/food_model.dart';
import '../database/daos/photo_upload_dao.dart';
import '../database/daos/diet_entry_dao.dart';
import '../database/daos/food_dao.dart';
import '../database/daos/user_food_history_dao.dart';
import '../api/api_client.dart';

/// Service for photo food recognition workflow
class PhotoFoodRecognitionService {
  final DatabaseService _dbService = DatabaseService();
  final PhotoUploadDao _photoDao = PhotoUploadDao();
  final DietEntryDao _dietEntryDao = DietEntryDao();
  final FoodDao _foodDao = FoodDao();
  final UserFoodHistoryDao _foodHistoryDao = UserFoodHistoryDao();
  final ApiClient _apiClient;

  PhotoFoodRecognitionService(this._apiClient);

  /// Upload photo and recognize food
  Future<FoodRecognitionResult> uploadAndRecognize({
    required File photo,
    required int userId,
    required DateTime timestamp,
  }) async {
    // Step 1: Upload to cloud storage
    final photoUrl = await _uploadToCloudStorage(photo, userId);

    // Step 2: AI food recognition
    final response = await _apiClient.dio.post(
      '/api/ai/recognize-food',
      data: {'photo_url': photoUrl},
    );

    final detectedFoods = (response.data['detected_foods'] as List)
        .map((f) => DetectedFood.fromJson(f))
        .toList();

    // Step 3: Save to database
    final photoUpload = PhotoUploadModel(
      userId: userId,
      filePath: photoUrl,
      fileSizeBytes: await photo.length(),
      mimeType: 'image/jpeg',
      detectedFoodIds: jsonEncode(detectedFoods.map((f) => f.foodId).toList()),
      recognitionConfidence: detectedFoods.isEmpty ? 0.0 : detectedFoods[0].confidence,
      uploadedAt: timestamp.toIso8601String(),
    );

    final photoId = await _photoDao.insertPhotoUpload(photoUpload);

    // Step 4: Return results for user confirmation
    return FoodRecognitionResult(
      photoId: photoId,
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
  }) async {
    // Get food details
    final food = await _foodDao.getFoodById(foodId);
    if (food == null) {
      throw Exception('Food not found');
    }

    // Get photo for URL
    final photo = await _photoDao.getPhotoById(photoId);
    if (photo == null) {
      throw Exception('Photo not found');
    }

    // Calculate nutrients based on serving multiplier
    final dateStr = timestamp.toIso8601String().split('T')[0];
    final netCarbs = (food.netCarbsG ?? (food.totalCarbohydrateG - food.dietaryFiberG)) * servingMultiplier;

    // Create diet entry
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
      foodPhotoUrl: photo.filePath,
      synced: 0,
    );

    final entryId = await _dietEntryDao.insertDietEntry(entry);

    // Link photo to entry
    await _photoDao.linkPhotoToEntry(photoId, entryId);

    // Update food history for recommendations
    await _updateFoodHistory(userId, foodId, timestamp);

    return entryId;
  }

  /// Update food history when food is consumed
  Future<void> _updateFoodHistory(int userId, int foodId, DateTime timestamp) async {
    await _foodHistoryDao.recordConsumption(
      userId: userId,
      foodId: foodId,
      consumedAt: timestamp,
    );
  }

  /// Upload photo to cloud storage
  Future<String> _uploadToCloudStorage(File photo, int userId) async {
    // This would typically upload to S3, Firebase Storage, etc.
    // For now, return a placeholder URL
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

