import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomButtonStyles {

  ///Dating App
  static ButtonStyle get elevatedGreenAccept => ElevatedButton.styleFrom(
    backgroundColor: TColors.greenAccept,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.hw),
    ),
  );

  ///Old

  static ButtonStyle get elevatedBlueLight700 => ElevatedButton.styleFrom(
      backgroundColor: TColors.blueLight700,
  );

  static ButtonStyle get elevatedYellowRadius10 => ElevatedButton.styleFrom(
    backgroundColor: TColors.primaryColorApp,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.hw),
    ),
  );

  static ButtonStyle get elevatedBlueLight700Radius10 => ElevatedButton.styleFrom(
      backgroundColor: TColors.blueLight700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.hw),
    ),
  );

  static ButtonStyle get elevatedGreenRadius10 => ElevatedButton.styleFrom(
      backgroundColor: TColors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.hw),
    ),
  );

  static ButtonStyle get elevatedRedRadius10 => ElevatedButton.styleFrom(
      backgroundColor: TColors.error,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.hw),
    ),
  );

  static ButtonStyle get outlineGreyRadius10 => ElevatedButton.styleFrom(
      backgroundColor: TColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.hw),
      side: BorderSide(color: Colors.grey, width: 2)
    ),
  );

  static ButtonStyle get elevatedBlueVPTRadius10 => ElevatedButton.styleFrom(
      backgroundColor: TColors.colorActiveIconBottomBar,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.hw),
    ),
  );

  static ButtonStyle get elevatedDarkerGrey => ElevatedButton.styleFrom(
      backgroundColor: TColors.darkerGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.hw),
    ),
  );

  static ButtonStyle get fillBlueGray => ElevatedButton.styleFrom(
    backgroundColor: appTheme.blueGray900,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(27.hw),
    ),
  );

  static ButtonStyle get outlineBlack => ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    elevation: MaterialStateProperty.all<double>(0),
    //side: BorderSide(color: appTheme.blueAstree),
    side: MaterialStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(MaterialState.disabled)) {
        // Return disabled border color if button is disabled
        return BorderSide(color: Colors.grey, width: 2); // Adjust color as needed
      }
      // Return blue border color for other states
      return BorderSide(color: TColors.gray700, width: 2); // Adjust color as needed
    }),
  );

  static ButtonStyle get outlineWhite => ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    elevation: MaterialStateProperty.all<double>(0),
    //side: BorderSide(color: appTheme.blueAstree),
    side: MaterialStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(MaterialState.disabled)) {
        // Return disabled border color if button is disabled
        return BorderSide(color: Colors.white, width: 2); // Adjust color as needed
      }
      // Return blue border color for other states
      return BorderSide(color: TColors.white, width: 2); // Adjust color as needed
    }),
  );

}