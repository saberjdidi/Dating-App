import 'package:dating_app_bilhalal/presentation/signup_screen/controller/signup_with_email_controller.dart';
import 'package:get/get.dart';
import '../controller/signup_controller.dart';

/// A binding class for the SignUpScreen.
///
/// This class ensures that the SignUpController is created when the
/// SignUpScreen is first loaded.
class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => SignUpWithEmailController());
  }
}