import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
   TitleWidget({
    super.key,
    required this.title,
    this.textAlign = TextAlign.left,
    this.fontWeightDelta = 2,
    this.fontSizeDelta = 0.0,
     this.color = TColors.black
   });

  final String title;
  final TextAlign textAlign;
  int fontWeightDelta;
  double fontSizeDelta;
  Color color;

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils().getThemeData();

    return Text(title,
        style: Theme.of(context).textTheme.headlineMedium!.apply(
            color: _appTheme =='light'
                ? color
                : TColors.white,
          //fontSizeDelta: 2,
          fontWeightDelta: fontWeightDelta,
          fontSizeDelta: fontSizeDelta
        ),
      textAlign: textAlign,
    );
  }
}