import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  ///Variables
  //final pageController = PageController(viewportFraction: 0.7);
  final pageController = PageController(viewportFraction: 0.8);
  //final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  final CarouselController carouselController = CarouselController();

  /// Update Current Index When Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //final isBoarding = PrefUtils.getIsBoarding();

  @override
  void onInit() {
    super.onInit();
    //PrefUtils.setIsFirstTime(true);
    PrefUtils.setIsBoarding("true");
  }

  /// Update current index & jump to the next page
  nextPage() async {
    final storage = GetStorage();
    storage.write('IsFirstTime', false);
    ///await PrefUtils.setIsFirstTime(false);
    //Get.offAll(Routes.signInScreen);
    Get.offAllNamed(Routes.signUpWithEmailScreen);
  }

}