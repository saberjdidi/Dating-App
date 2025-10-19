import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/presentation/sign_in_screen/controller/sign_in_controller.dart';
import 'package:dating_app_bilhalal/widgets/custom_divider.dart';
import 'package:dating_app_bilhalal/widgets/custom_term_privacy_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/social_button_widget.dart';
import 'package:dating_app_bilhalal/widgets/swip_back_wrapper.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatelessWidget {
//class SignInScreen extends GetView<SignInController> {
  SignInScreen({super.key});

  final controller = Get.put(SignInController());

  final GlobalKey<ScaffoldState> _scaffoldKeySignin = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SwipeBackWrapper(
      actionType: SwipeBackAction.systemPop,
      child: Scaffold(
        key: _scaffoldKeySignin,
          resizeToAvoidBottomInset: true, // important pour éviter que le clavier cache le champ
          //backgroundColor: _appTheme =='light' ? TColors.white : appTheme.primaryColor,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
                key: controller.formLoginKey.value,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 24.hw, right: 24.hw, top: 11.v, bottom: MediaQuery.of(context).viewInsets.bottom + 11.v),
                    //padding: EdgeInsets.symmetric(horizontal: 24.hw, vertical: 11.v),
                    child: Column(
                        children: [
                          Visibility(
                            visible: false,
                            child: CustomImageView(
                                imagePath: _appTheme =='dark'
                                    ? ImageConstant.imgArrowLeftWhite : ImageConstant.imgArrowLeftBlack,
                                height: 28.adaptSize,
                                width: 28.adaptSize,
                                alignment: Alignment.centerLeft,
                                onTap: () {onTapImgArrowLeft();}
                            ),
                          ),
                          SizedBox(height: 10.v),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: (){
                                  SystemNavigator.pop();
                                  //Navigator.of(context).pop();
                                },
                                icon: Icon(Iconsax.arrow_right_1, color: _appTheme =='light' ? TColors.black : TColors.white)
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwSections),
                          Align(
                            alignment: Alignment.center,
                            child: CustomImageView(
                              imagePath: ImageConstant.logo,
                              height: 150.adaptSize,
                              width: 150.adaptSize,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                          Text("تسجيل الدخول",
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .apply(color: _appTheme =='light' ? TColors.black : TColors.primaryColorApp, fontWeightDelta: 2),
                              textAlign: TextAlign.center),
                          SizedBox(height: TSizes.spaceBtwSections),
                          Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///Email
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  //textDirection: controller.isRTL.value ? TextDirection.rtl : TextDirection.ltr,
                                  child: CustomTextFormField(
                                    controller: controller.emailController,
                                    onChange: (value) => controller.isRTL.value = TDeviceUtils.isArabic(value),
                                    focusNode: controller.emailFocus,
                                    onTap: () => FocusScope.of(context).requestFocus(controller.emailFocus),
                                    onEditingComplete: () => FocusScope.of(context).requestFocus(controller.passwordFocus),
                                    hintText: "البريد الإلكتروني".tr,
                                    textInputType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    prefixConstraints: BoxConstraints(maxHeight: 60.v),
                                    contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                                    validator: Validator.validateEmail,
                                    fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                                    hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                                    textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwInputFields,),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  //textDirection: controller.isRTL.value ? TextDirection.rtl : TextDirection.ltr,
                                  child: CustomTextFormField(
                                    controller: controller.passwordController,
                                    onChange: (value) => controller.isRTL.value = TDeviceUtils.isArabic(value),
                                    focusNode: controller.passwordFocus,
                                    onTap: () => FocusScope.of(context).requestFocus(controller.passwordFocus),
                                    onEditingComplete: () => FocusScope.of(context).requestFocus(controller.passwordFocus),
                                    hintText: "كلمة المرور".tr,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.visiblePassword,  prefixConstraints: BoxConstraints(maxHeight: 60.v),
                                    suffixConstraints: BoxConstraints(maxHeight: 60.v),
                                    validator: (value) => Validator.validatePassword(value),
                                    obscureText: controller.isShowPassword.value,
                                    contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                                    fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                                    hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                                    textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwSections,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector (
                                        onTap: () {
                                          onTapTxtForgotThePassword();
                                        },
                                        child: Padding(padding: EdgeInsets.only(left: 8.hw),
                                            child: Text("نسيت كلمة المرور؟",
                                              //style: CustomTextStyles.titleMediumBlueVPT
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                color: _appTheme =='light' ? TColors.blackGrey : TColors.white,
                                                fontSize: 16.fSize,
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.underline,
                                                decorationColor: _appTheme =='light' ? TColors.black54 : TColors.white,
                                              ),
                                            )
                                        )
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          onTapTxtSignUp();
                                        },
                                        child: Padding(padding: EdgeInsets.only(left: 8.hw),
                                            child: Text("إنشاء حساب؟",
                                              //style: CustomTextStyles.titleMediumBlueVPT
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                color: _appTheme =='light' ? TColors.blackGrey : TColors.white,
                                                fontSize: 16.fSize,
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.underline,
                                                decorationColor: _appTheme =='light' ? TColors.black54 : TColors.white,
                                              ),
                                            )
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24.v),
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomButtonContainer(
                                    text: "تسجيل الدخول",
                                    color1: TColors.primaryColorApp,
                                    color2: TColors.primaryColorApp,
                                    borderRadius: 10,
                                    colorText: TColors.white,
                                    paddingHorizontal: 1.hw,
                                    fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                                    height: isSmallPhone ? 80.v : 70.v,
                                    width: screenWidth,
                                    onPressed: () async {
                                      //controller.emailAndPasswordSignIn();
                                      controller.loginFn();
                                    },
                                  ),
                                ),
                                SizedBox(height: 28.v),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(child: Divider(color: _appTheme =='light' ? TColors.black54 : TColors.white, thickness: 0.3, indent: 60, endIndent: 5,)),
                                    Text("أو سجّل  مع".tr,
                                        style:Theme.of(context).textTheme.titleMedium!.copyWith(
                                          color: _appTheme =='light' ?TColors.black54 : TColors.white,
                                          fontSize: 18.fSize,
                                          fontWeight: FontWeight.w400,
                                          //decoration: TextDecoration.underline
                                        )

                                    ),
                                    Flexible(child: Divider(color: _appTheme =='light' ? TColors.black54 : TColors.white, thickness: 0.3, indent: 5, endIndent: 60)),
                                  ],
                                ),

                                ///Divider
                                //FormDividerWidget(dividerText: TTexts.orSignInWith.capitalize!),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                ///Footer
                                SocialButtonsWidget(width: 60.adaptSize, height: 60.adaptSize,),

                                //CustomTermPrivacyWidget(),
                                //SizedBox(height: 10.v),
                              ]
                          )),
                          //_buildLoginForm(context),
                          SizedBox(height: 10.v),

                          CustomTermPrivacyWidget(),
                          SizedBox(height: 5.v)
                        ]
                    ))
            ),
          )),
    );
  }

  /*
  /// Section Widget
  Widget _buildLoginForm(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Email
          Directionality(
            textDirection: TextDirection.rtl,
            //textDirection: controller.isRTL.value ? TextDirection.rtl : TextDirection.ltr,
            child: CustomTextFormField(
              controller: controller.emailController,
              onChange: (value) => controller.isRTL.value = TDeviceUtils.isArabic(value),
              focusNode: controller.emailFocus,
              onTap: () => FocusScope.of(context).requestFocus(controller.emailFocus),
              onEditingComplete: () => FocusScope.of(context).requestFocus(controller.passwordFocus),
              hintText: "البريد الإلكتروني".tr,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              /*  prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgCheckmark,
                      height: 20.adaptSize,
                      width: 20.adaptSize)
              ), */
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
              validator: Validator.validateEmail,
              fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
              hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
              textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields,),
          Directionality(
            textDirection: TextDirection.rtl,
            //textDirection: controller.isRTL.value ? TextDirection.rtl : TextDirection.ltr,
            child: CustomTextFormField(
              controller: controller.passwordController,
              onChange: (value) => controller.isRTL.value = TDeviceUtils.isArabic(value),
              focusNode: controller.passwordFocus,
              onTap: () => FocusScope.of(context).requestFocus(controller.passwordFocus),
              onEditingComplete: () => FocusScope.of(context).requestFocus(controller.passwordFocus),
              hintText: "كلمة المرور".tr,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              /* prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                    child: CustomImageView(imagePath: ImageConstant.imgLock, height: 20.adaptSize, width: 20.adaptSize)),
                */
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              /* suffix: InkWell(onTap: () {controller.isShowPassword.value = !controller.isShowPassword.value;},
                    child: Container(margin: EdgeInsets.fromLTRB(30.hw, 20.v, 20.hw, 20.v),
                        child: CustomImageView(
                            imagePath: ImageConstant.imgEye,
                            height: 20.adaptSize,
                            width: 20.adaptSize)
                    )), */
              suffixConstraints: BoxConstraints(maxHeight: 60.v),
              validator: (value) => Validator.validatePassword(value),
              obscureText: controller.isShowPassword.value,
              contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
              fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
              hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
              textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector (
                  onTap: () {
                    onTapTxtForgotThePassword();
                  },
                  child: Padding(padding: EdgeInsets.only(left: 8.hw),
                      child: Text("نسيت كلمة المرور؟",
                        //style: CustomTextStyles.titleMediumBlueVPT
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: _appTheme =='light' ? TColors.blackGrey : TColors.white,
                          fontSize: 16.fSize,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: _appTheme =='light' ? TColors.black54 : TColors.white,
                        ),
                      )
                  )
              ),
              GestureDetector(
                  onTap: () {
                    onTapTxtSignUp();
                  },
                  child: Padding(padding: EdgeInsets.only(left: 8.hw),
                      child: Text("إنشاء حساب؟",
                        //style: CustomTextStyles.titleMediumBlueVPT
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: _appTheme =='light' ? TColors.blackGrey : TColors.white,
                          fontSize: 16.fSize,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: _appTheme =='light' ? TColors.black54 : TColors.white,
                        ),
                      )
                  )
              ),
            ],
          ),
          SizedBox(height: 24.v),
          Align(
            alignment: Alignment.center,
            child: CustomButtonContainer(
              text: "تسجيل الدخول",
              color1: TColors.primaryColorApp,
              color2: TColors.primaryColorApp,
              borderRadius: 10,
              colorText: TColors.white,
              paddingHorizontal: 1.hw,
              fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
              height: isSmallPhone ? 80.v : 70.v,
              width: screenWidth,
              onPressed: () async {
                //controller.emailAndPasswordSignIn();
                controller.loginFn();
              },
            ),
          ),
          /*  CustomElevatedButton(
              buttonStyle: CustomButtonStyles.elevatedBlueLight700Radius10,
              text: "Connexion".tr,
              onPressed: (){
                controller.checkLogin(context);
              }
          ), */
          SizedBox(height: 28.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Divider(color: _appTheme =='light' ? TColors.black54 : TColors.white, thickness: 0.3, indent: 60, endIndent: 5,)),
              Text("أو سجّل  مع".tr,
                  style:Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: _appTheme =='light' ?TColors.black54 : TColors.white,
                    fontSize: 18.fSize,
                    fontWeight: FontWeight.w400,
                    //decoration: TextDecoration.underline
                  )

              ),
              Flexible(child: Divider(color: _appTheme =='light' ? TColors.black54 : TColors.white, thickness: 0.3, indent: 5, endIndent: 60)),
            ],
          ),

          ///Divider
          //FormDividerWidget(dividerText: TTexts.orSignInWith.capitalize!),

          const SizedBox(height: TSizes.spaceBtwItems),

          ///Footer
          SocialButtonsWidget(width: 60.adaptSize, height: 60.adaptSize,),

          //CustomTermPrivacyWidget(),
          //SizedBox(height: 10.v),
        ]
    ));
  } */

  /// Navigates to the previous screen.
  onTapImgArrowLeft() {
    //Get.back();
    SystemNavigator.pop(); // Exit the app
  }
  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgotThePassword() {
    Get.toNamed(Routes.forgetPasswordScreen, );
  }
  /// Navigates to the signUpBlankScreen when the action is triggered.
  onTapTxtSignUp() {
    Get.toNamed(Routes.signUpScreen, );
  }
}
