import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/app_export.dart';
import '../../core/utils/pref_utils.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var isLight = PrefUtils.getTheme() == "light";
    return Shimmer.fromColors(
      baseColor: isLight ? Colors.grey[400]! : Colors.grey[850]!,
      highlightColor: isLight ? Colors.grey[200]! : Colors.grey[700]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color ?? (isLight ? TColors.white : TColors.darkerGrey),
            borderRadius: BorderRadius.circular(radius)
        ),
      ),
    );
  }
}