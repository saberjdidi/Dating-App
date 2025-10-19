import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/controller/forget_password_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  ForgetPasswordScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeyForgetPassword = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        top: false,
        child: Form(
          key: controller.formForgetPasswordKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Scaffold(
            key: _scaffoldKeyForgetPassword,
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
                          SizedBox(height: TSizes.spaceBtwItems),
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
                          Center(child: TitleWidget(title: "هل نسيت كلمة المرور؟",
                            color:  _appTheme =='light' ? TColors.black : TColors.white,
                            textAlign: TextAlign.center,)),
                          Center(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: SubTitleWidget(subtitle: "سنرسل لك رمزًا مكونًا من 6 أرقام على البريد الإلكتروني المسجل لإعادة تعيين كلمة المرور.",
                                color:  _appTheme =='light' ? TColors.black : TColors.white,
                                textAlign: TextAlign.center,),
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),

                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextFormField(
                              controller: controller.emailController,
                              hintText: "بريد إلكتروني".tr,
                              textInputType: TextInputType.emailAddress,
                              prefixConstraints: BoxConstraints(maxHeight: 60.v),
                              contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                              validator: Validator.validateEmail,
                              fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                              hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                              textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwSections.adaptSize * 2),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Obx(() => CustomButtonContainer(
                              text:"يرسل OTP".tr,
                              color1: TColors.primaryColorApp,
                              color2: TColors.primaryColorApp,
                              borderRadius: 10,
                              colorText: TColors.white,
                              fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                              height: isSmallPhone ? 80.v : 70.v,
                              width: Get.width,
                              onPressed: controller.isDataProcessing.value
                                  ? null // désactive le clic pendant chargement
                                  : () async {
                                controller.forgetPasswordFn();
                              },
                              child: controller.isDataProcessing.value
                                ? const SizedBox(
                              height: 28,
                              width: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                                : null,
                            )),
                          )
                        ]
                    ))
            ),
           /* bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: TSizes.spaceBtwSections.v, left: TSizes.spaceBtwItems.hw, right: TSizes.spaceBtwItems.hw),
              //child: _buildButtonSection()
              child:
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomButtonContainer(
                  text:"يرسل OTP".tr,
                  color1: TColors.primaryColorApp,
                  color2: TColors.primaryColorApp,
                  borderRadius: 10,
                  colorText: TColors.white,
                  fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                  height: isSmallPhone ? 80.v : 70.v,
                  width: Get.width,
                  onPressed: () async {
                    controller.forgetPasswordFn();
                  },
                ),
              ),
            ), */
          ),
        ));
  }

  /// Navigates to the previous screen.
  onTapImgArrowLeft() {
    //Get.back();
    SystemNavigator.pop(); // Exit the app
  }
}