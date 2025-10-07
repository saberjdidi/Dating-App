import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';


class CustomTextStyles {

  static get bodyLarge18 => theme.textTheme.bodyLarge!.copyWith(
    fontSize: 18.fSize,
  );

  static get titleMedium16White => theme.textTheme.titleMedium!.copyWith(
      fontSize: 16.fSize,
      fontWeight: FontWeight.w500,
      color: TColors.textWhite
  );

  static get titleMedium16WhiteBold => theme.textTheme.titleMedium!.copyWith(
      fontSize: 16.fSize,
      fontWeight: FontWeight.bold,
      color: TColors.textWhite
  );

  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 17.fSize,
        fontWeight: FontWeight.w600,
      );

  static get titleMediumSemiBoldBlack => theme.textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: TColors.darkGrey
  );

  static get titleMediumSemiBoldWhite => theme.textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: TColors.white
  );

  static get headlineSmallBlack => theme.textTheme.headlineSmall!.copyWith(
    color: TColors.black,
    fontSize: 22.fSize,
    fontWeight: FontWeight.bold,
    //decoration: TextDecoration.underline,
    decorationColor: TColors.black,
  );

  static get titleMediumBlack54 =>
      theme.textTheme.titleMedium!.copyWith(
        color: TColors.black54,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );

  static get bodyLargeBlack =>
      theme.textTheme.bodyLarge!.copyWith(
          color: TColors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600
      );
/*
  static get titleMediumBlueVPT =>
      theme.textTheme.titleMedium!.copyWith(
        color: TColors.blueDating,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );

  static get titleMediumBlue =>
      theme.textTheme.titleMedium!.copyWith(
        color: TColors.colorActiveIconBottomBar,
        fontSize: mediaQueryData.size.width >= 600 ?  16.fSize : 14.fSize,
        fontWeight: FontWeight.w600,
      );

  static get bodyMediumBlue =>
      theme.textTheme.bodyMedium!.copyWith(
        color: TColors.colorActiveIconBottomBar,
        fontSize: mediaQueryData.size.width >= 600 ?  11.fSize : 12.fSize,
        fontWeight: FontWeight.bold,
      );
  */

  static get bodyMediumTextFormField => theme.textTheme.bodyMedium!.copyWith(
    color: TColors.black,
  );

  static get bodyMediumTextFormFieldBold => theme.textTheme.bodyMedium!.copyWith(
    color: TColors.black,
    fontWeight: FontWeight.bold
  );

  static get bodyMediumTextFormFieldGrey => theme.textTheme.bodyMedium!.copyWith(
    color: TColors.gray700,
  );
  static get bodyMediumTextFormFieldWhite => theme.textTheme.bodyMedium!.copyWith(
    color: TColors.white,
  );
  static get bodyMediumTextFormFieldLightGrey => theme.textTheme.bodyMedium!.copyWith(
    color: TColors.lightGrey,
  );

  static get titleLargeBlackGrey => theme.textTheme.titleLarge!.copyWith(
    color: TColors.blackGrey.withOpacity(0.8),
    fontWeight: FontWeight.bold,
  );

  static get titleLargeWhite => theme.textTheme.titleLarge!.copyWith(
    color: TColors.white,
    fontWeight: FontWeight.bold,
  );

  static get titleLargeGray400 => theme.textTheme.titleLarge!.copyWith(
    color: appTheme.gray400,
    fontWeight: FontWeight.bold,
  );

  static get titleMediumSourceSansPro =>
      theme.textTheme.titleMedium!.sourceSansPro.copyWith(
        fontWeight: FontWeight.w600,
      );

  static get bodyMediumOnError => theme.textTheme.bodyMedium!.copyWith(
      color: TColors.redAppLight, //theme.colorScheme.onError,
      fontSize: 18.fSize,
      fontWeight: FontWeight.w500
  );

  static get titleMedium16YellowDark => theme.textTheme.titleMedium!.copyWith(
      fontSize: 16.fSize,
      fontWeight: FontWeight.bold,
      color: TColors.yellowAppDark
  );

  static get labelSmallStatusWhite => mediaQueryData.size.width >= 600
      ? theme.textTheme.titleMedium!.copyWith(color: TColors.white, fontSize: 16.adaptSize)
      : theme.textTheme.labelSmall!.apply(color: TColors.white);

  static get titleSmallGray400 => theme.textTheme.titleSmall!.copyWith(
    color: TColors.darkerGrey,
    fontWeight: FontWeight.w500,
  );

  static get titleLargeDarkerGrey => theme.textTheme.titleLarge!.copyWith(
    color: TColors.darkerGrey,
    fontWeight: FontWeight.bold,
    fontSize: 20.adaptSize
  );

  static get titleMediumRed400 => theme.textTheme.titleMedium!.copyWith(
    color: TColors.error,
    fontWeight: FontWeight.w600,
  );

}

extension on TextStyle {
  TextStyle get sourceSansPro {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get urbanist {
    return copyWith(
      fontFamily: 'Urbanist',
    );
  }
}