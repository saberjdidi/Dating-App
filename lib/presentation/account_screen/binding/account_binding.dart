import 'package:dating_app_bilhalal/presentation/account_screen/controller/create_account_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SignUpScreen.
///
/// This class ensures that the SignUpController is created when the
/// SignUpScreen is first loaded.
class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateAccountController());
    //Get.lazyPut(() => SignUpWithEmailController());
  }
}