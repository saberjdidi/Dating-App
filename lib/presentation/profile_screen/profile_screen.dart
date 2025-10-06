import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/logout.dart';
import 'package:dating_app_bilhalal/presentation/guide/guide_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_controller.dart';
import 'package:dating_app_bilhalal/presentation/settings_screen/controller/theme_controller.dart';
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
      child: Obx(() {
        // Lis l'état du thème ici
        bool isDark = ThemeController.instance.isDark.value;
        return Scaffold(
          backgroundColor: isDark ? TColors.dark : TColors.white,
          appBar: TAppBar(
            title: TitleWidget(title: "إعدادات ملفی", fontWeightDelta: 3, color: isDark ? TColors.white : TColors.buttonSecondary,),
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
                              //radius: BorderRadius.circular(40.adaptSize),
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
                              //radius: BorderRadius.circular(40.adaptSize),
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
                              // radius: BorderRadius.circular(40.adaptSize),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TermesAndConditionsScreen()));
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TermesAndConditionsScreen()));
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
                              //radius: BorderRadius.circular(40.adaptSize),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
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
                              //radius: BorderRadius.circular(40.adaptSize),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    ThemeController.instance.toggleTheme();
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
                        Switch(
                          value: isDark,
                          onChanged: (value){
                            ThemeController.instance.toggleTheme();
                          },
                          activeColor: TColors.yellowAppDark,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SubTitleWidget(
                              subtitle: isDark ? "المظهر الداكن" : "المظهر الفاتح",
                              fontWeightDelta: 2,
                              fontSizeDelta: 2,
                              color: TColors.black,
                            ),
                            SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                            Icon(
                              isDark ? Icons.dark_mode : Icons.light_mode,
                              color: isDark ? Colors.amber : Colors.blueGrey,
                              size: 40.adaptSize,
                            ),
                          ],
                        ),
                        //Icon(Icons.arrow_back_ios, color: TColors.buttonSecondary),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () async {
                    // 🔹 1. Réinitialiser les préférences pour forcer l’affichage du guide
                    await PrefUtils.setHasSeenGuide(false);
                    await PrefUtils.setShowGuide(true);

                    // 🔹 2. Récupérer les contrôleurs
                    final guideController = GuideController.instance;

                    // 🔹 4. Revenir à la page d’accueil (index 0)
                    BottomBarController.instance.changeTabIndex(0);

                    // 🔹 3. Réinitialiser le guide (étape 0)
                    guideController.currentStep.value = 0;
                    guideController.currentGuidePage.value = 0;
                    guideController.showGuide.value = true;

                    // 🔹 5. Forcer la navigation vers la page d’accueil
                    //Get.offAllNamed(Routes.navigationScreen);
                   Get.offAllNamed(Routes.filterScreen, id: 1);


                    // 🔹 6. Afficher une confirmation visuelle
                    Get.snackbar(
                      "Guide",
                      "Le guide a été réinitialisé et recommence depuis le début",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.black87,
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(12),
                      duration: const Duration(seconds: 3),
                    );
                  },
                 /* onTap: (){
                    GuideController.instance.resetGuide();
                    //other method
                  /*  PrefUtils.setHasSeenGuide(false); // réinitialise la préférence
                    final bc = Get.find<BottomBarController>();
                    bc.openGuideForIndex(bc.selectedIndex.value, autoHide: true); // ouvre immédiatement
                    Get.snackbar("Guide", "Guide affiché à nouveau"); */

                  //other 2
                   // PrefUtils.setShowGuide(true);
                   // Get.offAllNamed(Routes.navigationScreen);
                  }, */
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
                          onPressed: () async {
                           // PrefUtils.setShowGuide(true);
                           // Get.offAllNamed(Routes.navigationScreen);
                          },
                          icon: Icon(Icons.arrow_back_ios),
                          iconSize: 25.adaptSize,
                          color: TColors.buttonSecondary,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SubTitleWidget(subtitle: "إعادة عرض الدليل", fontWeightDelta: 2, fontSizeDelta: 2, color: TColors.black,),
                            SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                            Icon(Icons.view_timeline_outlined,
                              color: isDark ? Colors.amber : Colors.blueGrey,
                              size: 40.adaptSize,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){
                    //Get.offAllNamed(Routes.signInScreen);
                    Logout.onTapLogout();
                    //Dialogs.dialogLogout(context);
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
                          onPressed: () async {
                            Logout.onTapLogout();
                           //await Dialogs.dialogLogout(context);
                          },
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
                              // radius: BorderRadius.circular(40.adaptSize),
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
        );
      }),
    );
  }
}
