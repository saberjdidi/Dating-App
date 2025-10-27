import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/localization/translation_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_details_controller.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:dating_app_bilhalal/widgets/custom_divider.dart';
import 'package:dating_app_bilhalal/widgets/gradient/gradient_svg_icon.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_decoration.dart';
import '../../app_export.dart';
import '../logout.dart';

class Dialogs {

  static onTapBack() async {
    Get.back();
  }

/* static dialogLogout(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) =>
            CustomDialog(
              icon: Icons.logout,
              onCancel: onTapBack,
              onTap: Logout.onTapLogout,
              cancelText: "Non".tr,
              successText: "Oui".tr,
              title: "logout".tr,
              description: "Voulez vous quitter l'application".tr,
              descriptionTextStyle: CustomTextStyles.titleSmallGray400,
            )
    );
  } */
  static dialogLogout(bool isDark){
    var isArabe = PrefUtils.getLangue() == 'ar';
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDark ? TColors.darkerGrey : Colors.white,

        child: SizedBox(
          height: 150, // fixe la hauteur de ton popup
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(18.hw),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: isArabe ? CrossAxisAlignment.start :  CrossAxisAlignment.end,
                      mainAxisAlignment: isArabe ? MainAxisAlignment.start :  MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.close_outlined, size: 25, color: TColors.redApp,),
                        ),
                      ],
                    ),
                    SubTitleWidget(
                        subtitle: 'هل تريد الخروج من التطبيق ؟',
                        color: isDark ? TColors.white : TColors.black,
                        fontWeightDelta: 2,
                        fontSizeDelta: 1
                    ),
                    SizedBox(height: 15.v,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomButtonContainer(
                              text:"نعم",
                              color1: TColors.primaryColorApp,
                              color2: TColors.primaryColorApp,
                              borderRadius: 30,
                              colorText: TColors.white,
                              fontSize: 20.adaptSize,
                              height: 40.v,
                              width: 80.adaptSize,
                              onPressed: Logout.onTapLogout,
                              paddingVertical: 2
                          ),
                          CustomButtonContainer(
                              text:"لا",
                              color1: TColors.redApp,
                              color2: TColors.redApp,
                              borderRadius: 30,
                              colorText: TColors.white,
                              fontSize: 20.adaptSize,
                              height: 40.v,
                              width: 50.adaptSize,
                              onPressed: onTapBack,
                              paddingVertical: 2
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
      barrierDismissible: false, // Ferme si l'utilisateur clique à l'extérieur
    );
  }

  static buildDialogDeleteAccount(bool isDark){
    var isArabe = PrefUtils.getLangue() == 'ar';
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDark ? TColors.darkerGrey : Colors.white,

        child: SizedBox(
          height: 150, // fixe la hauteur de ton popup
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(18.hw),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: isArabe ? CrossAxisAlignment.start :  CrossAxisAlignment.end,
                      mainAxisAlignment: isArabe ? MainAxisAlignment.start :  MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.close_outlined, size: 25, color: TColors.redApp,),
                        ),
                      ],
                    ),
                    SubTitleWidget(
                        subtitle: 'هل تريد حذف حسابك ؟',
                        color: isDark ? TColors.white : TColors.black,
                        fontWeightDelta: 2,
                        fontSizeDelta: 1
                    ),
                    SizedBox(height: 15.v,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomButtonContainer(
                              text:"نعم",
                              color1: TColors.primaryColorApp,
                              color2: TColors.primaryColorApp,
                              borderRadius: 30,
                              colorText: TColors.white,
                              fontSize: 20.adaptSize,
                              height: 40.v,
                              width: 80.adaptSize,
                              onPressed: () {
                                Get.back();
                              },
                              paddingVertical: 2
                          ),
                          CustomButtonContainer(
                              text:"لا",
                              color1: TColors.redApp,
                              color2: TColors.redApp,
                              borderRadius: 30,
                              colorText: TColors.white,
                              fontSize: 20.adaptSize,
                              height: 40.v,
                              width: 50.adaptSize,
                              onPressed: () {
                                Get.back();
                              },
                              paddingVertical: 2
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
      barrierDismissible: true, // Ferme si l'utilisateur clique à l'extérieur
    );
  }

 static dialogLanguage(BuildContext context){
   var isArabe = PrefUtils.getLangue() == 'ar';
   var translationController = Get.find<TranslationController>();
   showDialog(
       context: context,
       barrierDismissible: false,
       builder: (builder) =>
           Dialog(
             backgroundColor: Colors.transparent,
             child: Stack(
               children: [
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 32.hw, vertical: 16.v),
                   margin: EdgeInsets.all(16),
                   decoration: BoxDecoration(
                       color: TColors.white,
                       borderRadius: BorderRadiusStyle.roundedBorder20
                   ),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       SizedBox(height: 10.v),
                       Text("choisir_langue".tr,
                           style: CustomTextStyles.titleMediumSemiBoldBlack
                       ),
                       SizedBox(height: 30.v),
                       CustomElevatedButton(
                         height: 48.v,
                         text: "English",
                         margin: EdgeInsets.only(left: 6.hw),
                         buttonStyle: CustomButtonStyles.elevatedBlueLight700Radius10,//CustomButtonStyles.fillPrimaryTL19,
                         //buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
                         onPressed: () async {
                           //Get.updateLocale(Locale('en'));
                           await translationController.changeLang("en");
                           await onTapBack();
                         },
                       ),
                       SizedBox(height: 10.v),
                       CustomElevatedButton(
                         height: 48.v,
                         text: "عربي",
                         margin: EdgeInsets.only(left: 6.hw),
                         buttonStyle: CustomButtonStyles.elevatedBlueLight700Radius10,
                         //buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
                         onPressed: () async {
                           //Get.updateLocale(Locale('fr'));
                           await translationController.changeLang("ar");
                           await onTapBack();
                         },
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   //top: 0,
                   right: 0,
                   width: 40.adaptSize,
                   height: 40.adaptSize,
                   child:
                   CustomImageView(
                     imagePath: ImageConstant.imgClose,
                     height: 40.adaptSize,
                     width: 40.adaptSize,
                     onTap: onTapBack,
                   ),
                 ),
               ],
             ),
           )
   );
 }

  static buildDialogSettings(BuildContext context, ProfileDetailsController  controller){
    var isArabe = PrefUtils.getLangue() == 'ar';
    var _appTheme = PrefUtils.getTheme();
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: _appTheme =='light' ? Colors.white : TColors.darkerGrey,

        child: SizedBox(
          height: 150, // fixe la hauteur de ton popup
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(18.hw),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.share_outlined, color: _appTheme =='light' ? TColors.gray700 : TColors.white,),
                          SizedBox(width: 10.hw),
                          SubTitleWidget(
                              subtitle: 'مشاركة الملف الشخصي',
                              color: _appTheme =='light' ? TColors.black : TColors.white,
                              fontWeightDelta: 2,
                              fontSizeDelta: 1
                          ),
                        ],
                      ),
                    ),

                    CustomDividerWidget(),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: (){
                          if (!controller.isDataProcessing.value) {
                            controller.sendReport();
                          }
                        },
                        child: Obx(() => controller.isDataProcessing.value
                            ? CircularProgressIndicator(
                          backgroundColor: _appTheme =='light' ? Colors.white : TColors.darkerGrey,
                          color: TColors.primaryColorApp,
                        )
                            :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Iconsax.user_remove, color: _appTheme =='light' ? TColors.gray700 : TColors.white,),
                            SizedBox(width: 10.hw),
                            SubTitleWidget(
                                subtitle: 'إبلاغ عن إساءة',
                                //subtitle: 'حضر الملف الشخصي',
                                color: _appTheme =='light' ? TColors.black : TColors.white,
                                fontWeightDelta: 2,
                                fontSizeDelta: 1
                            ),

                          ],
                        )
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
      barrierDismissible: true, // Ferme si l'utilisateur clique à l'extérieur
    );
  }

  static buildDialogUsersLikes(BuildContext context, int likeCount, List<UserModel> users) {
    var isArabe = PrefUtils.getLangue() == 'ar';
    var _appTheme = PrefUtils.getTheme();
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: _appTheme == 'light' ? Colors.white : TColors.darkerGrey,
        child: SizedBox(
          height: 420,
          child: Padding(
            padding: EdgeInsets.all(18.hw),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientSvgIcon(
                      assetPath: ImageConstant.iconLove,
                      size: 50.adaptSize,
                      gradient: const LinearGradient(
                        colors: [TColors.redApp, TColors.redApp],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    SizedBox(height: 2),
                    SubTitleWidget(
                      subtitle: '$likeCount',
                      color: TColors.black,
                      fontWeightDelta: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomDividerWidget(),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Column(
                        children: [
                          SizedBox(height: 10.v),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(Routes.profileDetailsScreen, arguments: {
                                "UserModel" : user
                              });
                            },
                            child: Row(
                              mainAxisAlignment:  MainAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: user.imageProfile,
                                  width: 50.adaptSize,
                                  height: 50.adaptSize,
                                  radius: BorderRadius.circular(60.adaptSize),
                                ),
                                SizedBox(width: 10.v),
                                SubTitleWidget(
                                  subtitle: user.fullName!,
                                  fontWeightDelta: 1,
                                  color: TColors.black,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.v),
                          CustomDividerWidget(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 static customDialog(BuildContext context, Widget child, {visibleBtnClose = true}) {
   var _appTheme = PrefUtils.getTheme();

   showDialog(
       context: context,
       barrierDismissible: false,
       builder: (builder) =>
           Dialog(
             backgroundColor: Colors.transparent,
             child: Stack(
               children: [
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 10.hw, vertical: 16.v),
                   margin: EdgeInsets.all(16),
                   decoration: BoxDecoration(
                       color: _appTheme =='dark' ? TColors.white : TColors.darkGrey,
                       //color: appTheme.whiteA700,
                       borderRadius: BorderRadiusStyle.roundedBorder20
                   ),
                   child: SingleChildScrollView(
                     child: child,
                   ),
                 ),
                 Visibility(
                 visible: visibleBtnClose,
                   child: Positioned(
                     top: 1,
                     right: 1,
                     width: 40.adaptSize,
                     height: 40.adaptSize,
                     child:
                     CustomImageView(
                       imagePath: ImageConstant.imgClose,
                       height: 40.adaptSize,
                       width: 40.adaptSize,
                       onTap: onTapBack,
                     ),
                   ),
                 ),
               ],
             ),
           )
   );
 }

 static customModalBottomSheet(BuildContext context, double initialChildSize, Widget child, {visibleBtnClose = true}){
   var _appTheme = PrefUtils.getTheme();
   showModalBottomSheet(
       context: context,
       isScrollControlled: true,
       isDismissible: true,
       backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
       //constraints: BoxConstraints.expand(),
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(
               top: Radius.circular(30.adaptSize))),
       //backgroundColor: _appTheme =='light' ?  TColors.white : TColors.darkerGrey,
       builder: (context) => DraggableScrollableSheet(
         expand: false,
         initialChildSize: initialChildSize,
         maxChildSize: initialChildSize,
         minChildSize: 0.6,
         builder: (context, scrollController) => Stack(
           clipBehavior: Clip.none,
           children: [
             SingleChildScrollView(
                 controller: scrollController,
                 child: child
             ),
             Visibility(
               visible: visibleBtnClose,
               child: Positioned(
                 top: -20, // légèrement en dehors du Dialog
                 left: 0,
                 right: 0,
                 child: CustomImageView(
                   imagePath: ImageConstant.imgClose,
                   onTap: (){
                     Navigator.pop(context);
                     //onTapBack();
                   },
                 ),
               ),
             ),
           ],
         ),
       )
   );
 }

  static customModalBottomSheetMethod2(BuildContext context, double initialChildSize, Widget child, {visibleBtnClose = true}){
   /* showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permet de contrôler toute la hauteur
      backgroundColor: Colors.transparent,
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double maxHeight = constraints.maxHeight;
            double maxWidth = constraints.maxWidth;

            return FractionallySizedBox(
              widthFactor: 1, // Prend toute la largeur
              //heightFactor: 1, // Prend toute la hauteur
              child: Container(
                width: maxWidth,
                //height: maxHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Contenu avec Scroll si besoin
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              "Mon BottomSheet",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Contenu responsive qui prend toute la largeur et la hauteur.",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Fermer"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ); */
   /* showModalBottomSheet(
      constraints: BoxConstraints.expand(),
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final bool isTablet = screenWidth >= 600;
            final double maxWidth = isTablet ? screenWidth * 0.9 : screenWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.7,
                  maxChildSize: 0.9,
                  minChildSize: 0.5,
                  builder: (context, scrollController) {
                    return ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      child: Material(
                        color: Colors.white,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SingleChildScrollView(
                              controller: scrollController,
                              child: child, // Ton contenu ici
                            ),
                            if (visibleBtnClose)
                              Positioned(
                                top: -20,
                                left: 0,
                                right: 0,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgClose,
                                  onTap: () => Navigator.pop(context),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
   */
  }
}