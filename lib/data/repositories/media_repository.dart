import 'dart:io';
import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/media_model.dart';
import 'package:dio/dio.dart';

import 'handle_dio_error.dart';

class MediaRepository {
  static final MediaRepository _instance = MediaRepository._internal();
  factory MediaRepository() => _instance;
  MediaRepository._internal();

  final ApiClient _client = ApiClient();

  //Profile Image
  Future<ApiResult<Map<String, dynamic>>> uploadProfileImage(File? file) async {
    try {
      final fileName = file!.path.split('/').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final resp = await _client.post(
        '${ApiConstants.media}/profile-image',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: true, message: map['message'] as String?, data: map['data'] as Map<String, dynamic>?);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : resp.statusMessage;
        return ApiResult(success: false, message: msg?.toString());
      }
    } on DioException catch (e) {
      final msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// Upload profile image
  Future<ApiResult<void>> uploadOneMedia(File file) async {
    try {
      final fileName = file.path.split('/').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final resp = await _client.post(
        ApiConstants.media,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: true, message: map['message'] as String?);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : resp.statusMessage;
        return ApiResult(success: false, message: msg?.toString());
      }
    } on DioException catch (e) {
      final msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  Future<ApiResult<void>> uploadMultiMedia(List<File> files) async {
    try {
      final formData = FormData();

      for (var file in files) {
        final fileName = file.path.split('/').last;
        formData.files.add(MapEntry(
          'file', // ⚠️ ou 'files[]' selon ce que ton backend attend
          await MultipartFile.fromFile(file.path, filename: fileName),
        ));
      }

      final resp = await _client.post(
        '${ApiConstants.media}/profile-image',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: true, message: map['message'] as String?);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : resp.statusMessage;
        return ApiResult(success: false, message: msg?.toString());
      }
    } on DioException catch (e) {
      final msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  Future<ApiResult<List<MediaModel>>> getAllMedia({int page = 1, int pageSize = 20}) async {
    try {
      final resp = await _client.get(
        ApiConstants.media,
        queryParameters: {'page': page, 'pageSize': pageSize},
      );

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final data = map['data']?['items'] as List<dynamic>? ?? [];
        final medias = data.map((e) => MediaModel.fromJson(e)).toList();

        return ApiResult(success: true, data: medias, message: map['message']);
      } else {
        return ApiResult(success: false, message: resp.statusMessage);
      }
    } on DioException catch (e) {
      final msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// ✅ Supprimer un média
  Future<ApiResult<void>> deleteMedia(String id) async {
    try {
      final resp = await _client.delete('${ApiConstants.media}/$id');

      if (resp.statusCode == 200) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(
          success: map['success'] ?? false,
          message: map['message']?.toString(),
        );
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null)
            ? map['message']
            : 'Erreur lors de la suppression';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

}
