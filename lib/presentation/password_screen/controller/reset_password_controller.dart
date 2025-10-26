import 'package:dating_app_bilhalal/core/utils/message_snackbar.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/pref_utils.dart';
import 'package:dating_app_bilhalal/data/repositories/auth_repository.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get instance => Get.find();

  String OTP = Get.arguments['OTP'] ?? '';
  String email = Get.arguments['Email'] ?? '';

  final GlobalKey<FormState> formResetPasswordKey = GlobalKey<FormState>();
  RxBool isDataProcessing = false.obs;
  final authRepo = AuthRepository();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  Rx<bool> isShowPassword = true.obs;
  Rx<bool> rememberme = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }

  resetPasswordFn(BuildContext context) async {
    try {
   final isValid = formResetPasswordKey.currentState!.validate();
      if (!isValid) {
        return;
      }
   if (newPasswordController.text.trim() != confirmNewPasswordController.text.trim()) {
     MessageSnackBar.errorToast(title: "Warning".tr, message: "Password does not match");
     return;
   }
   formResetPasswordKey.currentState!.save();

   isDataProcessing.value = true;

   //Check internet connection
   final isConnected = await NetworkManager.instance.isConnected();
   if(!isConnected) {
     isDataProcessing.value = false;
     MessageSnackBar.customToast(message: 'No Internet Connection');
     return;
   }

   final result = await authRepo.resetPassword(newPassword: newPasswordController.text.trim(), confirmPassword: confirmNewPasswordController.text.trim());
   //final result = await authRepo.resetPassword(email: email, otp: OTP, newPassword: newPasswordController.text.trim());
   if (result.success) {
     await PrefUtils.clearToken();
     MessageSnackBar.successSnackBar(title: 'تم التحقق بنجاح', message: result.message ?? '');
     isDataProcessing.value = false;
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => PassswordSuccessScreen()),
     );
   } else {
     isDataProcessing.value = false;
     MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'Error Reset Password');
   }
    }
    catch (exception) {
      isDataProcessing.value = false;
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      isDataProcessing.value = false;
    }
  }
}