import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_decoration.dart';
import '../../app_export.dart';
import '../logout.dart';

class Dialogs {

  static onTapBack() async {
    Get.back();
  }

 static dialogLogout(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) =>
            CustomDialog(
              icon: Icons.logout,
              onCancel: onTapBack,
              onTap: Logout.onTapLogout,
              cancelText: "lbl_no".tr,
              successText: "lbl_yes".tr,
              title: "logout".tr,
              description: "exit_application".tr,
              descriptionTextStyle: CustomTextStyles.titleSmallGray400,
            )
    );
  }
/*
 static dialogLanguage(BuildContext context){
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
                       color: appTheme.whiteA700,
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
                         text: "Français",
                         margin: EdgeInsets.only(left: 6.hw),
                         buttonStyle: CustomButtonStyles.elevatedBlueLight700Radius10,
                         //buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
                         onPressed: () async {
                           //Get.updateLocale(Locale('fr'));
                           await translationController.changeLang("fr");
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
 } */


 static customDialog(BuildContext context, Widget child, {visibleBtnClose = true}) {
   var _appTheme = PrefUtils().getThemeData();

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
                       color: _appTheme =='dark' ? appTheme.darkGrey : appTheme.whiteA700,
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
   showModalBottomSheet(
       context: context,
       isScrollControlled: true,
       isDismissible: true,
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(
               top: Radius.circular(30.adaptSize))),
       builder: (context) => DraggableScrollableSheet(
         expand: false,
         initialChildSize: initialChildSize,
         maxChildSize: 0.8,
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
}