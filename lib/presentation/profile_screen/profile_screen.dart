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
    var isArabe = PrefUtils.getLangue() == 'ar';
    var isLight = PrefUtils.getTheme() == "light";
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      top: false,
      child: Obx(() {
        // Lis l'état du thème ici
        bool isDark = ThemeController.instance.isDark.value;
        return Scaffold(
          backgroundColor: isDark ? TColors.dark : TColors.white,
          appBar: TAppBar(
            title: TitleWidget(title: "lbl_settings".tr, fontWeightDelta: 3, color: isDark ? TColors.white : TColors.buttonSecondary,),
            showAction: false,
          ),
          body: SingleChildScrollView(
            child: Directionality(
              //textDirection: TextDirection.ltr,
              textDirection: isArabe ? TextDirection.ltr : TextDirection.rtl,
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
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      //margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 7.adaptSize),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
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
                              SubTitleWidget(subtitle: "lbl_my_profile".tr, //"ملفي الشخصي"
                                fontWeightDelta: 2, fontSizeDelta: 2,
                                color: isDark ? TColors.whitePrimary : TColors.black,),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              CustomImageView(
                                imagePath: (PrefUtils.getImageProfile() != null && PrefUtils.getImageProfile()!.isNotEmpty)
                                    ? PrefUtils.getImageProfile()
                                    : ImageConstant.profile8,
                                width: 40.hw,
                                height: 40.hw,
                                radius: BorderRadius.circular(40.hw),
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
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
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
                              SubTitleWidget(subtitle: "إعدادات الاتصال", fontWeightDelta: 2, fontSizeDelta: 2,
                                color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              CustomImageView(
                                imagePath: ImageConstant.imgSettingsCalling,
                                color: Color(0xFF32BD00),
                                width: 25.adaptSize,
                                height: 25.adaptSize,
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
                      /*
                      Get.toNamed(Routes.changePasswordScreen, arguments: {
                        "OTP" : (PrefUtils.getOTP() != null && PrefUtils.getOTP()!.isNotEmpty)
                            ? PrefUtils.getOTP()
                            : "123456",
                        "Email" : (PrefUtils.getEmail() != null && PrefUtils.getEmail()!.isNotEmpty)
                            ? PrefUtils.getEmail()
                            : "admin@gmail.com",
                      });
                       */
                    },
                    child: TRoundedContainer(
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
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
                              SubTitleWidget(subtitle: "تغيير كلمة المرور", fontWeightDelta: 2, fontSizeDelta: 2,
                                color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              CustomImageView(
                                imagePath: ImageConstant.imgPassword,
                                color: Color(0xFF8B8700),
                                width: 25.adaptSize,
                                height: 25.adaptSize,
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
                      final hasActiveSubscription = await controller.hasActiveSubscription();
                      if (hasActiveSubscription) {
                        Get.toNamed(Routes.updateSubscribeScreen);
                      } else {
                        Get.toNamed(Routes.subscribeScreen);
                      }
                    },
                    child: TRoundedContainer(
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () async{
                              final hasActiveSubscription = await controller.hasActiveSubscription();
                              if (hasActiveSubscription) {
                                Get.toNamed(Routes.updateSubscribeScreen);
                              } else {
                                Get.toNamed(Routes.subscribeScreen);
                              }                            },
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 25.adaptSize,
                            color: TColors.buttonSecondary,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SubTitleWidget(subtitle: "الاشتراك", fontWeightDelta: 2, fontSizeDelta: 2,
                                color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              CustomImageView(
                                imagePath: ImageConstant.imgSubscription,
                                color: Color(0xFF0DB015),
                                width: 25.adaptSize,
                                height: 25.adaptSize,
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
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
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
                              SubTitleWidget(subtitle: "شروط الاستخدام", fontWeightDelta: 2, fontSizeDelta: 2,
                                color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              CustomImageView(
                                imagePath: ImageConstant.imgTerms,
                                color: Color(0xFF1230F3),
                                width: 25.adaptSize,
                                height: 25.adaptSize,
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
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
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
                              SubTitleWidget(subtitle: "سياسة الخصوصية", fontWeightDelta: 2, fontSizeDelta: 2,
                                color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              CustomImageView(
                                imagePath: ImageConstant.imgPrivacyPolicy,
                                color: Color(0xFF15F0E2),
                                width: 25.adaptSize,
                                height: 25.adaptSize,
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
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical:0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Switch(
                            value: isDark,
                            onChanged: (value){
                              ThemeController.instance.toggleTheme();
                            },
                            activeColor: TColors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SubTitleWidget(
                                subtitle: isDark ? "المظهر الداكن" : "المظهر الفاتح",
                                fontWeightDelta: 2,
                                fontSizeDelta: 2,
                                color: isDark ? TColors.whitePrimary : TColors.black
                              ),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              Icon(
                                isDark ? Icons.dark_mode : Icons.light_mode,
                                color: isDark ? TColors.buttonSecondary : Color(0xFFFFFC00),
                                //color: isDark ? Colors.amber : Colors.blueGrey,
                                size: 25.adaptSize,
                              ),
                            ],
                          ),
                          //Icon(Icons.arrow_back_ios, color: TColors.buttonSecondary),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.supportScreen);
                    },
                    child: TRoundedContainer(
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              Get.toNamed(Routes.supportScreen);
                              },
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 25.adaptSize,
                            color: TColors.buttonSecondary,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SubTitleWidget(subtitle: "الدعم", fontWeightDelta: 2, fontSizeDelta: 2,
                                  color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              CustomImageView(
                                imagePath: ImageConstant.imgSupport,
                                color: Color(0xFF121CE3),
                                width: 25.adaptSize,
                                height: 25.adaptSize,
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
                      Dialogs.dialogLanguage(context);
                      //Get.toNamed(Routes.supportScreen);
                    },
                    child: TRoundedContainer(
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              },
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 25.adaptSize,
                            color: TColors.buttonSecondary,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SubTitleWidget(subtitle: "اللغة", fontWeightDelta: 2, fontSizeDelta: 2,
                                  color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              Icon(Icons.translate,
                                color: Color(0xFF8B8700),
                                size: 25.adaptSize,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: true,
                    child: InkWell(
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
                        showBorder: false,
                        backgroundColor: isDark ? TColors.dark : TColors.white,
                        borderColor: isDark ? TColors.white : TColors.grey400,
                        radius: 20.adaptSize,
                        margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                        padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                        //padding: EdgeInsets.all(10.adaptSize),
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
                                SubTitleWidget(subtitle: "إعادة عرض الدليل", fontWeightDelta: 2, fontSizeDelta: 2,
                                    color: isDark ? TColors.whitePrimary : TColors.black),
                                SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                                Icon(Icons.view_timeline_outlined,
                                  color: TColors.yellowAppDark,
                                  size: 25.adaptSize,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      await Dialogs.buildDialogDeleteAccount(isDark);
                    },
                    child: TRoundedContainer(
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 25.adaptSize,
                            color: TColors.buttonSecondary,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SubTitleWidget(subtitle: "حذف الحساب", fontWeightDelta: 2, fontSizeDelta: 2,
                                  color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              Icon(Iconsax.trash,
                                color: Color(0xFFFF1515),
                                size: 25.adaptSize,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      //Get.offAllNamed(Routes.signInScreen);
                     // Logout.onTapLogout();
                      await Dialogs.dialogLogout(isDark);
                    },
                    child: TRoundedContainer(
                      showBorder: false,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      borderColor: isDark ? TColors.white : TColors.grey400,
                      radius: 20.adaptSize,
                      margin: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 5.adaptSize),
                      //padding: EdgeInsets.all(10.adaptSize),
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
                              SubTitleWidget(subtitle: "تسجيل الخروج", fontWeightDelta: 2, fontSizeDelta: 2,
                                color: isDark ? TColors.whitePrimary : TColors.black),
                              SizedBox(width: TSizes.spaceBtwItems.adaptSize,),
                              CustomImageView(
                                imagePath: ImageConstant.imgLogout,
                                color: Color(0xFFDB161B),
                                width: 25.adaptSize,
                                height: 25.adaptSize,
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
          ),
        );
      }),
    );
  }
}
