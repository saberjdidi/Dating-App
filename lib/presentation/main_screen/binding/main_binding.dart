

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';

/// A binding class for the OnboardingOneScreen.
///
/// This class ensures that the OnboardingOneController is created when the
/// OnboardingOneScreen is first loaded.
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}