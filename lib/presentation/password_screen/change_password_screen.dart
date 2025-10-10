import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/controller/change_password_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'password_success_screen.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  ChangePasswordScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeyChangePassword = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        child: Form(
          key: controller.formChangePasswordKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Scaffold(
            key: _scaffoldKeyChangePassword,
              resizeToAvoidBottomInset: false,
              //backgroundColor: _appTheme =='light' ? TColors.white : appTheme.primaryColor,
              appBar: TAppBar(
                showAction: true,
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 24.hw, vertical: 11.v),
                    child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CustomImageView(
                              imagePath: ImageConstant.logoHeader,
                              height: 200.adaptSize,
                              width: 200.adaptSize,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                          Text("إنشاء كلمة مرور جديدة",
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .apply(color: _appTheme =='light' ? TColors.black : TColors.white,
                                  fontWeightDelta: 2, fontSizeDelta: 2),
                              textAlign: TextAlign.center),
                          SizedBox(height: TSizes.spaceBtwSections),

                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextFormField(
                              controller: controller.passwordController,
                              hintText: "كلمة المرور".tr,
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              prefixConstraints: BoxConstraints(maxHeight: 60.v),
                              contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                              validator: (value) => Validator.validateEmptyText("Password".tr, value),
                              obscureText: controller.isShowPassword.value,
                              fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                              hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                              textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwInputFields.adaptSize),

                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextFormField(
                              controller: controller.confirmPasswordController,
                              hintText: "تأكيد كلمة المرور".tr,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              prefixConstraints: BoxConstraints(maxHeight: 60.v),
                             /* suffix: InkWell(onTap: () {controller.isShowPassword.value = !controller.isShowPassword.value;},
                                  child: Container(margin: EdgeInsets.fromLTRB(30.hw, 20.v, 20.hw, 20.v),
                                      child: CustomImageView(
                                          imagePath: ImageConstant.imgEye,
                                          height: 20.adaptSize,
                                          width: 20.adaptSize)
                                  )), */
                              suffixConstraints: BoxConstraints(maxHeight: 60.v),
                              validator: (value) => Validator.validateEmptyText("Confirm Password".tr, value),
                              obscureText: controller.isShowPassword.value,
                              contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                              fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                              hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                              textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            ),
                          ),
                        ]
                    ))
              ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: TSizes.spaceBtwSections.v * 3, left: TSizes.spaceBtwItems.hw, right: TSizes.spaceBtwItems.hw),
              //child: _buildButtonSection()
              child:
              CustomButtonContainer(
                text:"إعادة تعيين كلمة المرور".tr,
                color1: TColors.yellowAppDark,
                color2: TColors.yellowAppLight,
                borderRadius: 20.adaptSize,
                colorText: TColors.black,
                fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                height: isSmallPhone ? 80.v : 70.v,
                width: Get.width,
                onPressed: () async {
                  controller.passwordFn(context);
                },
              ),
            ),
          ),
        ));
  }

  onTapPasswordSuccessPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  PassswordSuccessScreen()),
    );
  }
  /// Navigates to the previous screen.
  onTapImgArrowLeft() {
    //Get.back();
    SystemNavigator.pop(); // Exit the app
  }
}
