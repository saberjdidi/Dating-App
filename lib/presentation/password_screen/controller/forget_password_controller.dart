import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/data/repositories/auth_repository.dart';
import 'package:dating_app_bilhalal/presentation/otp_screen/otp_screen.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final GlobalKey<FormState> formForgetPasswordKey = GlobalKey<FormState>();
  RxBool isDataProcessing = false.obs;
  final authRepo = AuthRepository();

  //final apiClient = Get.find<ApiClient>();

  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  forgetPasswordFn() async {
    try {

      final isValid = formForgetPasswordKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formForgetPasswordKey.currentState!.save();

      isDataProcessing.value = true;

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      final result = await authRepo.forgetPassword(email: emailController.text.trim());
      if (result.success) {
        MessageSnackBar.successSnackBar(title: 'تم التحقق بنجاح', message: result.message ?? '');
        isDataProcessing.value = false;
        Get.toNamed(Routes.otpScreen, arguments: {
          "SourceOTP" : "FromForgetPassword",
          "Email" : emailController.text.trim(),
        });
      } else {
        isDataProcessing.value = false;
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'Erreur serveur');
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