import '../../../core/app_export.dart';
import '../controller/onboarding_controller.dart';

/// A binding class for the OnboardingOneScreen.
///
/// This class ensures that the OnboardingOneController is created when the
/// OnboardingOneScreen is first loaded.
class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingController());
  }
}