import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
class FormDividerWidget extends StatelessWidget {
  FormDividerWidget({
    super.key,
    required this.dividerText,
    this.thikness = 0.5,
    this.color
  });

  final String dividerText;
  double thikness;
  Color? color;

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils.getTheme();
    final dark = THelperFunctions.isDarkMode(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        return Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            dividerText,
            style: Theme.of(context).textTheme.labelMedium!.apply(
              color: color ??
                  (_appTheme == 'light'
                      ? TColors.buttonSecondary
                      : TColors.white),
            ),
          ),
        );
        /*
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Divider gauche avec width*0.1
            SizedBox(
              width: screenWidth * 0.1,
              child: Divider(
                color: dark ? TColors.darkerGrey : TColors.grey,
                thickness: thikness,
              ),
            ),

            // Texte centré
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                dividerText,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                  color: color ??
                      (_appTheme == 'light'
                          ? TColors.buttonSecondary
                          : TColors.white),
                ),
              ),
            ),

            // Divider droite qui prend le reste
            Expanded(
              child: Divider(
                color: dark ? TColors.darkerGrey : TColors.grey,
                thickness: thikness,
              ),
            ),
          ],
        );
        */
      },
    );
  }
}

/*
class FormDividerWidget extends StatelessWidget {
   FormDividerWidget({
    super.key,
    required this.dividerText,
    this.thikness = 0.5,
     this.color
  });

  final String dividerText;
  double thikness;
  Color? color;

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils.getTheme();
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: dark ? TColors.darkerGrey : TColors.grey, thickness: thikness, indent: 80, endIndent: 5,)),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium!.apply(
          color: color ?? (_appTheme =='light' ? TColors.buttonSecondary : TColors.white)
        )),
        Flexible(child: Divider(color: dark ? TColors.darkerGrey : TColors.grey, thickness: thikness, indent: 5, endIndent: 30)),
      ],
    );
  }
}
*/