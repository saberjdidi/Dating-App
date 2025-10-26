import 'package:dating_app_bilhalal/core/utils/image_constant.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/core/utils/popups/message_snackbar.dart';
import 'package:dating_app_bilhalal/core/utils/pref_utils.dart';
import 'package:dating_app_bilhalal/data/repositories/auth_repository.dart';
import 'package:dating_app_bilhalal/presentation/otp_screen/otp_success_screen.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:dating_app_bilhalal/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPController extends GetxController with GetSingleTickerProviderStateMixin {
  static OTPController get instance => Get.find();

  final authRepo = AuthRepository();

  String sourceOTP = Get.arguments['SourceOTP'] ?? '';
  String email = Get.arguments['Email'] ?? '';

  AnimationController? animationController;
  RxInt levelClock = (2 * 60).obs;

  RxString otpCode = "".obs;
  RxBool isOtpError = false.obs;
  RxString errorMessage = "".obs;
  RxBool canResend = false.obs;
  RxBool isLoading = false.obs; // ✅ variable pour le loader du bouton

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: levelClock.value),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        canResend.value = true;
      }
    });

    animationController!.forward();
    listenSmsCode();
  }

  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
    animationController?.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    animationController?.dispose();
    super.dispose();
  }

  listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

  /// ✅ Vérifie le code OTP
  Future<void> verifyOtpFn(BuildContext context) async {
    if (otpCode.value.length != 6) {
      MessageSnackBar.warningSnackBar(title: 'تنبيه', message: 'الرجاء إدخال الرمز المكون من 6 أرقام');
      return;
    }

    FullScreenLoader.openLoadingDialog('جاري التحقق من الرمز...', ImageConstant.lottieLoading);
    isLoading.value = true; // 🔄 active le loader

    if(sourceOTP == "FromForgetPassword"){
      final result = await authRepo.verifyResetOtp(email: email, otp: otpCode.value);
      isLoading.value = false; // 🛑 stop le loader
      FullScreenLoader.stopLoading();


      //MessageSnackBar.informationToast(title: 'Information : $email', message: "${result.message}");

      if (result.success) {
        isOtpError.value = false;
        errorMessage.value = '';
        await PrefUtils.setOTP(otpCode.value);

        MessageSnackBar.successSnackBar(title: 'تم التحقق بنجاح', message: result.message ?? '');

        Get.toNamed(Routes.resetPasswordScreen, arguments: {
          "OTP" : otpCode.value,
          "Email" : email,
        });
      }
      else
      {
        isOtpError.value = true;
        //errorMessage.value = 'رمز التحقق غير صالح أو منتهي الصلاحية';
        errorMessage.value = result.message ?? 'رمز التحقق غير صالح أو منتهي الصلاحية';
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: errorMessage.value);
      }

    } else {
      //OTP Create Account
      final result = await authRepo.verifyOtp(email: email, otp: otpCode.value);
      isLoading.value = false; // 🛑 stop le loader
      FullScreenLoader.stopLoading();


      //MessageSnackBar.informationToast(title: 'Information : $email', message: "${result.message}");

      if (result.success) {
        isOtpError.value = false;
        errorMessage.value = '';
        await PrefUtils.setOTP(otpCode.value);

        MessageSnackBar.successSnackBar(title: 'تم التحقق بنجاح', message: result.message ?? '');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPSuccessScreen()),
        );
      }
      else
      {
        isOtpError.value = true;
        //errorMessage.value = 'رمز التحقق غير صالح أو منتهي الصلاحية';
        errorMessage.value = result.message ?? 'رمز التحقق غير صالح أو منتهي الصلاحية';
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: errorMessage.value);
      }
    }

  }

  /// ✅ Renvoie un nouveau OTP
  Future<void> resendOtpFn() async {
    FullScreenLoader.openLoadingDialog('إعادة إرسال الرمز...', ImageConstant.lottieLoading);

    final result = await authRepo.resendOtp(email: email);

    FullScreenLoader.stopLoading();

    if (result.success) {
      MessageSnackBar.successSnackBar(title: 'تم الإرسال', message: result.message ?? '');
      canResend.value = false;
      animationController?.reset();
      animationController?.forward();
    } else {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'تعذر إعادة إرسال الرمز');
    }
  }

  /*saveOTPFn(BuildContext context) async {
    try {
      if(otpCode.value.length == 6){
        if(sourceOTP == "FromForgetPassword"){
          Get.toNamed(Routes.changePasswordScreen);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OTPSuccessScreen()),
          );
        }
        MessageSnackBar.successSnackBar(title: 'Successfully', message: "تم ادخال الرمز الصحيح");
      }
       else {
        MessageSnackBar.warningSnackBar(title: 'Warnning', message: "الرجاء ادخال الرمز");
      }
    }
    catch (exception) {
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      //isDataProcessing.value = false;
    }
  } */
}