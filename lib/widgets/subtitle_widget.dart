import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({
    super.key,
    required this.subtitle,
    this.textAlign = TextAlign.left
  });

  final String subtitle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.gray700),
      textAlign: textAlign,
    );
  }
}