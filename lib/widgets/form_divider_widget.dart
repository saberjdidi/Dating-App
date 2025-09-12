import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class FormDividerWidget extends StatelessWidget {
   FormDividerWidget({
    super.key,
    required this.dividerText,
    this.thikness = 0.5
  });

  final String dividerText;
  double thikness;

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: dark ? TColors.darkerGrey : TColors.grey, thickness: thikness, indent: 80, endIndent: 5,)),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium,),
        Flexible(child: Divider(color: dark ? TColors.darkerGrey : TColors.grey, thickness: thikness, indent: 5, endIndent: 30)),
      ],
    );
  }
}