import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/repositories/subscription_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final SubscriptionRepository _subscriptionRepository = SubscriptionRepository();

  /// Check if user has an active subscription
  /// Returns true if user has active plan, false otherwise
  Future<bool> hasActiveSubscription() async {
    final result = await _subscriptionRepository.getSubscriptionPlans();
    if (result.success && result.data != null) {
      return result.data!.userActivePlanId != null;
    }
    return false;
  }
}