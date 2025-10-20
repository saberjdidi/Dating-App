import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/favorite_model.dart';
import 'package:dating_app_bilhalal/data/repositories/handle_dio_error.dart';
import 'package:dio/dio.dart';

class FavoriteRepository {
  static final FavoriteRepository _instance = FavoriteRepository._internal();

  factory FavoriteRepository() => _instance;

  FavoriteRepository._internal();

  final ApiClient _client = ApiClient();
  /// ✅ Get Medias Favorites
  Future<ApiResult<List<FavoriteModel>>> getMediasFavorites({int page = 1, int pageSize = 30}) async {
    try {
      final resp = await _client.get(
        ApiConstants.favourites,
        queryParameters: {'page': page, 'pageSize': pageSize},
      );

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final data = map['data']['items'] as List<dynamic>? ?? [];
        final result = data.map((e) => FavoriteModel.fromJson(e)).toList();

        return ApiResult(success: true, data: result, message: map['message']);
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

  /// ✅ Get Status Media Favorite
  Future<ApiResult<Map<String, dynamic>>> getMediaFavoriteStatus(String mediaId) async {
    try {
      final resp = await _client.get('${ApiConstants.favourites}/$mediaId/status');

      if (resp.statusCode == 200 || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: true, message: map['message'] as String?, data: map['data'] as Map<String, dynamic>?);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null)
            ? map['message']
            : 'Erreur add to favorite';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// ✅ Add to Favorite
  Future<ApiResult<Map<String, dynamic>>> addMediaFavorite(String mediaId) async {
    try {
      final resp = await _client.post('${ApiConstants.favourites}/$mediaId');

      if (resp.statusCode == 200 || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: true, message: map['message'] as String?, data: map['data'] as Map<String, dynamic>?);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null)
            ? map['message']
            : 'Erreur add to favorite';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// ✅ Delete from Favorite
  Future<ApiResult<Map<String, dynamic>>> deleteMediaFavorite(String mediaId) async {
    try {
      final resp = await _client.delete('${ApiConstants.favourites}/$mediaId');

      if (resp.statusCode == 200 || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: true, message: map['message'] as String?, data: map['data'] as Map<String, dynamic>?);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null)
            ? map['message']
            : 'Erreur add to favorite';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }
}