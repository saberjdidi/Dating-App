import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/controller/success_account_controller.dart';
import 'package:dating_app_bilhalal/widgets/animation_loader.dart';
import 'package:flutter/material.dart';

class SuccessAccountScreen extends GetWidget<SuccessAcountController> {
const SuccessAccountScreen({Key? key}) : super(key: key);

@override Widget build(BuildContext context) {
mediaQueryData = MediaQuery.of(context);
var size = MediaQuery.of(context).size;
var shortestSide = MediaQuery.of(context).size.shortestSide;
final isMobile = shortestSide < 600;
final isTablet = shortestSide < 1000;

return Scaffold(
  backgroundColor: TColors.white,
  body: Center(
    child: AnimationLoaderWidget(
      text: 'شكرا لك على إكمال الملف الشخصي',
      animation: ImageConstant.lottieTrophy,
      showAction: false,
      //actionText: 'Let\'s fill it',
      //onActionPressed: (){},
    ),
  ),
);
}
}