import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/datasources/onboarding_local_data_source.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/controller/onboarding_controller.dart';
import 'package:dating_app_bilhalal/widgets/onboarding/onboarding_dot_navigation.dart';
import 'package:dating_app_bilhalal/widgets/onboarding/onboarding_next_button.dart';
import 'package:dating_app_bilhalal/widgets/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
/*
    final List<Map<String, String>> onboardingData = [
      {
        'image': ImageConstant.imgOnBoarding1,
        'title': 'غالي',
        'subTitle': 'سجل اليوم واستمتع بالشهر الأول من المزايا المميزة معنا.'
      },
      {
        'image': ImageConstant.imgOnBoarding2,
        'title': 'مباريات',
        'subTitle': 'نقوم بمطابقتك مع الأشخاص الذين لديهم مجموعة كبيرة من الاهتمامات المتشابهة.'
      },
      {
        'image': ImageConstant.imgOnBoarding3,
        'title': 'خوارزمية',
        'subTitle': 'يخضع المستخدمون لعملية فحص للتأكد من عدم مطابقتهم أبدًا مع الروبوتات.'
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          /// Slider
          CarouselSlider.builder(
            carouselController: controller.carouselController,
            itemCount: onboardingData.length,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.6,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                controller.updatePageIndicator(index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final data = onboardingData[index];
              final bool isActive = index == controller.currentPageIndex.value; // ← utilisé ici

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 1, end: isActive ? 1.0 : 0.85),
                duration: const Duration(milliseconds: 300),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(data['image']!, fit: BoxFit.cover),
                          if (!isActive)
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(color: Colors.black.withOpacity(0)),
                            ),
                          // autres widgets
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(height: 16),

          /// Dot Indicator
        ///Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          const SizedBox(height: 20),

          /// Button
          ElevatedButton(
            onPressed: () => controller.nextPage(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                'إنشاء حساب',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ); */


    return Scaffold(
      body: Column(
        children: [
          ///Horizontal Scrollable Pages
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnBoardingPage(
                    image: ImageConstant.imgOnBoarding1,
                    title: 'غالي',
                    subTitle: 'سجل اليوم واستمتع بالشهر الأول من المزايا المميزة معنا.'
                ),
                OnBoardingPage(
                    image: ImageConstant.imgOnBoarding2,
                    title: 'مباريات',
                    subTitle: 'نقوم بمطابقتك مع الأشخاص الذين لديهم مجموعة كبيرة من الاهتمامات المتشابهة.'
                ),
                OnBoardingPage(
                    image: ImageConstant.imgOnBoarding3,
                    title: 'خوارزمية',
                    subTitle: 'يخضع المستخدمون لعملية فحص للتأكد من عدم مطابقتهم أبدًا مع الروبوتات.'
                ),
              ],
            ),
          ),
        /*
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: onBoardingList.length,
              onPageChanged: controller.updatePageIndicator,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Obx(() {
                  final isActive = controller.currentPageIndex.value == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        if (isActive)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            onBoardingList[index].image!,
                            fit: BoxFit.cover,
                          ),
                          if (!isActive) // Blur uniquement les côtés
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          */

          ///Skip Button
          //const OnBoardingSkip(),

          ///Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          ///Circular Button
          //const OnBoardingNextButton(),
          SizedBox(height: 10.v),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
            child:  CustomButtonContainer(
              text: 'إنشاء حساب',
              color1: TColors.yellowAppDark,
              color2: TColors.yellowAppLight,
              borderRadius: 10,
              colorText: TColors.white,
              fontSize: 20.adaptSize,
              onPressed: () async {
               await controller.nextPage();
                //dialogVerifyAccount(context);
              },
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 1.v),
                        child: Text("هل لديك حساب بالفعل؟ ",
                            style:  isTablet
                                ? Theme.of(context).textTheme.titleMedium!.apply(color: TColors.gray700)
                                : CustomTextStyles.bodyMediumTextFormFieldGrey)
                    ),
                    GestureDetector(
                        onTap: () {
                          //onTapTxtSignUp();
                        },
                        child: Padding(padding: EdgeInsets.only(left: 8.hw),
                            child: Text("تسجيل الدخول",
                              //style: CustomTextStyles.titleMediumBlueVPT
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: TColors.yellowAppDark,
                                fontSize: 16.fSize,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                        )
                    )
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
