import 'package:get/get.dart';
import '../controller/sign_in_controller.dart';

/// A binding class for the SignInScreen.
///
/// This class ensures that the SignInController is created when the
/// SignInScreen is first loaded.
class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}