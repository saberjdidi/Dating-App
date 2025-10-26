import 'dart:convert';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/message_snackbar.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/repositories/auth_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/authentication_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/profile_repository.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';

class SignInController extends GetxController {

  //final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  final formLoginKey = GlobalKey<FormState>().obs;

  final authRepo = AuthRepository();

  RxBool isDataProcessing = false.obs;
  var isRTL = true.obs;
  //Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //FocusNodes
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  Rx<bool> isShowPassword = true.obs;
  Rx<bool> rememberme = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();
  }

  /// Email and Password Sign In
 /* Future<void> emailAndPasswordSignIn() async {
    try {
      //Start Loading
      FullScreenLoader.openLoadingDialog('Logging you in...', ImageConstant.lottieTrophy);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      //if(!loginFormKey.currentState!.validate()) return;
      if(!formLoginKey.currentState!.validate()) {
        //Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      //Login user
      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());

      //Remove Loader
      FullScreenLoader.stopLoading();

      await PrefUtils.setEmail(emailController.text.trim());

      //set Tab index of the main screen
     await BottomBarController.instance.changeTabIndex(2);
      //Redirect
      Get.offAllNamed(Routes.navigationScreen);
      //Show success message
      MessageSnackBar.successSnackBar(title: 'Successfully', message: 'Login with ${emailController.text.trim()}');
    }
    catch(e){
      //Remove Loader
      FullScreenLoader.stopLoading();

      //Show some generic error to the user
      MessageSnackBar.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
     finally {
      //Remove Loader
       FullScreenLoader.stopLoading();
    }
  } */

  loginFn() async {
    try {

   final isValid = formLoginKey.value.currentState!.validate();
      if (!isValid) {
        return;
      }
      formLoginKey.value.currentState!.save();

   isDataProcessing.value = true;
   FullScreenLoader.openLoadingDialog('We are processing your information', ImageConstant.lottieLoading);

   //Check internet connection
   final isConnected = await NetworkManager.instance.isConnected();
   if(!isConnected) {
     //Remove Loader
     FullScreenLoader.stopLoading();
     MessageSnackBar.customToast(message: 'No Internet Connection');
     return;
   }

   final result = await authRepo.login(email: emailController.text.trim(), password: passwordController.text.trim());
   //Remove Loader
   FullScreenLoader.stopLoading();

   if (result.success) {
     isDataProcessing.value = false;
     await PrefUtils.setToken(result.data!.token!);
     await PrefUtils.setEmail(result.data!.user!.email!);
     await PrefUtils.setUsername(result.data!.user!.username!);
     await PrefUtils.setId(result.data!.user!.id!);
     await PrefUtils.setPassword(passwordController.text.trim());

     //debugPrint('data login : ${result.data!.user!.email} - ${result.data!.user!.id} - ${result.data!.user!.username} - ${result.data?.token}');

     //set Tab index of the main screen and open dialog search
     await BottomBarController.instance.changeTabIndex(2);
     Get.offAllNamed(Routes.navigationScreen);
     MessageSnackBar.successSnackBar(title: 'Successfully', message: result.message ?? 'Authentification initiée');
     debugPrint('data login : ${PrefUtils.getToken()} - ${PrefUtils.getEmail()} - ${PrefUtils.getId()} - ${PrefUtils.getUsername()}');

     //Profile image
     final profileResult = await ProfileRepository().myProfile();
     if (profileResult.success) {
       var urlProfile = profileResult.data!.mainProfile ?? "";
       await PrefUtils.setImageProfile(urlProfile);
       debugPrint("URL Profile : ${PrefUtils.getImageProfile()}");
     } else {
       MessageSnackBar.errorSnackBar(title: 'خطأ', message: profileResult.message ?? 'An error occured');
     }
   } else {
     isDataProcessing.value = false;
     MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'Erreur serveur');
   }
    }
    catch (exception) {
      isDataProcessing.value = false;
      debugPrint('Exception : ${exception.toString()}');
      FullScreenLoader.stopLoading();
      //Show some generic error to the user
      MessageSnackBar.errorSnackBar(title: 'Oh Snap!', message: exception.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

 /* loginFnStatic() async {
    try {

      final isValid = formLoginKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formLoginKey.currentState!.save();

      await PrefUtils.setEmail(emailController.text.trim());

      //set Tab index of the main screen and open dialog search
      await BottomBarController.instance.changeTabIndex(2);
      Get.offAllNamed(Routes.navigationScreen);
      MessageSnackBar.successSnackBar(title: 'Successfully', message: 'Login with ${emailController.text.trim()}');

    }
    catch (exception) {
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      //isDataProcessing.value = false;
    }
  } */

}