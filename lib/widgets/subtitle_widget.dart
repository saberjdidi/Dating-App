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
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall!
            .apply(color: color, fontSizeDelta: fontSizeDelta, fontWeightDelta: fontWeightDelta),
      textAlign: textAlign,
    );
  }
}

class SubTitle2Widget extends StatelessWidget {
  const SubTitle2Widget({
    super.key,
    required this.subtitle,
    this.textAlign = TextAlign.start, // ✅ meilleure compatibilité RTL/LTR
    this.color = TColors.gray700,
    this.fontSizeDelta = 1,
    this.fontWeightDelta = 1,
    this.maxLine = 1,
  });

  final String subtitle;
  final TextAlign textAlign;
  final Color? color;
  final double fontSizeDelta;
  final int fontWeightDelta;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth, // ✅ limite la largeur
          child: Text(
            subtitle,
            textAlign: textAlign,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: maxLine,
            style: Theme.of(context).textTheme.bodySmall!.apply(
              color: color,
              fontSizeDelta: fontSizeDelta,
              fontWeightDelta: fontWeightDelta,
            ),
          ),
        );
      },
    );
  }
}