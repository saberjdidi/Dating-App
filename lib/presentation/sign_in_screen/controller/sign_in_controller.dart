import 'dart:convert';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/message_snackbar.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/repositories/authentication_repository.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../routes/routes.dart';

class SignInController extends GetxController {

  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();

  //final apiClient = Get.find<ApiClient>();

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
  Future<void> emailAndPasswordSignIn() async {
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
    /* finally {
      //Remove Loader
      TFullScreenLoader.stopLoading();
    } */
  }

  loginFn() async {
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
   ///Using http
   /*
      await apiClient.loginDeviceAuth(
          {
            "email": emailController.text.trim(),
            "password": passwordController.text.trim()
          })
          .then((response) async {
            var accessToken =  response.accessToken;
              //var result = await jsonDecode(response);
              //var accessToken =  result['token'];
              debugPrint('accessToken : $accessToken');
              await PrefUtils.setToken(accessToken.toString());

                  ///Getting User details
                  await apiClient.getUserDetails(PrefUtils.getToken())
                      .then((responseUser) async {
                       debugPrint('responseUser : $responseUser');
                        final idUser = responseUser.id;
                        final firstname = responseUser.firstname;
                        final lastname = responseUser.lastname;
                        final email = responseUser.email;
                        final phoneNumber = responseUser.phone;
                       ///Dynamic Data
                        await PrefUtils.setUserId(idUser.toString());
                        await PrefUtils.setFirstname(firstname.toString());
                        await PrefUtils.setLastName(lastname.toString());
                        await PrefUtils.setEmail(email.toString());
                        await PrefUtils.setPhoneNumber(phoneNumber.toString());
                        await PrefUtils.setLogoUser(responseUser.profileImage.toString());

                        ///Static Data
                        //await PrefUtils.setPhoneNumber('+21626440678');

                        Get.offAllNamed(Routes.navigationScreen);
                        //Get.toNamed(Routes.otpVerificationScreen);
                  })
                    .onError((errorUser, stackTrace){
                    debugPrint('Error User : $errorUser');
                  });
      })
          .onError((error, stackTrace){
            //MessageSnackBar.errorSnackBar(title: 'Warning', message: 'Invalid Credentials');
            MessageSnackBar.errorToast(
                title: 'Warning',
                message: "Invalid Credentials",
                position: SnackPosition.BOTTOM,
                duration: 3);
            debugPrint('error login : ${error.toString()}');
            //Get.snackbar('Error', error.toString(), colorText: Colors.red, snackPosition: SnackPosition.BOTTOM);
          });
*/

    }
    catch (exception) {
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      //isDataProcessing.value = false;
    }
  }

}