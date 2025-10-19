import 'package:dating_app_bilhalal/core/utils/message_snackbar.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/data/repositories/auth_repository.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  static ChangePasswordController get instance => Get.find();

  String OTP = Get.arguments['OTP'] ?? '';
  String email = Get.arguments['Email'] ?? '';

  final GlobalKey<FormState> formChangePasswordKey = GlobalKey<FormState>();
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
   final isValid = formChangePasswordKey.currentState!.validate();
      if (!isValid) {
        return;
      }
   if (newPasswordController.text.trim() != confirmNewPasswordController.text.trim()) {
     MessageSnackBar.errorToast(title: "Warning".tr, message: "Mot de passe ne correspondent pas");
     return;
   }
   formChangePasswordKey.currentState!.save();

   isDataProcessing.value = true;

   //Check internet connection
   final isConnected = await NetworkManager.instance.isConnected();
   if(!isConnected) {
     isDataProcessing.value = false;
     MessageSnackBar.customToast(message: 'No Internet Connection');
     return;
   }

   final result = await authRepo.resetPassword(email: email, otp: OTP, newPassword: newPasswordController.text.trim());
   if (result.success) {
     MessageSnackBar.successSnackBar(title: 'تم التحقق بنجاح', message: result.message ?? '');
     isDataProcessing.value = false;
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => PassswordSuccessScreen()),
     );
   } else {
     isDataProcessing.value = false;
     MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'Erreur Change Password');
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