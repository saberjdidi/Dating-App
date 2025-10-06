import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/splash_screen/controller/splash_controller.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final isMobile = shortestSide < 600;
    final isTablet = shortestSide < 1000;

    return Container(
      decoration: BoxDecoration(
        color: TColors.white
      ),
      child: Center(
        //child: Image.asset(ImageConstant.logo),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstant.logoHeader,
              height: 220.adaptSize,
              width: 220.adaptSize,),
            GradientText(
              text: "بالحلال",
              fontSize: 60.adaptSize,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              gradient: const LinearGradient(
                colors: [TColors.yellowAppLight, TColors.yellowAppDark], // green gradient
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}