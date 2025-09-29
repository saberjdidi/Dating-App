import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class SignUpWithEmailController extends GetxController {

  //final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final formSignUpKey = GlobalKey<FormState>();

  //final apiClient = Get.find<ApiClient>();

  var isRTL = true.obs;
  //Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //FocusNodes
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  Rx<bool> isShowPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
  }

  signupFn() async {
    try {

      final isValid = formSignUpKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formSignUpKey.currentState!.save();

      Get.toNamed(Routes.otpScreen, arguments: {
        "SourceOTP" : "FromSignup",
        "Email" : emailController.text.trim(),
      });
      /* Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OTPScreen()),
      ); */

    }
    catch (exception) {
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      //isDataProcessing.value = false;
    }
  }

/*
  checkEmail() async {
    try {
      //Get.offAllNamed(Routes.navigationScreen);

      final isValid = formSignUpKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formSignUpKey.currentState!.save();

      await apiClient.verifyEmail(
          {
            "email": emailController.text.trim()
          })
       .then((response) async {
        debugPrint('response : $response');
        Get.offAllNamed(Routes.inscriptionScreen, arguments: {
          "VerificationEmail" : emailController.text.trim()
        });

        //MessageSnackBar.successSnackBar(title: 'Successfully', message: 'Email created successfully. Please confirm your email.');
        MessageSnackBar.informationToast(
            title: 'Successfully',
            message: "Un e-mail de réinitialisation a été envoyé à votre adresse e-mail.",
            position: SnackPosition.BOTTOM,
            duration: 3);
      })
      .onError((error, stackTrace){
        //MessageSnackBar.errorSnackBar(title: 'Warning', message: 'La valeur du champ adresse courriel est déjà utilisée.');
        MessageSnackBar.errorToast(
            title: 'Information',
            message: "La valeur du champ adresse courriel est déjà utilisée.",
            position: SnackPosition.BOTTOM,
            duration: 3);
        debugPrint('error verify email : ${error.toString()}');
      });
    }
    catch (exception) {
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      //isDataProcessing.value = false;
    }
  }
  */
}