import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/subscribe_screen/controller/subscribe_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_outlined_button.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SubscribeScreen extends GetView<SubscribeController> {
   SubscribeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeySubscribe = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils().getThemeData();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: _appTheme =='light' ? TColors.white : appTheme.primaryColor,
        key: _scaffoldKeySubscribe,
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          title: TitleWidget(title: "الاشتراک", fontWeightDelta: 3, color: TColors.buttonSecondary,),
          showAction: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: TSizes.spaceBtwItems.v),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: TitleWidget(title: 'اختر الخطة', textAlign: TextAlign.end,)
                ),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: SubTitleWidget(subtitle: 'افتح ميزات حصرية وتواصل مع المزيد من الأعضاء.',)
                ),
                SizedBox(height: TSizes.spaceBtwItems.v),

                TRoundedContainer(
                    showBorder: true,
                    borderColor: controller.subscribeValue.value == 0 ? TColors.yellowAppDark : TColors.greyDating,
                    radius: 20.adaptSize,
                    margin: EdgeInsets.symmetric(vertical: 10.adaptSize),
                    padding: EdgeInsets.all(15.adaptSize),
                    backgroundColor: controller.subscribeValue.value == 0 ? TColors.redSubscriptionCard : TColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: controller.subscribeValue.value,
                          onChanged: (value) {
                            controller.subscribeValue.value = value!;
                            debugPrint(" اشتراک ذهبي : ${controller.subscribeValue.value}");
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return TColors.yellowAppDark; // ✅ Cercle actif jaune
                            }
                            return Colors.grey; // Cercle inactif gris
                          }),
                        ),
                        Column(
                          children: [
                            Text('اشتراک ذهبي',
                                style: CustomTextStyles.headlineSmallBlack
                            ),
                            SubTitleWidget(subtitle: "\$14.99/month")
                          ],
                        )
                      ],
                    )
                ),

                TRoundedContainer(
                    showBorder: true,
                    borderColor: controller.subscribeValue.value == 1 ? TColors.yellowAppDark : TColors.greyDating,
                    radius: 20.adaptSize,
                    margin: EdgeInsets.symmetric(vertical: 10.adaptSize),
                    padding: EdgeInsets.all(15.adaptSize),
                    backgroundColor: controller.subscribeValue.value == 1 ? TColors.redSubscriptionCard : TColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: controller.subscribeValue.value,
                          onChanged: (value) {
                            controller.subscribeValue.value = value!;
                            debugPrint(" اشتراک : ${controller.subscribeValue.value}");
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return TColors.yellowAppDark; // ✅ Cercle actif jaune
                            }
                            return Colors.grey; // Cercle inactif gris
                          }),
                        ),
                        Column(
                          children: [
                            Text('اشتراک',
                                style: CustomTextStyles.headlineSmallBlack
                            ),
                            SubTitleWidget(subtitle: "\$14.99/month"),
                            SubTitleWidget(subtitle: "500 رسالة"),
                            SubTitleWidget(subtitle: "إعجابات غير محدودة"),
                            SubTitleWidget(subtitle: "انتقاد غير محدود"),
                          ],
                        )
                      ],
                    )
                ),

                TRoundedContainer(
                    showBorder: true,
                    borderColor: controller.subscribeValue.value == 2 ? TColors.yellowAppDark : TColors.greyDating,
                    radius: 20.adaptSize,
                    margin: EdgeInsets.symmetric(vertical: 10.adaptSize),
                    padding: EdgeInsets.all(15.adaptSize),
                    backgroundColor: controller.subscribeValue.value == 2 ? TColors.redSubscriptionCard : TColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Radio<int>(
                          value: 2,
                          groupValue: controller.subscribeValue.value,
                          onChanged: (value) {
                            controller.subscribeValue.value = value!;
                            debugPrint(" اشتراک  ${controller.subscribeValue.value}");
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return TColors.yellowAppDark; // ✅ Cercle actif jaune
                            }
                            return Colors.grey; // Cercle inactif gris
                          }),
                        ),
                        Column(
                          children: [
                            Text('اشتراک',
                                style: CustomTextStyles.headlineSmallBlack
                            ),
                            SubTitleWidget(subtitle: "\$9.99/month")
                          ],
                        )
                      ],
                    )
                ),

                TRoundedContainer(
                    showBorder: true,
                    borderColor: controller.subscribeValue.value == 3 ? TColors.yellowAppDark : TColors.greyDating,
                    radius: 20.adaptSize,
                    margin: EdgeInsets.symmetric(vertical: 10.adaptSize),
                    padding: EdgeInsets.all(15.adaptSize),
                    backgroundColor: controller.subscribeValue.value == 3 ? TColors.redSubscriptionCard : TColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Radio<int>(
                          value: 3,
                          groupValue: controller.subscribeValue.value,
                          onChanged: (value) {
                            controller.subscribeValue.value = value!;
                            debugPrint(" اشتراکالماس  ${controller.subscribeValue.value}");
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return TColors.yellowAppDark; // ✅ Cercle actif jaune
                            }
                            return Colors.grey; // Cercle inactif gris
                          }),
                        ),
                        Column(
                          children: [
                            Text('اشتراک الماس',
                                style: CustomTextStyles.headlineSmallBlack
                            ),
                            SubTitleWidget(subtitle: "\$9.99/month")
                          ],
                        )
                      ],
                    )
                ),

              ],
            )),
          ),
        ),
        bottomNavigationBar: Container(
          height: 170.v,
          padding: EdgeInsets.only(bottom: 5.v, left: TSizes.spaceBtwItems.hw, right: TSizes.spaceBtwItems.hw),
          child: Column(
            children: [
              Center(
                child: CustomButtonContainer(
                  text: "استمرار",
                  color1: TColors.yellowAppDark,
                  color2: TColors.yellowAppLight,
                  borderRadius: 10,
                  colorText: TColors.white,
                  fontSize: 20.adaptSize,
                  width: Get.width,
                  onPressed: () async {

                  },
                ),
              ),
              SizedBox(height: 15.v,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomOutlinedButton(
                  height: 70.v,
                  buttonTextStyle: CustomTextStyles.titleLargeBlackGrey,
                  buttonStyle: CustomButtonStyles.outlineBlack,
                  text: "اتصل بالدعم",
                  margin: EdgeInsets.only(top: 6.hw),
                  borderRadius: 100.hw,
                  onPressed: (){

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
