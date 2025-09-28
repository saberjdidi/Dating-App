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
                       color: _appTheme =='dark' ? appTheme.darkGrey : TColors.white,
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
       //constraints: BoxConstraints.expand(),
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