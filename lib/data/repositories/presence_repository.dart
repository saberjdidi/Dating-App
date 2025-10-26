import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/presence_model.dart';
import 'package:dating_app_bilhalal/data/repositories/handle_dio_error.dart';
import 'package:dio/dio.dart';

class PresenceRepository {
  static final PresenceRepository _instance = PresenceRepository._internal();

  factory PresenceRepository() => _instance;

  PresenceRepository._internal();

  final ApiClient _client = ApiClient();

  /// Get user presence status by userId
  /// Returns ApiResult with PresenceModel containing userId and lastSeenAt
  Future<ApiResult<PresenceModel>> getUserPresence(String userId) async {
    try {
      final resp = await _client.get('${ApiConstants.presence}/$userId');

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final presenceData = map['data'] as Map<String, dynamic>;
        final presence = PresenceModel.fromJson(presenceData);

        return ApiResult(
          success: true,
          message: map['message'],
          data: presence,
        );
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null)
            ? map['message']
            : 'Error getting user presence';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(
        success: false,
        message: HandleDioError.handleDioError(e),
      );
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }
}