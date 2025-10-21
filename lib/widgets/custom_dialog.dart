import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import '../theme/app_decoration.dart';
import 'custom_outlined_button.dart';

class CustomDialog extends StatelessWidget {
  IconData? icon;
  VoidCallback? onCancel;
  VoidCallback? onTap;
  String? cancelText;
  String? successText;
  String title;
  String? description;
  TextStyle? descriptionTextStyle;
  String? image;
  bool showSuccessButton;

   CustomDialog({
     this.icon,
    this.onCancel,
     this.onTap,
     this.cancelText,
     this.successText,
     required this.title,
     this.description,
     this.descriptionTextStyle,
     this.image,
     this.showSuccessButton = true
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ton widget principal du Dialog
          DialogWidget,

          // Image centrée en haut
          Positioned(
            top: -10, // légèrement en dehors du Dialog
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  image!,
                  height: 100.fSize,
                  width: 100.fSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    /*
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          DialogWidget,
          Positioned(
            //top: 0,
              right: 0,
              width: 40.adaptSize,
              height: 40.adaptSize,
              child:
             /* OutlinedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(8),
                    shape: CircleBorder(),
                    backgroundColor: Colors.red
                ),
                child: Image.asset(ImageConstant.imgClose),
              )*/
             CustomImageView(
              imagePath: ImageConstant.logo,
              height: 40.adaptSize,
              width: 40.adaptSize,
            onTap: onCancel,
          ),
          ),
        ],
      ),
    );
    */
  }

  Widget get DialogWidget => Container(
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
         Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             InkWell(
               onTap: onCancel,
               child: Icon(icon, size: 25,),
             ),
           ],
         ),
        SizedBox(height: 15.v),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              TitleWidget(title: title, textAlign: TextAlign.center,),
              //Text(title, style: CustomTextStyles.titleMediumRed400),
              Text(description ?? "",
                  style: descriptionTextStyle ?? CustomTextStyles.titleMedium16White
              ),
            ],
          ),
        ),

        SizedBox(height: 30.v),
        showSuccessButton
        ? CustomButtonContainer(
            height: 60.v,
            width: Get.width * 0.3,
            text: successText ?? "",
            color1: TColors.greenAccept,
            color2: TColors.greenAccept,
            borderRadius: 10,
            colorText: TColors.white,
            fontSize: 20.adaptSize,
            onPressed: onTap
        )
        : SizedBox.shrink(),
      ],
    ),
  );
}
