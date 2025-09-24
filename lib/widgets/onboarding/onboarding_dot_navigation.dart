
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller = OnBoardingController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Align(
      //bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      //left: TSizes.defaultSpace,
      child: Obx(() => AnimatedSmoothIndicator(
        activeIndex: controller.currentPageIndex.value,
        count: 3,
        effect: ScrollingDotsEffect(
          spacing: 6,
          activeDotColor: TColors.yellowAppDark,
          //activeDotColor: theme.colorScheme.primary,
          dotColor: TColors.textSecondary,
          dotHeight: 8.v,
          dotWidth: 8.hw,
        ),
      ))
    /*  child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationCLick,
        count: 3,
        effect: ExpandingDotsEffect(activeDotColor: dark ? TColors.light : TColors.dark, dotHeight: 6),
      ), */
    );
  }
}