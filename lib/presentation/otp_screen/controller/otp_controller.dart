import 'package:dating_app_bilhalal/core/utils/popups/message_snackbar.dart';
import 'package:dating_app_bilhalal/presentation/otp_screen/otp_success_screen.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:dating_app_bilhalal/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPController extends GetxController with GetSingleTickerProviderStateMixin {
  static OTPController get instance => Get.find();

  String sourceOTP = Get.arguments['SourceOTP'] ?? '';
  String email = Get.arguments['Email'] ?? '';

  AnimationController? animationController;
  RxInt levelClock = (2 * 60).obs;
  RxString otpCode = "".obs;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock.value));

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

  saveOTPFn(BuildContext context) async {
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
  }
}