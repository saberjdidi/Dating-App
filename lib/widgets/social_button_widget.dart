import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class SocialButtonsWidget extends StatelessWidget {
   SocialButtonsWidget({
    super.key,
    this.onPressed,
     this.width = 25,
     this.height = 25,
  });

  VoidCallback? onPressed;
   final double? width;
   final double? height;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //decoration: BoxDecoration(border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => onPressed,
            icon: Image(
              width: width,
              height: height,
              image: AssetImage(ImageConstant.google),
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Container(
          //decoration: BoxDecoration(border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: (){},
            icon: Image(
              width: width,
              height: height,
              image: AssetImage(ImageConstant.apple),
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Container(
          //decoration: BoxDecoration(border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: (){},
            icon: Image(
              width: width,
              height: height,
              image: AssetImage(ImageConstant.facebook),
            ),
          ),
        ),
      ],
    );
  }
}