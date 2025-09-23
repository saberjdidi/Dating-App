
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class PassswordSuccessScreen extends StatelessWidget {
  const PassswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    imagePath: ImageConstant.successOTPImage,
                    height: 180.adaptSize,
                    width: 180.adaptSize,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections.fSize),
                Center(child: TitleWidget(title: "إعادة تعيين كلمة المرور", textAlign: TextAlign.center,)),
                Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SubTitleWidget(subtitle: "تم تحديث كلمة مرورك بنجاح. يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة.",
                      textAlign: TextAlign.center,),
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections.fSize * 2),
                Center(
                  child: CustomButtonContainer(
                    text: "تسجيل الدخول",
                    color1: TColors.yellowAppDark,
                    color2: TColors.yellowAppLight,
                    borderRadius: 10,
                    colorText: TColors.white,
                    fontSize: 20.adaptSize,
                    width: Get.width,
                    textAlign: TextAlign.center,
                    onPressed: () async {
                      Get.offAllNamed(Routes.navigationScreen);
                    },
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
