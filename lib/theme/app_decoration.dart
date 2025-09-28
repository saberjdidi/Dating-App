import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray900,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray700,
      );
  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green60019,
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: TColors.redAppDark,
      );

  // Gradient decorations
  static BoxDecoration get gradient => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.gray80000,
            appTheme.blueGray90059,
            appTheme.gray900.withOpacity(0.59),
          ],
        ),
      );
  static BoxDecoration get gradientGrayToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, -0.78),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.gray80000,
            appTheme.gray900,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack9000c => BoxDecoration(
        color: appTheme.blueGray900,
        boxShadow: [
          BoxShadow(
            color: appTheme.black9000c.withOpacity(0.08),
            spreadRadius: 2.hw,
            blurRadius: 2.hw,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlackC => BoxDecoration(
        color: appTheme.blueGray900,
        boxShadow: [
          BoxShadow(
            color: appTheme.black9000c,
            spreadRadius: 2.hw,
            blurRadius: 2.hw,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder24 => BorderRadius.circular(
        24.hw,
      );
  static BorderRadius get circleBorder40 => BorderRadius.circular(
        40.hw,
      );
  static BorderRadius get circleBorder60 => BorderRadius.circular(
        60.hw,
      );
  static BorderRadius get circleBorder70 => BorderRadius.circular(
        70.hw,
      );

  // Custom borders
  static BorderRadius get customBorderBL36 => BorderRadius.vertical(
        bottom: Radius.circular(36.hw),
      );

  // Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.hw,
      );
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.hw,
      );
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.hw,
      );
  static BorderRadius get roundedBorder30 => BorderRadius.circular(
    30.hw,
  );
  static BorderRadius get roundedBorder36 => BorderRadius.circular(
        36.hw,
      );
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.hw,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.
    
// For Flutter SDK Version 3.7.2 or greater.
    
double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;
    