import 'package:dating_app_bilhalal/presentation/support_screen/controller/support_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SignInScreen.
///
/// This class ensures that the SignInController is created when the
/// SignInScreen is first loaded.
class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportController());
  }
}