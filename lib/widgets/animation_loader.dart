import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils.getTheme();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8),
           SizedBox(height: 24.v),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.hw),
          child: Text(text,
            style: Theme.of(context).textTheme.titleMedium!
                .apply(color:_appTheme =='dark' ? TColors.white : TColors.black,
                fontSizeDelta: 2, fontWeightDelta: 2),
            textAlign: TextAlign.center,
          )),
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
    );
  }
}