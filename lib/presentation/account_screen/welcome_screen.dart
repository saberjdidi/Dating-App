import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/controller/welcome_controller.dart';
import 'package:dating_app_bilhalal/widgets/gradient/gradient_text.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends GetWidget<WelcomeController> {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override Widget build(BuildContext context) {
    var _appTheme = PrefUtils.getTheme();
    mediaQueryData = MediaQuery.of(context);
    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final isMobile = shortestSide < 600;
    final isTablet = shortestSide < 1000;

    return Scaffold(
      backgroundColor: TColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(18.hw),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CustomImageView(
                    imagePath: ImageConstant.logo,
                    height: 100.adaptSize,
                    width: 100.adaptSize,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections.fSize),
                Center(child: TitleWidget(title: "مرحباً بكم في", textAlign: TextAlign.center,)),
                GradientText(
                  text: "بالحلال",
                  fontSize: 32.adaptSize,
                  textAlign: TextAlign.center,
                  gradient: const LinearGradient(
                    colors: [TColors.primaryColorApp, TColors.primaryColorApp], // green gradient
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections.fSize),
                Center(
                  child: CustomImageView(
                    imagePath: ImageConstant.loadingImage,
                    //height: 100.adaptSize,
                    //width: 100.adaptSize,
                    //fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 15.v,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}