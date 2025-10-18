import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/repositories/auth_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class SignUpWithEmailController extends GetxController {

  //final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final formSignUpKey = GlobalKey<FormState>();
  final authRepo = AuthRepository();

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
    if (formSignUpKey.currentState == null) return;
    if (!formSignUpKey.currentState!.validate()) return;
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      MessageSnackBar.errorToast(title: "Warning".tr, message: "Mot de passe ne correspondent pas");
      return;
    }
    try {
      debugPrint('We are processing your information');
      //Start Loading
      FullScreenLoader.openLoadingDialog('We are processing your information...', ImageConstant.lottieLoading);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        FullScreenLoader.stopLoading();
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      final result = await authRepo.register(email: emailController.text.trim(), password: passwordController.text.trim());
      //Remove Loader
      FullScreenLoader.stopLoading();
      //Register user in the Firebase authentication & save user data in the Firebase
      // await AuthenticationRepository.instance.registerWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());

      if (result.success) {
        // sauvegarde email ou naviguer vers OTP
        await PrefUtils.setToken(result.data!.token!);
        await PrefUtils.setEmail(result.data!.user!.email!);
        Get.toNamed(Routes.otpScreen, arguments: {
          "SourceOTP" : "FromSignup",
          "Email" : emailController.text.trim(),
        });
        MessageSnackBar.successSnackBar(title: 'Successfully', message: result.message ?? 'Inscription initiée');
      } else {
        MessageSnackBar.errorSnackBar(title: 'Erreur', message: result.message ?? 'Erreur serveur');
      }
      /*
       Get.toNamed(Routes.otpScreen, arguments: {
        "SourceOTP" : "FromSignup",
        "Email" : emailController.text.trim(),
      });
      await PrefUtils.setToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxNCIsImVtYWlsIjoic2FiZXJqZGlkaTRAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NjA3OTk1MTQsImV4cCI6MTc2MTQwNDMxNH0.F6EcG81HhkriXCy1pHwn1fccN-OQYG-APGV6ajuOFxg");
      await PrefUtils.setEmail(emailController.text.trim());
       */
    }
    catch (exception) {
      debugPrint('Exception : ${exception.toString()}');
      FullScreenLoader.stopLoading();
      //Show some generic error to the user
      MessageSnackBar.errorSnackBar(title: 'Oh Snap!', message: exception.toString());
    } finally {
      //isDataProcessing.value = false;
    }
  }
}