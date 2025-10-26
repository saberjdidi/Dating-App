import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/effective_call_permissions_model.dart';
import 'package:dating_app_bilhalal/data/models/favorite_model.dart';
import 'package:dating_app_bilhalal/data/models/settings_model.dart';
import 'package:dating_app_bilhalal/data/repositories/handle_dio_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SettingsRepository {
  static final SettingsRepository _instance = SettingsRepository._internal();

  factory SettingsRepository() => _instance;

  SettingsRepository._internal();

  final ApiClient _client = ApiClient();

  ///My Permissions
  Future<ApiResult<SettingsModel>> getMyPermissions() async {
    try {
      final resp = await _client.get('${ApiConstants.permissions}/global');

      if (resp.statusCode == HttpStatusCode.created || resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final responseData = dataMap != null ? SettingsModel.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: responseData);
      } else {
        return ApiResult(success: false, message: resp.data.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  ///Update Permission
  Future<ApiResult<SettingsModel>> updatePermission({
    required bool allowAudio,
    required bool allowVideo,
    required bool hideOnline,
  }) async {
    try {
      final body = {
        "allow_audio": allowAudio,
        "allow_video": allowVideo,
        "hide_online": hideOnline
      };

      debugPrint("update permission  : $body");

      final resp = await _client.patch('${ApiConstants.permissions}/global', data: body);

      if (resp.statusCode == HttpStatusCode.created || resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final responseData = dataMap != null ? SettingsModel.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: responseData);
      } else {
        return ApiResult(success: false, message: resp.data.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  ///Get Call Permission Overrides for Specific User
  Future<ApiResult<SettingsModel>> getCallPermissionOverrides(String targetUserId) async {
    try {
      final resp = await _client.get('${ApiConstants.permissions}/overrides/$targetUserId');

      if (resp.statusCode == HttpStatusCode.created || resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final responseData = dataMap != null ? SettingsModel.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: responseData);
      } else {
        return ApiResult(success: false, message: resp.data.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  ///Update Call Permission Overrides for Specific User
  Future<ApiResult<SettingsModel>> updateCallPermissionOverrides({
    required String targetUserId,
    required bool allowAudio,
    required bool allowVideo,
    required bool hideOnline,
  }) async {
    try {
      final body = {
        "allow_audio": allowAudio,
        "allow_video": allowVideo,
        "hide_online": hideOnline
      };

      final resp = await _client.put('${ApiConstants.permissions}/overrides/$targetUserId', data: body);

      if (resp.statusCode == HttpStatusCode.created || resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final responseData = dataMap != null ? SettingsModel.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: responseData);
      } else {
        return ApiResult(success: false, message: resp.data.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  ///Get Effective Call Permissions from User
  Future<ApiResult<EffectiveCallPermissionsModel>> getEffectiveCallPermissions(String userId) async {
    try {
      final resp = await _client.get('${ApiConstants.permissions}/from/$userId');

      if (resp.statusCode == HttpStatusCode.created || resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final responseData = dataMap != null ? EffectiveCallPermissionsModel.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: responseData);
      } else {
        return ApiResult(success: false, message: resp.data.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }
}