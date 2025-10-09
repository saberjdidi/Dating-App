import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1500), () async {

      //Get.offAllNamed(Routes.createAccountScreen);
      //Get.offAllNamed(Routes.onboardingScreen);
      //Get.offAllNamed(Routes.navigationScreen);
      // Si premier lancement → OnBoarding
      if (PrefUtils.isFirstTime()) {
        Get.offAllNamed(Routes.onboardingScreen);
      }
      // Si pas premier lancement mais pas connecté → SignIn
      else if (!PrefUtils.isLoggedIn()) {
        Get.offAllNamed(Routes.signInScreen);
      }
      // Si déjà connecté → Home
      else {
        Get.offAllNamed(Routes.navigationScreen);
        //set Tab index of the main screen and open dialog search
        await BottomBarController.instance.changeTabIndex(2);
      }
    });
  }
}