import 'dart:convert';

import 'package:dating_app_bilhalal/core/utils/message_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';

class SignInController extends GetxController {

  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();

  //final apiClient = Get.find<ApiClient>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
  }

  checkLogin(BuildContext context) async {
    try {

   final isValid = formLoginKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formLoginKey.currentState!.save();


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