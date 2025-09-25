import 'package:dating_app_bilhalal/presentation/password_screen/controller/change_password_controller.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/controller/forget_password_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SignInScreen.
///
/// This class ensures that the SignInController is created when the
/// SignInScreen is first loaded.
class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordController());
    Get.lazyPut(() => ChangePasswordController());
  }
}