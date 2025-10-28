import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/core/utils/pref_utils.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/favorite_model.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/repositories/handle_dio_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;

  UserRepository._internal();

  final ApiClient _client = ApiClient();
  /// search users
  Future<ApiResult<List<UserModel>>> searchUsers(Map<String, dynamic> body) async {
    try {
      debugPrint('body filter user : $body');
      final resp = await _client.post(ApiConstants.searchUser, data: body);

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final data = map['data']['items'] as List<dynamic>? ?? [];
        final result = data.map((e) => UserModel.fromJson(e)).toList();

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

  ///Get User by id
  Future<ApiResult<UserModel>> getUserById(String userId) async {
    try {
      final resp = await _client.get('${ApiConstants.user}/$userId');

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final userData = dataMap != null ? UserModel.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: userData);
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : resp.statusMessage;
        return ApiResult(success: false, message: msg?.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  ///Get Countries localized
  Future<ApiResult<List<CountryModel>>> getCountries({int page = 1, int pageSize = 50}) async {
    try {
      final isArabe = PrefUtils.getLangue() == 'ar';
      final language = isArabe ? 'ar' : 'en';

      final resp = await _client.get(
        ApiConstants.countries,
        queryParameters: {'page': page, 'pageSize': pageSize},
        options: Options(
          headers: {
            'Accept-Language': language, // ✅ Ajout ici, spécifique à cet appel
          },
        ),
      );

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final data = map['data']['items'] as List<dynamic>? ?? [];
        final result = data.map((e) => CountryModel.fromJson(e)).toList();

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

}