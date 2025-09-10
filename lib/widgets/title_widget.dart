import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    this.textAlign = TextAlign.left
  });

  final String title;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils().getThemeData();

    return Text(title,
        style: Theme.of(context).textTheme.headlineMedium!.apply(
            color: _appTheme =='light' ? TColors.black : TColors.white,
          //fontSizeDelta: 2,
          fontWeightDelta: 2
        ),
      textAlign: textAlign,
    );
  }
}