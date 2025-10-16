import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dio/dio.dart';

import 'handle_dio_error.dart';

class ProfileRepository {
  static final ProfileRepository _instance = ProfileRepository._internal();

  factory ProfileRepository() => _instance;

  ProfileRepository._internal();

  final ApiClient _client = ApiClient();

  /// ✅ Resend OTP
  Future<ApiResult<void>> profileReport({required int id, required String commentaire}) async {
    try {
      final body = {'comment': commentaire};
      final resp = await _client.post('${ApiConstants.profileReport}/$id', data: body);

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: map['success'] ?? false, message: map['message']?.toString());
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : 'Erreur Reports';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }
}