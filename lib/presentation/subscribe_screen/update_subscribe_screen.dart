import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/subscribe_screen/controller/subscribe_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/swip_back_wrapper.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';


class UpdateSubscribeScreen extends GetView<SubscribeController> {
  UpdateSubscribeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKeyUpdateSubscribe = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      top: false,
      child: SwipeBackWrapper(
        child: Scaffold(
          //backgroundColor: _appTheme == 'light' ? TColors.white : appTheme.primaryColor,
          key: _scaffoldKeyUpdateSubscribe,
          resizeToAvoidBottomInset: false,
          appBar: TAppBar(
            title: TitleWidget(
              title: "الاشتراک",
              fontWeightDelta: 2,
              color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white
            ),
            showAction: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
            child: Obx(() {
              final currentPlan = controller.selectedPlan.value;
              final plans = controller.plans.value;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: TSizes.spaceBtwItems.v),

                    // Section plan choisi
                    if (currentPlan != null) ...[
                      TitleWidget(title: 'الخطة المختارة',
                          color:  _appTheme =='light' ? TColors.black : TColors.white,
                          textAlign: TextAlign.end),
                      SizedBox(height: TSizes.spaceBtwItems.v),
                      GestureDetector(
                        onTap: () {}, // Pas besoin de confirmation pour le plan déjà choisi
                        child: TRoundedContainer(
                          showBorder: true,
                          borderColor: TColors.primaryColorApp,
                          radius: 20.adaptSize,
                          margin: EdgeInsets.symmetric(vertical: 10.adaptSize),
                          padding: EdgeInsets.all(15.adaptSize),
                          backgroundColor: TColors.redSubscriptionCard,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.radio_button_checked, color: TColors.primaryColorApp),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(currentPlan.name??'', style: CustomTextStyles.headlineSmallBlack),
                                  SubTitleWidget(subtitle: '${currentPlan.currency ?? ''} ${currentPlan.price?.toString() ?? ''}/${currentPlan.billingCycle ?? ''}'),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(currentPlan.description ?? "",
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
                    if (plans.isNotEmpty) ...[
                      TitleWidget(title: "خطط أخرى",
                          color:  _appTheme =='light' ? TColors.black : TColors.white,
                          textAlign: TextAlign.end),
                      SizedBox(height: TSizes.spaceBtwItems.v),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: plans.length,
                        itemBuilder: (context, index) {
                          final plan = plans[index];
                          return GestureDetector(
                            onTap: () {
                              controller.confirmChangePlan(context, plans.indexOf(plan));
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
                                      Text(plan.name??'', style: CustomTextStyles.headlineSmallBlack),
                                      SubTitleWidget(subtitle: plan.description??''),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(plan.description ?? "",
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
      ),
    );
  }
}