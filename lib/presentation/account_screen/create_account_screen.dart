import 'dart:ffi';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/datasources/onboarding_local_data_source.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/controller/create_account_controller.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class CreateAccountScreen extends GetWidget<CreateAccountController> {
  CreateAccountScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeySignUpStepper = GlobalKey<ScaffoldState>();
  final PageController _pageSignupStepperController = PageController();
  var _appTheme = PrefUtils().getThemeData();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Obx(() =>
          Form(
            key: controller.formSignUpStepperKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Scaffold(
              backgroundColor: _appTheme =='light' ? TColors.white : appTheme.primaryColor,
              body: Padding(
                padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                    /*  IconStepper(
                        activeStep: controller.activeStep.value,
                        //stepCount: controller.dotCount.value,
                        steppingEnabled: true,
                        enableNextPreviousButtons: false,
                        lineLength: 50, // longueur entre les étapes
                        lineDotRadius: 4,
                        lineColor: Colors.grey, // couleur par défaut
                        //lineActiveColor: Colors.black, // couleur une fois rempli
                        icons: List.generate(
                          controller.dotCount.value,
                              (index) => Icon(
                            Icons.circle,
                            color: index <= controller.activeStep.value
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        onStepReached: (index) {
                          controller.activeStep.value = index;
                        },
                      ), */
                      DotStepper(
                        activeStep: controller.activeStep.value,
                        dotCount: controller.dotCount.value,
                        dotRadius: 10,
                        shape: Shape.stadium,
                        spacing: 10,
                        indicator: Indicator.slide,
                        /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
                        onDotTapped: (tappedDotIndex) {
                          controller.activeStep.value = tappedDotIndex;
                        },
                        // DOT-STEPPER DECORATIONS
                        fixedDotDecoration: FixedDotDecoration(
                          color: TColors.greyDating,
                        ),
                        indicatorDecoration: IndicatorDecoration(
                          // style: PaintingStyle.stroke,
                          // strokeWidth: 8,
                          color: TColors.black,
                        ),
                        lineConnectorDecoration: LineConnectorDecoration(
                          color: TColors.yellowAppDark,
                          strokeWidth: 1,
                        ),
                      ),

                      controller.activeStep.value == 0
                          ? _buildBasicDetailsForm(context)
                          : controller.activeStep.value == 1
                          ? _buildCoordonnerForm()
                          : _buildPasswordForm(),

                      /// Jump buttons.
                      Visibility(
                        visible: false,
                        child: Padding(padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(controller.dotCount.value, (index) {
                                return ElevatedButton(
                                  child: Text('${index + 1}'),
                                  onPressed: (){
                                    controller.activeStep.value = index;
                                  },
                                );
                              }),
                            )
                        ),
                      ),
                      // Next and Previous buttons.
                      Visibility(
                        visible: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: Text('Prev', style: TextStyle(color: TColors.black),),
                              onPressed: () {
                                // activeStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
                                if (controller.activeStep.value > 0) {
                                  controller.activeStep.value--;
                                }
                              },
                            ),

                            ElevatedButton(
                              child: Text('Next', style: TextStyle(color: TColors.black),),
                              onPressed: () {
                                /// ACTIVE STEP MUST BE CHECKED FOR (dotCount - 1) AND NOT FOR dotCount To PREVENT Overflow ERROR.
                                if (controller.activeStep.value < controller.dotCount.value - 1) {
                                  controller.activeStep.value++;
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(bottom: TSizes.spaceBtwItems.v, left: TSizes.spaceBtwItems.hw, right: TSizes.spaceBtwItems.hw),
                  //child: _buildButtonSection()
                  child:
                CustomButtonContainer(
                  text: controller.activeStep.value < 2 ? "التالي".tr : "lbl_save".tr,
                  color1: TColors.yellowAppDark,
                  color2: TColors.yellowAppLight,
                  borderRadius: 10,
                  colorText: TColors.white,
                  fontSize: 20.adaptSize,
                  onPressed: () async {
                    if (controller.activeStep.value < controller.dotCount.value - 1) {
                      controller.activeStep.value++;
                    } else {
                      controller.saveBtn();
                    }
                    //dialogVerifyAccount(context);
                  },
                ),
              ),
            ),
          )),
    );

  }

  /// Section Identity
  Widget _buildBasicDetailsForm(BuildContext context) {

    double sliderValue = controller.currentSliderValue.value.toDouble();
    double weightValue = controller.currentWeightValue.value.toDouble();
    double heightValue = controller.currentHeightValue.value.toDouble();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: TSizes.spaceBtwItems),
            Align(
                alignment: Alignment.topRight,
                child: TitleWidget(title: "التفاصيل الأساسية".tr)
            ),
            Align(
                alignment: Alignment.topRight,
                child: SubTitleWidget(subtitle: "ومعلوماتك الأساسية.".tr)
            ),
            SizedBox(height: TSizes.spaceBtwSections * 2),
            /*  CustomTextFormField(
              enabled: true,
              controller: controller.emailController,
              hintText: "lbl_email".tr,
              textInputType: TextInputType.text,
              prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.user_octagon)
              ),
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, bottom: 21.v),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,), */
            CustomTextFormField(
              controller: controller.fullNameController,
              hintText: "${'الاسم الكامل'.tr} *",
              textInputType: TextInputType.text,
              /* prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.user_octagon)
              ), */
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, bottom: 21.v),
              validator: (value) => Validator.validateEmptyText('${'lbl_lastName'.tr}', value),
            ),
            SizedBox(height: TSizes.spaceBtwItems.v),
            CustomTextFormField(
              controller: controller.bioController,
              hintText: "${'بایو'.tr} *",
              maxLines: 3,
              textInputType: TextInputType.text,
              /* prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.user)
              ), */
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, bottom: 21.v),
              validator: (value) => Validator.validateEmptyText('${'lbl_firstName'.tr}', value),
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "جنسك", thikness: 2),
            SizedBox(height: TSizes.spaceBtwItems.v),

            /* Obx(() => Row(
              children: [
                //Text('Product Type', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: TSizes.spaceBtwItems),
                //Radio button for single Product Type
                RadioMenuButton(
                    value: 0,
                    groupValue: controller.sexValue.value,
                    onChanged: (value){
                      //Update the selected product type in the controller
                      controller.sexValue.value = 0;
                      debugPrint("femme : ${controller.sexValue.value}");
                    },
                    child: const Text('امراة')
                ),
                RadioMenuButton(
                    value: 1,
                    groupValue: controller.sexValue.value,
                    onChanged: (value){
                      controller.sexValue.value = 1;
                      debugPrint("homme : ${controller.sexValue.value}");
                    },
                    child: const Text('رجل')
                ),
              ],
            )), */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: controller.sexValue.value,
                  onChanged: (value) {
                    controller.sexValue.value = value!;
                    debugPrint("femme : ${controller.sexValue.value}");
                  },
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return TColors.yellowAppDark; // ✅ Cercle actif jaune
                    }
                    return Colors.grey; // Cercle inactif gris
                  }),
                ),
                TitleWidget(title: 'امراة',),

                Radio<int>(
                  value: 1,
                  groupValue: controller.sexValue.value,
                  onChanged: (value) {
                    controller.sexValue.value = value!;
                    debugPrint("homme : ${controller.sexValue.value}");
                  },
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return TColors.yellowAppDark;
                    }
                    return Colors.grey;
                  }),
                ),
                TitleWidget(title: 'رجل',),
              ],
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "عمر", thikness: 2),
            SizedBox(height: TSizes.spaceBtwItems.v),
            /*
            Obx(() => Slider(
              //year2023: year2023,
              value: double.parse(controller.currentSliderValue.value.toString()),
              max: 100,
              divisions: 100,
              label: controller.currentSliderValue.round().toString(),
              onChanged: (double value) {
                controller.currentSliderValue.value = value.toInt();

              },
              activeColor: TColors.yellowAppDark,
              secondaryActiveColor: Colors.redAccent,
              inactiveColor: TColors.greyDating,
              thumbColor: Colors.redAccent,
            )), */
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Afficher l’âge sous le slider
                Text("${sliderValue.round()}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                // Slider avec gradient, label toujours visible, hauteur augmentée
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [TColors.yellowAppLight, Colors.redAccent], // ✅ Dégradé
                    ).createShader(bounds);
                  },
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8, // ✅ Augmenter la hauteur du slider
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      showValueIndicator: ShowValueIndicator.always, // ✅ Toujours afficher label
                    ),
                    child: Slider(
                      value: sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: sliderValue.round().toString(),
                      onChanged: (value) {
                        controller.currentSliderValue.value = value.toInt();
                      },
                      activeColor: Colors.white, // ✅ Couleur appliquée par gradient
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "الوزن", thikness: 2),
            SizedBox(height: TSizes.spaceBtwItems.v),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Afficher l’âge sous le slider
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text("${weightValue.round()} KG",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                // Slider avec gradient, label toujours visible, hauteur augmentée
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [TColors.yellowAppLight, Colors.redAccent], // ✅ Dégradé
                    ).createShader(bounds);
                  },
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8, // ✅ Augmenter la hauteur du slider
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      showValueIndicator: ShowValueIndicator.always, // ✅ Toujours afficher label
                    ),
                    child: Slider(
                      value: weightValue,
                      min: 0,
                      max: 140,
                      divisions: 140,
                      label: weightValue.round().toString(),
                      onChanged: (value) {
                        controller.currentWeightValue.value = value.toInt();
                      },
                      activeColor: Colors.white, // ✅ Couleur appliquée par gradient
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "الطول", thikness: 2),
            SizedBox(height: TSizes.spaceBtwItems.v),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Afficher l’âge sous le slider
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text("${heightValue.round()} CM",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                // Slider avec gradient, label toujours visible, hauteur augmentée
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [TColors.yellowAppLight, Colors.redAccent], // ✅ Dégradé
                    ).createShader(bounds);
                  },
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8, // ✅ Augmenter la hauteur du slider
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      showValueIndicator: ShowValueIndicator.always, // ✅ Toujours afficher label
                    ),
                    child: Slider(
                      value: heightValue,
                      min: 100,
                      max: 220,
                      divisions: 220,
                      label: heightValue.round().toString(),
                      onChanged: (value) {
                        controller.currentHeightValue.value = value.toInt();
                      },
                      activeColor: Colors.white, // ✅ Couleur appliquée par gradient
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),

          ]
      )),
    );
  }
  /// Section Coordonner
  Widget _buildCoordonnerForm() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: TSizes.spaceBtwItems),
          Align(
              alignment: Alignment.topLeft,
              child: TitleWidget(title: "lbl_entrer_vos_coordonnées".tr)
          ),
          Align(
              alignment: Alignment.topLeft,
              child: SubTitleWidget(subtitle: "lbl_inscrivez_vos_coordonnées".tr)
          ),
          SizedBox(height: TSizes.spaceBtwSections * 2),
         /* IntlPhoneField(
            decoration: InputDecoration(
                labelText: '${'lbl_phone_number'.tr} *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.hw),
                  //borderSide: BorderSide.none,
                ),
                hintStyle: CustomTextStyles.titleLargeGray400,
                labelStyle: CustomTextStyles.titleMediumSemiBoldBlack,
                errorStyle: CustomTextStyles.bodyMediumOnError,
                counterStyle: CustomTextStyles.titleMedium16BlueLight700,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.hw),
                  borderSide: BorderSide(color: Color(0xFD636262), width: 1),
                  //borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.hw),
                    borderSide: BorderSide(color: TColors.blueLight700, width: 2)
                  //borderSide: BorderSide.none,
                ),
                fillColor: TColors.white
            ),
            initialCountryCode: 'CA',
            onChanged: (phone) {
              debugPrint('Phone number : ${phone.completeNumber}');
              controller.phoneController.text = phone.completeNumber;
            },
          ), */
          const SizedBox(height: TSizes.spaceBtwInputFields,),
          CustomTextFormField(
              controller: controller.villeController,
              hintText: "${'lbl_city'.tr} *",
              textInputType: TextInputType.text,
              prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.building)
              ),
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, bottom: 21.v),
              validator: (value) => Validator.validateEmptyText('lbl_city'.tr, value)
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields,),
          CustomTextFormField(
              controller: controller.codePostalController,
              hintText: "${'lbl_code_postal'.tr} *",
              textInputType: TextInputType.text,
              prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.code)
              ),
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, bottom: 21.v),
              validator: (value) => Validator.validateEmptyText('lbl_code_postal'.tr, value)
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields,),
          Visibility(
            visible: false,
            child: CustomTextFormField(
                controller: controller.regionController,
                hintText: "Région *",
                textInputType: TextInputType.text,
                prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                    child: Icon(Iconsax.activity)
                ),
                prefixConstraints: BoxConstraints(maxHeight: 60.v),
                contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, bottom: 21.v),
                validator: (value) => Validator.validateEmptyText('Région', value)
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields,),
          CustomTextFormField(
              controller: controller.addressController,
              hintText: "${'lbl_address'.tr} *",
              textInputType: TextInputType.text,
              prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.building_31)
              ),
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, bottom: 21.v),
              validator: (value) => Validator.validateEmptyText('lbl_address'.tr, value)
          ),
        ]
    );
  }
  /// Section Password
  Widget _buildPasswordForm() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: TSizes.spaceBtwItems),
          Align(
              alignment: Alignment.topLeft,
              child: TitleWidget(title: "msg_create_password".tr)
          ),
          Align(
              alignment: Alignment.topLeft,
              child: SubTitleWidget(subtitle: "msg_securise_account_password".tr)
          ),
          SizedBox(height: TSizes.spaceBtwSections * 2),
          Obx(() => CustomTextFormField(
              controller: controller.passwordController,
              hintText: "${'lbl_password'.tr} *",
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.visiblePassword,
              prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: CustomImageView(imagePath: ImageConstant.imgLock, height: 20.adaptSize, width: 20.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              suffix: InkWell(onTap: () {controller.isShowPassword.value = !controller.isShowPassword.value;},
                  child: Container(margin: EdgeInsets.fromLTRB(30.hw, 20.v, 20.hw, 20.v),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgEye,
                          height: 20.adaptSize,
                          width: 20.adaptSize)
                  )),
              suffixConstraints: BoxConstraints(maxHeight: 60.v),
              validator: (value) => Validator.validatePassword(value),
              obscureText: controller.isShowPassword.value,
              contentPadding: EdgeInsets.symmetric(vertical: 21.v))),
          const SizedBox(height: TSizes.spaceBtwSections,),
          Obx(() =>
              CustomTextFormField(
                  controller: controller.confirmPasswordController,
                  hintText: "${'lbl_confirm_password'.tr} *",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                      child: CustomImageView(imagePath: ImageConstant.imgLock, height: 20.adaptSize, width: 20.adaptSize)),
                  prefixConstraints: BoxConstraints(maxHeight: 60.v),
                  suffix: InkWell(onTap: () {controller.isShowPassword.value = !controller.isShowPassword.value;},
                      child: Container(margin: EdgeInsets.fromLTRB(30.hw, 20.v, 20.hw, 20.v),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgEye,
                              height: 20.adaptSize,
                              width: 20.adaptSize)
                      )),
                  suffixConstraints: BoxConstraints(maxHeight: 60.v),
                  validator: (value) => Validator.validatePassword(value),
                  obscureText: controller.isShowPassword.value,
                  contentPadding: EdgeInsets.symmetric(vertical: 21.v)
              )
          ),

          SizedBox(height: TSizes.xl),
          Text(
            "\u2713 ${'lbl_caractere_special'.tr}(#?*+/!)",
            style: theme.textTheme.displaySmall!.copyWith(
                color: PrefUtils().getThemeData()=='dark' ? appTheme.whiteA700 : Colors.black,
                fontSize: 18.adaptSize
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: TSizes.sm),
          Text(
            "\u2713 ${'lbl_lettre_majuscule'.tr}",
            style: theme.textTheme.displaySmall!.copyWith(
                color: PrefUtils().getThemeData()=='dark' ? appTheme.whiteA700 : Colors.black,
                fontSize: 18.adaptSize
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: TSizes.sm),
          Text(
            "\u2713 ${'lbl_chiffre'.tr}",
            style: theme.textTheme.displaySmall!.copyWith(
                color: PrefUtils().getThemeData()=='dark' ? appTheme.whiteA700 : Colors.black,
                fontSize: 18.adaptSize
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: TSizes.sm),
          Text(
            "\u2713 ${'lbl_8_caracteres_minimum'.tr}",
            style: theme.textTheme.displaySmall!.copyWith(
                color: PrefUtils().getThemeData()=='dark' ? appTheme.whiteA700 : Colors.black,
                fontSize: 18.adaptSize
            ),
            textAlign: TextAlign.justify,
          ),
        ]
    );
  }

  onTapNext() {
    if (controller.currentIndexStepper.value == ImagesDatingList.length - 1) {
      // If it's the last onboarding screen, navigate to the desired screen
      //Get.toNamed(Routes.signInScreen);
      controller.saveBtn();
      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupSuccessScreen()));
    } else {
      // Otherwise, go to the next onboarding screen
      controller.currentIndexStepper.value += 1;
      _pageSignupStepperController.animateToPage(
        controller.currentIndexStepper.value,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

}