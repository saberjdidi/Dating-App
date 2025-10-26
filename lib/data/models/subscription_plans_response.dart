import 'package:dating_app_bilhalal/core/app_export.dart';

import 'subscription_plan_model.dart';

class SubscriptionPlansResponse {
  List<SubscriptionPlanModel>? plans;
  String? userActivePlanId;

  SubscriptionPlansResponse({
    this.plans,
    this.userActivePlanId,
  });

  SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) {
    if (json['plans'] != null) {
      plans = <SubscriptionPlanModel>[];
      json['plans'].forEach((v) {
        plans!.add(SubscriptionPlanModel.fromJson(v));
      });
    }
    userActivePlanId = json['user_active_plan_id'];
  }

  /// Helper method to get the currently active plan
  SubscriptionPlanModel? get activePlan => plans?.firstWhereOrNull(
        (plan) => plan.id == userActivePlanId,
      );
  /// Get only inactive plans (where isActive == false)
  List<SubscriptionPlanModel> get inactivePlans =>
      plans?.where((plan) => plan.isActive == false).toList() ?? [];
}
