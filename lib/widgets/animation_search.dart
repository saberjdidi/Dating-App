import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'typing_text_widget.dart';

class AnimationSearchWidget extends StatelessWidget {
  const AnimationSearchWidget({
    super.key,
    required this.textTitle,
    required this.textDescription,
    required this.image1,
    required this.image2,
    this.showAction = false,
    this.actionText,
    this.onActionPressed
  });

  final String textTitle;
  final String textDescription;
  final String image1;
  final String image2;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils().getThemeData();

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.v),
            GradientText(
              text: textTitle,
              fontSize: 30.adaptSize,
              textAlign: TextAlign.center,
              gradient: const LinearGradient(
                colors: [TColors.yellowAppLight, TColors.yellowAppDark], // green gradient
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: CustomImageView(
                imagePath: image1,
                //height: 100.adaptSize,
                //width: 100.adaptSize,
                fit: BoxFit.fill,
              ),
            ),

             //SizedBox(height: 15.v),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Text(textDescription,
                    style: Theme.of(context).textTheme.bodySmall!
                        .apply(color:_appTheme =='dark' ? appTheme.whiteA700 : appTheme.black, fontSizeDelta: 1, fontWeightDelta: 1),
                    textAlign: TextAlign.center,
                  ), */
                  CupertinoActivityIndicator(
                    radius: 20.0, // Larger indicator
                    color: TColors.yellowAppDark, // Custom color
                  ),
                  SizedBox(width: 10.hw,),
                  TypingTextWidget(
                    texts: [
                      'مطابقة الأشخاص مع متطلباتك',
                      'جمع أفضل المباريات بالنسبة لك',
                      'تم العثور على 23 مباراة...'
                    ],
                    textStyle: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: _appTheme == 'dark' ? appTheme.whiteA700 : appTheme.black,
                      fontSizeDelta: 1,
                      fontWeightDelta: 1,
                    ),
                    speed: const Duration(milliseconds: 80),
                    pause: const Duration(milliseconds: 1000),
                    cursor: '|',
                    cursorColor: TColors.blueDating,
                  )

                ],
              ),
            ),

            Material(
              type: MaterialType.transparency,
              child: CustomImageView(
                imagePath: image2,
                //height: 100.adaptSize,
                //width: 100.adaptSize,
                fit: BoxFit.fill,
              ),
            ),
             SizedBox(height: 24.v),
            showAction
                ? SizedBox(
              width: 250,
              child: OutlinedButton(
                  onPressed: onActionPressed,
                  style: OutlinedButton.styleFrom(backgroundColor: appTheme.dark),
                  child: Text(actionText!,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(color: appTheme.light),
                  )
              ),
            )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}