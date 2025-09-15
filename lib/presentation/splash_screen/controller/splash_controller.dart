import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1500), (){
      ///Using with deep link
     /* if (!Get.parameters.containsKey('token') && !Get.parameters.containsKey('email')) {
        //Get.offAllNamed(Routes.navigationScreen);

        if((PrefUtils.getEmpreinteDigitale().toString().isEmpty || PrefUtils.getEmpreinteDigitale() == null) &&
            (PrefUtils.getAuthentication2Facteurs().toString().isEmpty || PrefUtils.getAuthentication2Facteurs() == null)){
          if(PrefUtils.getEmail() != null && PrefUtils.getToken() != null){
            Get.offAllNamed(Routes.navigationScreen);
          }
          else {
            (PrefUtils.getOnBoarding() == 'OnBoarding' && PrefUtils.getOnBoardingCheckCondition() == 'OnBoardingCheckCondition') ? Get.offAllNamed(Routes.signInScreen): Get.offAllNamed(Routes.onboardingScreen1);
          }
        }
        else {
          Navigator.of(Get.overlayContext!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LocalAuthScreen()), (Route<dynamic> route) => false);
        }

      } */

      Get.offAllNamed(Routes.navigationScreen);
      ///Without deep link
    /*  if(PrefUtils.getEmail() != null){
        Get.offAllNamed(Routes.navigationScreen);
      }
      else {
        PrefUtils.getOnBoarding() == 'OnBoarding' ? Get.offAllNamed(Routes.signInScreen): Get.offAllNamed(Routes.onboardingScreen);
      }
       */
      ///Get.offAllNamed(Routes.navigationScreen);
    });
  }
}