import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/otp_screen/otp_screen.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final GlobalKey<FormState> formForgetPasswordKey = GlobalKey<FormState>();

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

      Get.toNamed(Routes.otpScreen, arguments: {
        "SourceOTP" : "FromForgetPassword",
        "Email" : emailController.text.trim(),
      });

    }
    catch (exception) {
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      //isDataProcessing.value = false;
    }
  }
}