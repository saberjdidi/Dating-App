
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = TSizes.cardRadiusLg,
    this.isBorderRadiusTop = false,
    this.child,
    this.showBorder = false,
    this.borderColor = TColors.borderPrimary,
    this.withBorder = 1.0,
    this.backgroundColor = TColors.white,
    this.margin,
    this.padding
  });

  final double? width;
  final double? height;
  final double radius;
  final bool isBorderRadiusTop;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final double withBorder;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: isBorderRadiusTop
              ? BorderRadius.only(topRight: Radius.circular(radius), topLeft: Radius.circular(radius))
               : BorderRadius.circular(radius),
          color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor, width: withBorder) : null
      ),
      child: child,
    );
  }
}
