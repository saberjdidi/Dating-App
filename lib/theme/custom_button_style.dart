import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomButtonStyles {
  static ButtonStyle get elevatedBlueLight700 => ElevatedButton.styleFrom(
      backgroundColor: TColors.blueLight700,
  );

  static ButtonStyle get elevatedBlueLight700Radius10 => ElevatedButton.styleFrom(
      backgroundColor: TColors.primaryColorApp,
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