import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MessageSnackBar {
  static void customSnackBar(
      String message,
      String? nameErrorOrWarning,
      SnackPosition? position,
  {
    Color backgroundColor = const Color(0xFF202e59),
    Color colorTitle = Colors.redAccent,
    Color colorDescription = Colors.amber
  }) {
    Get.snackbar(
      message,
      nameErrorOrWarning ?? "",
      backgroundColor: backgroundColor,
      titleText: Text(
        message,
        style: TextStyle(
            fontSize: 17.fSize,
            fontWeight: FontWeight.bold,
            color: colorTitle),
      ),
      messageText: Text(
        nameErrorOrWarning ?? "",
        style: TextStyle(
            fontSize: 15.fSize,
            fontWeight: FontWeight.bold,
            color: colorDescription),
      ),
      snackPosition: position ?? SnackPosition.TOP,
    );
  }

  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding: EdgeInsets.all(12.hw),
            margin: EdgeInsets.symmetric(horizontal: 30.hw),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.hw),
              color: PrefUtils().getThemeData() =='dark' ? appTheme.darkerGrey.withOpacity(0.9) : appTheme.grey.withOpacity(0.9),
            ),
            child: Center(
                child: Text(
                  message,
                  style: Theme.of(Get.context!).textTheme.labelLarge,
                )),
          ),
        )
    );
  }

  static  successSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: appTheme.whiteA700,
        backgroundColor: appTheme.blueAstree,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: EdgeInsets.all(10.hw),
        icon: Icon(Iconsax.check, color: appTheme.whiteA700)
    );
  }

  static  warningSnackBar({required title, message = ''}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: appTheme.whiteA700,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(20.hw),
        icon: Icon(Iconsax.warning_2, color: appTheme.whiteA700)
    );
  }

  static  errorSnackBar({required title, message = ''}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: appTheme.whiteA700,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(20.hw),
        icon: Icon(Iconsax.warning_2, color: appTheme.whiteA700)
    );
  }

  static  informationToast({required title, message = '', duration = 3, SnackPosition? position}) {
    Get.snackbar(
        title,
        titleText:Text(title, style: TextStyle(color: TColors.blueLight700, fontWeight: FontWeight.bold),),
        message,
        messageText: Text(message, style: TextStyle(color: TColors.gray700, fontSize: 14.adaptSize),),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: TColors.whiteBackground,
        snackPosition: position ?? SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: EdgeInsets.all(10.hw),
        padding: EdgeInsets.all(5.hw),
        borderRadius: 40.adaptSize,
        icon: Padding(
          padding: EdgeInsets.only(left: 5.v, right: 5.v),
          child: CircleAvatar(
            backgroundColor: TColors.blueLight700,
            child: Icon(Icons.info_outline, color: TColors.white),
          ),
        ),
        mainButton: TextButton(onPressed: (){
          Get.back();
        }, child: Icon(Icons.close, color: TColors.gray700))
    );
  }

  static  successToast({required title, message = '', duration = 3, SnackPosition? position}) {
    Get.snackbar(
        title,
        titleText:Text(title, style: TextStyle(color: Color(0xFF0E9F6E), fontWeight: FontWeight.bold),),
        message,
        messageText: Text(message, style: TextStyle(color: TColors.gray700, fontSize: 14.adaptSize),),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: TColors.whiteBackground,
        snackPosition: position ?? SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: EdgeInsets.all(10.hw),
        padding: EdgeInsets.all(5.hw),
        borderRadius: 40.adaptSize,
        icon: Padding(
          padding: EdgeInsets.only(left: 5.v, right: 5.v),
          child: CircleAvatar(
            backgroundColor: Color(0xFF0E9F6E),
            child: Icon(Icons.info_outline, color: TColors.white),
          ),
        ),
        mainButton: TextButton(onPressed: (){
          Get.back();
        }, child: Icon(Icons.close, color: TColors.gray700))
    );
  }

  static  errorToast({required title, message = '', duration = 3, SnackPosition? position}) {
    Get.snackbar(
        title,
        titleText:Text(title, style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.bold),),
        message,
        messageText: Text(message, style: TextStyle(color: TColors.gray700, fontSize: 14.adaptSize),),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: TColors.whiteBackground,
        snackPosition: position ?? SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: EdgeInsets.all(10.hw),
        padding: EdgeInsets.all(5.hw),
        borderRadius: 40.adaptSize,
        icon: Padding(
          padding: EdgeInsets.only(left: 5.v, right: 5.v),
          child: CircleAvatar(
            backgroundColor: Colors.red.shade600,
            child: Icon(Icons.info_outline, color: TColors.white),
          ),
        ),
        mainButton: TextButton(onPressed: (){
          Get.back();
        }, child: Icon(Icons.close, color: TColors.gray700))
    );
  }
}