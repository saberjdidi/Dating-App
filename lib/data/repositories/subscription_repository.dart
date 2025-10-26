import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/subscription_plans_response.dart';
import 'package:dating_app_bilhalal/data/repositories/handle_dio_error.dart';
import 'package:dio/dio.dart';

class SubscriptionRepository {
  static final SubscriptionRepository _instance =
      SubscriptionRepository._internal();

  factory SubscriptionRepository() => _instance;

  SubscriptionRepository._internal();

  final ApiClient _client = ApiClient();

  /// Get all subscription plans and user's active plan
  /// Returns ApiResult with SubscriptionPlansResponse containing:
  /// - List of available subscription plans
  /// - User's active plan ID (if any)
  Future<ApiResult<SubscriptionPlansResponse>> getSubscriptionPlans() async {
    try {
      final resp = await _client.get(ApiConstants.subscriptionPlans);

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final plansData = map['data'] as Map<String, dynamic>;
        final subscriptionPlans = SubscriptionPlansResponse.fromJson(plansData);

        return ApiResult(
          success: true,
          message: map['message'],
          data: subscriptionPlans,
        );
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null)
            ? map['message']
            : 'Error retrieving subscription plans';
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