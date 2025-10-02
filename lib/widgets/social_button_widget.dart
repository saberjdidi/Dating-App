import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/sign_in_screen/controller/sign_in_controller.dart';
import 'package:dating_app_bilhalal/presentation/signup_screen/controller/social_buttons_controller.dart';
import 'package:flutter/material.dart';

class SocialButtonsWidget extends StatelessWidget {
  final SocialButtonsController controller = Get.put(SocialButtonsController());
  final SignInController signInController = Get.put(SignInController());

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
            onPressed: () => signInController.loginWithGoogle(),
            //onPressed: () => signInController.googleSignIn(),
            //onPressed: () => controller.loginWithGoogle(),
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
            onPressed:  () => controller.loginWithFacebook(),
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