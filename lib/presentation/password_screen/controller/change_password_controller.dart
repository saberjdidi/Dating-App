import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {

  final GlobalKey<FormState> formChangePasswordKey = GlobalKey<FormState>();

  //final apiClient = Get.find<ApiClient>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<bool> isShowPassword = true.obs;
  Rx<bool> rememberme = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  passwordFn(BuildContext context) async {
    try {

   final isValid = formChangePasswordKey.currentState!.validate();
      if (!isValid) {
        return;
      }
   formChangePasswordKey.currentState!.save();

   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => const PassswordSuccessScreen()),
   );

    }
    catch (exception) {
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      //isDataProcessing.value = false;
    }
  }
}