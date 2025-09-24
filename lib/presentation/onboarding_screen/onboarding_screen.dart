import 'dart:ui';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/controller/onboarding_controller.dart';
import 'package:dating_app_bilhalal/widgets/onboarding/onboarding_dot_navigation.dart';
import 'package:dating_app_bilhalal/widgets/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeyOnBoarding = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Scaffold(
      key: _scaffoldKeyOnBoarding,
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.updatePageIndicator,
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: OnBoardingPage(
                image: ImageConstant.imgOnBoarding1,
                title: 'غالي',
                subTitle: 'سجل اليوم واستمتع بالشهر الأول من المزايا المميزة معنا.'
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: OnBoardingPage(
                image: ImageConstant.imgOnBoarding2,
                title: 'مباريات',
                subTitle: 'نقوم بمطابقتك مع الأشخاص الذين لديهم مجموعة كبيرة من الاهتمامات المتشابهة.'
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: OnBoardingPage(
                image: ImageConstant.imgOnBoarding3,
                title: 'خوارزمية',
                subTitle: 'يخضع المستخدمون لعملية فحص للتأكد من عدم مطابقتهم أبدًا مع الروبوتات.'
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: screenheight * 0.17,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* CarouselSlider.builder(
              carouselController: controller.carouselController,
              itemCount: onBoardingList.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.8,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  controller.updatePageIndicator(index);
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final data = onBoardingList[index];
                final bool isActive = index == controller.currentPageIndex.value;

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
                            Image.asset(data.image!, fit: BoxFit.cover),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ), */
              ///Dot Navigation SmoothPageIndicator
              const Directionality(
                  textDirection: TextDirection.rtl,
                  child: OnBoardingDotNavigation()
              ),

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
                  fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                  height: isSmallPhone ? 80.v : 70.v,
                  width: screenWidth * 0.8,
                  onPressed: () async {
                    await controller.onTapSignup();
                    //dialogVerifyAccount(context);
                  },
                ),
              ),
              //SizedBox(height: 10.v),
              Padding(
                padding: EdgeInsets.all(10.adaptSize),
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
                            onTap: () async {
                              await controller.onTapSignIn();
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
        ),
      ),
    );
  }
}
