import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.md),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomImageView(
              imagePath: image,
              width: THelperFunctions.screenWidth() * 0.9,
              height: THelperFunctions.screenHeight() * 0.6,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(15),
            ),
           /* Image(
                width: THelperFunctions.screenWidth() * 0.8,
                height: THelperFunctions.screenHeight() * 0.6,
                image: AssetImage(image),), */

            Padding(
              padding: const EdgeInsets.only(top: TSizes.spaceBtwItems),
              child: Text(title,
                  style: Theme.of(context).textTheme.headlineMedium!
                      .apply(color: TColors.yellowAppDark, fontSizeDelta: 2, fontWeightDelta: 2),
                  textAlign: TextAlign.center),
            ),

            const SizedBox(height: TSizes.spaceBtwItems,),

            Text(subTitle,
                style: Theme.of(context).textTheme.bodyMedium!
                    .apply(color: TColors.buttonSecondary, fontSizeDelta: 2),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}