import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/favorite_model.dart';
import 'package:dating_app_bilhalal/data/models/like_user_model.dart';
import 'package:dating_app_bilhalal/data/repositories/handle_dio_error.dart';
import 'package:dio/dio.dart';

class LikeRepository {
  static final LikeRepository _instance = LikeRepository._internal();

  factory LikeRepository() => _instance;

  LikeRepository._internal();

  final ApiClient _client = ApiClient();

  /// ✅ Get Status User Like
  Future<ApiResult<Map<String, dynamic>>> getStatusLikeUser(String userId) async {
    try {
      final resp = await _client.get('${ApiConstants.likes}/$userId/status');

      if (resp.statusCode == 200) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: true, message: map['message'] as String?, data: map['data'] as Map<String, dynamic>?);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null)
            ? map['message']
            : 'Error get status user like';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// ✅ Add User to Favorite
  Future<ApiResult<Map<String, dynamic>>> addUserToFavorite(String userId) async {
    try {
      final resp = await _client.post('${ApiConstants.likes}/$userId');

      if (resp.statusCode == 200 || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: true, message: map['message'] as String?, data: map['data'] as Map<String, dynamic>?);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null)
            ? map['message']
            : 'Error add user to favorite';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// ✅ Delete user from Favorite
  Future<ApiResult<Map<String, dynamic>>> deleteUserFromFavorite(String userId) async {
    try {
      final resp = await _client.delete('${ApiConstants.likes}/$userId');

      if (resp.statusCode == 200) {
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

  /// ✅ Get Likes Users
  Future<ApiResult<List<LikeUserModel>>> getLikesUsers({int page = 1, int pageSize = 30}) async {
    try {
      final resp = await _client.get(
        ApiConstants.likes,
        queryParameters: {'page': page, 'pageSize': pageSize},
      );

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final data = map['data']['items'] as List<dynamic>? ?? [];
        final result = data.map((e) => LikeUserModel.fromJsonLikeUser(e)).toList();

        return ApiResult(success: true, data: result, message: map['message']);
      } else {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: false, message: map['message']);
      }
    } on DioException catch (e) {
      final msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// ✅ Get Likes Users
  Future<ApiResult<List<LikeUserModel>>> getUsersLikeMe({int page = 1, int pageSize = 30}) async {
    try {
      final resp = await _client.get(
        '${ApiConstants.likes}/me',
        queryParameters: {'page': page, 'pageSize': pageSize},
      );

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final data = map['data']['items'] as List<dynamic>? ?? [];
        final result = data.map((e) => LikeUserModel.fromJsonUserLikeMe(e)).toList();

        return ApiResult(success: true, data: result, message: map['message']);
      } else {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: false, message: map['message']);
      }
    } on DioException catch (e) {
      final msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }
}