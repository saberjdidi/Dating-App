import 'package:flutter/material.dart';
import '../../core/utils/constants/colors.dart';
import '../../core/utils/size_utils.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
    key: key,
  );

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text,
          style: isTablet
            ? Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: TColors.black,
            fontSize: 18.fSize
          )
          : Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
              color: TColors.black
          ),
        ),
      ),
    );
  }
}