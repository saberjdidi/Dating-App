import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/auth_response.dart';
import 'package:dio/dio.dart';

import 'handle_dio_error.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  factory AuthRepository() => _instance;
  AuthRepository._internal();

  final ApiClient _client = ApiClient();

  /// Register
  Future<ApiResult<AuthResponse>> register({required String email, required String password}) async {
    try {
      final body = {'email': email, 'password': password};
      final resp = await _client.post(ApiConstants.authRegister, data: body);

      if (resp.statusCode == HttpStatusCode.created || resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final authData = dataMap != null ? AuthResponse.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: authData);
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

  /// Login
  Future<ApiResult<AuthResponse>> login({required String email, required String password}) async {
    try {
      final body = {'email': email, 'password': password};
      final resp = await _client.post(ApiConstants.authLogin, data: body);

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final authData = dataMap != null ? AuthResponse.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: authData);
      } else {
        // backend retourne 4xx avec message dans body
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

  /// ✅ Verify OTP
  Future<ApiResult<void>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final body = {'email': email, 'otp': otp};
      final resp = await _client.post(ApiConstants.verifyOtp, data: body);

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: map['success'] ?? false, message: map['message']?.toString());
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : 'Erreur OTP';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// ✅ Resend OTP
  Future<ApiResult<void>> resendOtp({required String email}) async {
    try {
      final body = {'email': email};
      final resp = await _client.post(ApiConstants.resendOtp, data: body);

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: map['success'] ?? false, message: map['message']?.toString());
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : 'Erreur OTP';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

 /* String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout) {
      return 'Connection timeout. Vérifie ta connexion.';
    }
    if (e.response != null && e.response?.data != null) {
      try {
        final body = e.response!.data;
        if (body is Map<String, dynamic> && body['message'] != null) return body['message'].toString();
        return body.toString();
      } catch (_) {
        return e.response.toString();
      }
    }
    return e.message!;
  } */
}
