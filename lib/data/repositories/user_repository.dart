import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
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

}