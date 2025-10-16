import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({
    super.key,
    required this.subtitle,
    this.textAlign = TextAlign.left,
    this.color = TColors.gray700,
    this.fontSizeDelta = 1,
    this.fontWeightDelta = 1
  });

  final String subtitle;
  final TextAlign textAlign;
  final  Color? color;
  final double fontSizeDelta;
  final int fontWeightDelta;

  @override
  Widget build(BuildContext context) {
    return Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall!
            .apply(color: color, fontSizeDelta: fontSizeDelta, fontWeightDelta: fontWeightDelta),
      textAlign: textAlign,
    );
  }
}