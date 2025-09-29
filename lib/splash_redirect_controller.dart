import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashRedirectController extends GetxController {
  static SplashRedirectController get instance => Get.find();


  ///Called from main.dart on app launch
  @override
  void onReady() {
    //Remove the native splash screen
    FlutterNativeSplash.remove();
    //Redirect to the appropriate screen
    screenRedirect();
  }

  ///Function to show relevant screen
  screenRedirect() async {
    //Get.offAllNamed(Routes.onboardingScreen);
    if (PrefUtils.isFirstTime()) {
      Get.offAllNamed(Routes.onboardingScreen);
    } else if (!PrefUtils.isLoggedIn()) {
      Get.offAllNamed(Routes.signInScreen);
    } else {
      Get.offAllNamed(Routes.navigationScreen);
    }
  }
}