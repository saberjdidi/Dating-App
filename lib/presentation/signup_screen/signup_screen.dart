import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/datasources/onboarding_local_data_source.dart';
import 'package:dating_app_bilhalal/presentation/signup_screen/controller/signup_controller.dart';
import 'package:dating_app_bilhalal/widgets/custom_term_privacy_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/social_button_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({super.key});

  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: TSizes.spaceBtwSections),
            /// Slider
            CarouselSlider.builder(
              carouselController: controller.carouselController,
              itemCount: ImagesDatingList.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.55,
                viewportFraction: isTablet ? 0.6 : 0.7,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  controller.updatePageIndicator(index);
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final data = ImagesDatingList[index];
                final bool isActive = index == controller.currentPageIndex.value; // ← utilisé ici

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1, end: isActive ? 1.0 : 0.85),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(data.image!, fit: BoxFit.cover),
                           /* if (!isActive)
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(color: Colors.black.withOpacity(0)),
                              ), */
                            // autres widgets
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

             SizedBox(height: 20.v),
            TitleWidget(title: "اشتراک",
              color: _appTheme =='light' ? TColors.black : TColors.yellowAppDark,
              fontSizeDelta: 2,
              textAlign: TextAlign.center,),

            SizedBox(height: 20.v),

            /// Button
            CustomButtonContainer(
              text: 'تواصل عبر البريد الإلكتروني',
              color1: TColors.yellowAppDark,
              color2: TColors.yellowAppLight,
              borderRadius: 10,
              colorText: TColors.black,
              textAlign: TextAlign.center,
              fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
              height: isSmallPhone ? 80.v : 70.v,
              width: screenWidth * 0.8,
              onPressed: () async {
                await controller.nextPage();
                //dialogVerifyAccount(context);
              },
            ),

            SizedBox(height: 20.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Divider(color: _appTheme =='light' ? TColors.black54 : TColors.white, thickness: 0.3, indent: 60, endIndent: 5,)),
                Text("أو قم بالتسجيل مع".tr,
                  style:Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: _appTheme =='light' ?TColors.black54 : TColors.white,
                    fontSize: 18.fSize,
                    fontWeight: FontWeight.w400,
                    //decoration: TextDecoration.underline
                  )

                ),
                Flexible(child: Divider(color: _appTheme =='light' ? TColors.black54 : TColors.white, thickness: 0.3, indent: 5, endIndent: 60)),
              ],
            ),
          /*  Align(
                alignment: Alignment.center,
                child: GestureDetector(onTap: () {
                },
                    child: Text("أو قم بالتسجيل مع".tr,
                      style: _appTheme =='light'
                          ? Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: TColors.black54,
                        fontSize: 18.fSize,
                        fontWeight: FontWeight.w600,
                        //decoration: TextDecoration.underline
                      )
                          : CustomTextStyles.titleMediumBlueVPT,

                    )
                )
            ), */

            ///Divider
            //FormDividerWidget(dividerText: TTexts.orSignInWith.capitalize!),

            const SizedBox(height: TSizes.xs),

            ///Footer
            SocialButtonsWidget(width: 70.adaptSize, height: 70.adaptSize,),

            SizedBox(height: 10.v),

            CustomTermPrivacyWidget(),
          ],
        ),
      ),
    );
  }

}