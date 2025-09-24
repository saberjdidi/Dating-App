import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/subscribe_screen/controller/subscribe_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';


class UpdateSubscribeScreen extends GetView<SubscribeController> {
  UpdateSubscribeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKeyUpdateSubscribe = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils().getThemeData();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: _appTheme == 'light' ? TColors.white : appTheme.primaryColor,
        key: _scaffoldKeyUpdateSubscribe,
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          title: TitleWidget(
            title: "الاشتراک",
            fontWeightDelta: 2,
            color: TColors.buttonSecondary,
          ),
          showAction: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
          child: Obx(() {
            final selectedPlan = controller.selectedPlan.value;
            final plans = controller.plans.value;

            // Séparer le plan choisi et les autres
            final currentPlan = plans.firstWhereOrNull((p) => p.title == selectedPlan?.title);
            final otherPlans = plans.where((p) => p.title != selectedPlan?.title).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: TSizes.spaceBtwItems.v),

                  // Section plan choisi
                  if (currentPlan != null) ...[
                    TitleWidget(title: 'الخطة المختارة', textAlign: TextAlign.end),
                    SizedBox(height: TSizes.spaceBtwItems.v),
                    GestureDetector(
                      onTap: () {}, // Pas besoin de confirmation pour le plan déjà choisi
                      child: TRoundedContainer(
                        showBorder: true,
                        borderColor: TColors.yellowAppDark,
                        radius: 20.adaptSize,
                        margin: EdgeInsets.symmetric(vertical: 10.adaptSize),
                        padding: EdgeInsets.all(15.adaptSize),
                        backgroundColor: TColors.redSubscriptionCard,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.radio_button_checked, color: TColors.yellowAppDark),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(currentPlan.title!, style: CustomTextStyles.headlineSmallBlack),
                                SubTitleWidget(subtitle: currentPlan.description!),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(currentPlan.details ?? "",
                                      style: TextStyle(fontSize: 15.adaptSize, color: Colors.grey)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: TSizes.spaceBtwSections.v),

                  // Section autres plans
                  if (otherPlans.isNotEmpty) ...[
                    TitleWidget(title: "خطط أخرى", textAlign: TextAlign.end),
                    SizedBox(height: TSizes.spaceBtwItems.v),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: otherPlans.length,
                      itemBuilder: (context, index) {
                        final plan = otherPlans[index];
                        return GestureDetector(
                          onTap: () {
                            controller.confirmChangePlan(context, controller.plans.value.indexWhere((p) => p.title == plan.title));
                            //controller.confirmChangePlan(controller.plans.value.indexWhere((p) => p.title == plan.title));
                          },
                          child: TRoundedContainer(
                            showBorder: true,
                            borderColor: TColors.greyDating,
                            radius: 20.adaptSize,
                            margin: EdgeInsets.symmetric(vertical: 10.adaptSize),
                            padding: EdgeInsets.all(15.adaptSize),
                            backgroundColor: TColors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.radio_button_off, color: Colors.grey),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(plan.title!, style: CustomTextStyles.headlineSmallBlack),
                                    SubTitleWidget(subtitle: plan.description!),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(plan.details ?? "",
                                          style: TextStyle(fontSize: 15.adaptSize, color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}