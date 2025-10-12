
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
    var _appTheme = PrefUtils.getTheme();

    return Align(
      //bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      //left: TSizes.defaultSpace,
      child: Obx(() => AnimatedSmoothIndicator(
        activeIndex: controller.currentPageIndex.value,
        count: 3,
        effect: ScrollingDotsEffect(
          spacing: 6,
          activeDotColor: TColors.primaryColorApp,
          //activeDotColor: theme.colorScheme.primary,
          dotColor: _appTheme =='light' ? TColors.greyDating : TColors.darkGrey,
          dotHeight: 8.adaptSize,
          dotWidth: 8.adaptSize,
          offset: 8.adaptSize
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