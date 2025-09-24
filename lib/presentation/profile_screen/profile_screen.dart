import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_controller.dart';
import 'package:dating_app_bilhalal/presentation/terms_privacy_screen/privacy_policy_screen.dart';
import 'package:dating_app_bilhalal/presentation/terms_privacy_screen/termes_condition_screen.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          title: TitleWidget(title: "إعدادات ملفی", fontWeightDelta: 3, color: TColors.buttonSecondary,),
          showAction: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: TSizes.spaceBtwItems.v),
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.userOwnerProfileScreen,
                    //arguments: {"UserModel" : user}
                  );
                },
                child: TRoundedContainer(
                  showBorder: true,
                  borderColor: TColors.grey400,
                  radius: 20.adaptSize,
                  margin: EdgeInsets.all(10.adaptSize),
                  padding: EdgeInsets.all(15.adaptSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          Get.toNamed(Routes.userOwnerProfileScreen,
                            //arguments: {"UserModel" : user}
                          );
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 25.adaptSize,
                        color: TColors.buttonSecondary,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //TitleWidget(title: "ملفي الشخصي", fontWeightDelta: 1),
                          SubTitleWidget(subtitle: "ملفي الشخصي", fontWeightDelta: 2, fontSizeDelta: 2, color: TColors.black,),
                          SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                          CustomImageView(
                            imagePath: ImageConstant.profile8,
                            width: 60.adaptSize,
                            height: 60.adaptSize,
                            radius: BorderRadius.circular(60.adaptSize),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  Get.toNamed(Routes.settingsScreen);
                },
                child: TRoundedContainer(
                  showBorder: true,
                  borderColor: TColors.grey400,
                  radius: 20.adaptSize,
                  margin: EdgeInsets.all(10.adaptSize),
                  padding: EdgeInsets.all(15.adaptSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          Get.toNamed(Routes.settingsScreen);
                        },
                          icon: Icon(Icons.arrow_back_ios),
                        iconSize: 25.adaptSize,
                        color: TColors.buttonSecondary,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SubTitleWidget(subtitle: "إعدادات الاتصال", fontWeightDelta: 2, fontSizeDelta: 2, color: TColors.black,),
                          SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                          CustomImageView(
                            imagePath: ImageConstant.imgSettingsCalling,
                            width: 40.adaptSize,
                            height: 40.adaptSize,
                            radius: BorderRadius.circular(40.adaptSize),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  Get.toNamed(Routes.changePasswordScreen);
                },
                child: TRoundedContainer(
                  showBorder: true,
                  borderColor: TColors.grey400,
                  radius: 20.adaptSize,
                  margin: EdgeInsets.all(10.adaptSize),
                  padding: EdgeInsets.all(15.adaptSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){Get.toNamed(Routes.changePasswordScreen);},
                          icon: Icon(Icons.arrow_back_ios),
                        iconSize: 25.adaptSize,
                        color: TColors.buttonSecondary,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SubTitleWidget(subtitle: "تغيير كلمة المرور", fontWeightDelta: 2, fontSizeDelta: 2, color: TColors.black,),
                          SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                          CustomImageView(
                            imagePath: ImageConstant.imgPassword,
                            width: 40.adaptSize,
                            height: 40.adaptSize,
                            radius: BorderRadius.circular(40.adaptSize),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () async {
                  //Get.toNamed(Routes.subscribeScreen);
                  final savedPlan = await PrefUtils.getSubscriptionPlan();
                  if (savedPlan == null) {
                    Get.toNamed(Routes.subscribeScreen);
                  } else {
                    Get.toNamed(Routes.updateSubscribeScreen);
                  }
                },
                child: TRoundedContainer(
                  showBorder: true,
                  borderColor: TColors.grey400,
                  radius: 20.adaptSize,
                  margin: EdgeInsets.all(10.adaptSize),
                  padding: EdgeInsets.all(15.adaptSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          Get.toNamed(Routes.subscribeScreen);
                        },
                          icon: Icon(Icons.arrow_back_ios),
                        iconSize: 25.adaptSize,
                        color: TColors.buttonSecondary,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SubTitleWidget(subtitle: "الاشتراك", fontWeightDelta: 2, fontSizeDelta: 2, color: TColors.black,),
                          SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                          CustomImageView(
                            imagePath: ImageConstant.imgSubscription,
                            width: 40.adaptSize,
                            height: 40.adaptSize,
                            radius: BorderRadius.circular(40.adaptSize),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TermesAndConditionsScreen()));
                },
                child: TRoundedContainer(
                  showBorder: true,
                  borderColor: TColors.grey400,
                  radius: 20.adaptSize,
                  margin: EdgeInsets.all(10.adaptSize),
                  padding: EdgeInsets.all(15.adaptSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TermesAndConditionsScreen()));
                        },
                          icon: Icon(Icons.arrow_back_ios),
                        iconSize: 25.adaptSize,
                        color: TColors.buttonSecondary,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SubTitleWidget(subtitle: "شروط الاستخدام", fontWeightDelta: 2, fontSizeDelta: 2, color: TColors.black,),
                          SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                          CustomImageView(
                            imagePath: ImageConstant.imgTerms,
                            width: 40.adaptSize,
                            height: 40.adaptSize,
                            radius: BorderRadius.circular(40.adaptSize),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
                },
                child: TRoundedContainer(
                  showBorder: true,
                  borderColor: TColors.grey400,
                  radius: 20.adaptSize,
                  margin: EdgeInsets.all(10.adaptSize),
                  padding: EdgeInsets.all(15.adaptSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
                        },
                          icon: Icon(Icons.arrow_back_ios),
                        iconSize: 25.adaptSize,
                        color: TColors.buttonSecondary,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SubTitleWidget(subtitle: "سياسة الخصوصية", fontWeightDelta: 2, fontSizeDelta: 2, color: TColors.black,),
                          SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                          CustomImageView(
                            imagePath: ImageConstant.imgPrivacyPolicy,
                            width: 40.adaptSize,
                            height: 40.adaptSize,
                            radius: BorderRadius.circular(40.adaptSize),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                },
                child: TRoundedContainer(
                  showBorder: true,
                  borderColor: TColors.grey400,
                  radius: 20.adaptSize,
                  margin: EdgeInsets.all(10.adaptSize),
                  padding: EdgeInsets.all(15.adaptSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){},
                          icon: Icon(Icons.arrow_back_ios),
                        iconSize: 25.adaptSize,
                        color: TColors.buttonSecondary,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SubTitleWidget(subtitle: "تسجيل الخروج", fontWeightDelta: 2, fontSizeDelta: 2, color: TColors.black,),
                          SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                          CustomImageView(
                            imagePath: ImageConstant.imgLogout,
                            width: 40.adaptSize,
                            height: 40.adaptSize,
                            radius: BorderRadius.circular(40.adaptSize),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
