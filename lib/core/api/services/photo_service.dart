import 'package:dio/dio.dart';
import 'dart:io';
import '../api_client.dart';

/// Photo upload and recognition API service
class PhotoService {
  final ApiClient _apiClient;

  PhotoService(this._apiClient);

  /// Upload photo for food recognition
  Future<Map<String, dynamic>> uploadPhoto({
    required File photo,
    required String recordedAt,
  }) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photo.path),
      'recorded_at': recordedAt,
    });

    final response = await _apiClient.dio.post(
      '/api/photo/upload',
      data: formData,
    );
    return response.data;
  }
}

