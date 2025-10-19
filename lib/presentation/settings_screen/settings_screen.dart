import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/settings_screen/controller/settings_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_divider.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/swip_back_wrapper.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends GetWidget<SettingsController> {
   SettingsScreen({Key? key}) : super(key: key);

  var _appTheme = PrefUtils.getTheme();

  @override Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final isMobile = shortestSide < 600;
    final isTablet = shortestSide < 1000;

    return SwipeBackWrapper(
      child: Scaffold(
        //backgroundColor: TColors.white,
        appBar: TAppBar(
          //showBackArrow: true,
          //rightToLeft: true,
          title: TitleWidget(title: "إعدادات الاتصال", fontWeightDelta: 2,
            color:_appTheme =='light' ? TColors.buttonSecondary : TColors.white),
          /*title: Text('إعدادات الاتصال',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: TColors.black,
              fontSize: 22.fSize,
              fontWeight: FontWeight.bold,
              //decoration: TextDecoration.underline,
              decorationColor: TColors.black,
            ),
          ), */
        ),
        body: Padding(
          padding: EdgeInsets.all(18.hw),
          child: SingleChildScrollView(
            child: Obx(() => Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitleWidget(
                          subtitle: 'مكالمات الفيديو',
                          color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                          fontWeightDelta: 2,
                          fontSizeDelta: 1),
                      Switch(
                        value: controller.isCallVideo.value,
                        onChanged: controller.toggleCallVideo,
                       /* onChanged: (value){
                          controller.isCallVideo.value = value;
                          debugPrint("call video : ${controller.isCallVideo.value}");
                        }, */
                        activeColor: TColors.primaryColorApp,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.v),
                    child: CustomDividerWidget(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitleWidget(
                          subtitle: 'المكالمات الصوتية',
                          color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                          fontWeightDelta: 2,
                          fontSizeDelta: 1),
                      Switch(
                        value: controller.isCallVoice.value,
                        onChanged: controller.toggleCallVoice,
                       /* onChanged: (value){
                          controller.isCallVoice.value = value;
                          debugPrint("call voice : ${controller.isCallVoice.value}");
                        }, */
                        activeColor: TColors.primaryColorApp,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.v),
                    child: CustomDividerWidget(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitleWidget(
                          subtitle: 'حالة الاتصال بالإنترنت',
                          color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                          fontWeightDelta: 2,
                          fontSizeDelta: 1
                      ),
                      Switch(
                        value: controller.isInternetConnection.value,
                        onChanged: (value){
                          controller.isInternetConnection.value = value;
                          debugPrint("internet connection : ${controller.isInternetConnection.value}");
                        },
                        activeColor: TColors.primaryColorApp,
                      )
                    ],
                  ),
                ],
              ),
            )),
          ),
        )
      ),
    );
  }
}