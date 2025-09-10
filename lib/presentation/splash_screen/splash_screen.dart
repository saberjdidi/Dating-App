import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/splash_screen/controller/splash_controller.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
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
        child: CircularContainer(
          child: Image.asset(ImageConstant.logo),
        ),
      ),
    );
  }
}