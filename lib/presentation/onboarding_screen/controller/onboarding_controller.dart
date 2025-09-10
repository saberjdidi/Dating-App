import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

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

  /// Jump to the specific dot selected page
  void dotNavigationCLick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Update current index & jump to the next page
   nextPage() async {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      ///await PrefUtils.setIsFirstTime(false);
      //Get.offAll(Routes.signInScreen);
      Get.offAllNamed(Routes.signInScreen);
  }

  /// Update current index & jump to the last page
  void skipPage(){
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}