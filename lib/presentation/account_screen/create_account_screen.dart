import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/datasources/onboarding_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/controller/create_account_controller.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/account/choice-chip.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/line_stepper_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
//import 'package:im_stepper/stepper.dart';

class CreateAccountScreen extends GetWidget<CreateAccountController> {
  CreateAccountScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeyCreateAccount = GlobalKey<ScaffoldState>();
  final PageController _pageSignupStepperController = PageController();
  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      child: Form(
        key: controller.formCreateAccountKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Scaffold(
          key: _scaffoldKeyCreateAccount,
          //backgroundColor: _appTheme =='light' ? TColors.white : appTheme.primaryColor,
          appBar: TAppBar(
            //showBackArrow: true,
            //rightToLeft: true,
            leadingWidth: screenWidth * 0.3,
            title: TitleWidget(
              title: "إنشاء حساب",
              fontWeightDelta: 3,
              color: _appTheme =='light' ?  TColors.buttonSecondary : TColors.white,
            ),
           /* title: Text('إنشاء حساب',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: TColors.black,
                fontSize: 22.fSize,
                fontWeight: FontWeight.bold,
                //decoration: TextDecoration.underline,
                decorationColor: TColors.black,
              ),
            ), */
          ),
          body: Padding(
            padding: const EdgeInsets.all(TSizes.spaceBtwItems),
            child: SingleChildScrollView(
              child: Obx(() => Column(
                children: [
                  LineStepperWidget(
                    stepCount: controller.dotCount.value,
                    activeStep: controller.activeStep.value,
                    activeColor: TColors.black,
                    inactiveColor: TColors.greyDating,
                    onStepTapped: (index) {
                      // index est dans le sens logique (0 = première étape, affichée à droite)
                      controller.activeStep.value = index;
                    },
                    lineHeight: 5.adaptSize,
                  ),
                 /* LineWithDotStepperWidget(
                    stepCount: controller.dotCount.value,
                    activeStep: controller.activeStep.value,
                    dotRadius: 8,
                    spacing: 0,
                    connectorWidth: 60,
                    activeColor: TColors.black,
                    inactiveColor: TColors.greyDating,
                    onStepTapped: (index) {
                      // index est dans le sens logique (0 = première étape, affichée à droite)
                      controller.activeStep.value = index;
                    },
                  ), */
                  /*
                  //import 'package:im_stepper/stepper.dart';
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
                  ), */

                  controller.activeStep.value == 0
                      ? _buildBasicDetailsForm(context)
                      : controller.activeStep.value == 1
                      ? _buildAdditionalDetailsForm(context)
                      : controller.activeStep.value == 2
                      ? _buildInterestForm(context, isTablet)
                      : _buildMediaForm(context, isTablet),

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
              )),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: TSizes.spaceBtwItems.v, left: TSizes.defaultSpace.hw, right: TSizes.defaultSpace.hw),
            //child: _buildButtonSection()
            child:
            CustomButtonContainer(
              text: "التالي".tr,
              //text: controller.activeStep.value == 4 ?  "ملخص".tr : "التالي".tr,
              color1: TColors.yellowAppDark,
              color2: TColors.yellowAppLight,
              borderRadius: 10,
              colorText: TColors.white,
              fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
              height: isSmallPhone ? 80.v : 70.v,
              width: screenWidth * 0.8,
              onPressed: () async {
                if (controller.activeStep.value < controller.dotCount.value - 1) {
                  controller.activeStep.value++;
                } else {
                  //controller.saveBtn();
                  Get.toNamed(Routes.overviewAccountScreen);
                }
                //dialogVerifyAccount(context);
              },
            ),
          ),
        ),
      )
    );

  }

  /// Section Identity
  Widget _buildBasicDetailsForm(BuildContext context) {
    //double sliderValue = controller.currentAgeValue.value.toDouble();
    //double weightValue = controller.currentWeightValue.value.toDouble();
    //double heightValue = controller.currentHeightValue.value.toDouble();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: TSizes.spaceBtwItems),
            Align(
                alignment: Alignment.topRight,
                child: TitleWidget(title: "التفاصيل الأساسية".tr,
                color: _appTheme =='light' ? TColors.black : TColors.white,)
            ),
            Align(
                alignment: Alignment.topRight,
                child: SubTitleWidget(subtitle: "ومعلوماتك الأساسية.".tr,
                    color:  _appTheme =='light' ? TColors.gray700 : TColors.white)
            ),
            SizedBox(height: TSizes.spaceBtwSections.v),
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
              onChange: controller.onFullNameChanged,
              hintText: "${'الاسم الكامل'.tr} *",
              textInputType: TextInputType.text,
              /* prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.user_octagon)
              ), */
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
              //validator: (value) => Validator.validateEmptyText('${'lbl_lastName'.tr}', value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "الاسم الكامل مطلوب";
                }
                if (value.length > 100) {
                  return "الاسم الكامل لا يمكن أن يتجاوز 100 حرف.";
                }
                return null;
              },
            ),
          /// --- Compteur sous le champ
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                controller.fullNameError.value.isNotEmpty
                    ? controller.fullNameError.value
                    : "${controller.fullNameRemaining.value} حروف متبقية",
                style: TextStyle(
                  fontSize: 15.adaptSize,
                  color: controller.fullNameError.value.isNotEmpty
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems.v),
            CustomTextFormField(
              controller: controller.bioController,
              onChange: controller.onBioChanged,
              hintText: "${'بایو'.tr} *",
              maxLines: 2,
              textInputType: TextInputType.text,
              /* prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.user)
              ), */
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
              //validator: (value) => Validator.validateEmptyText('${'lbl_firstName'.tr}', value),
              validator: (value) => value == null || value.isEmpty ? "البایو مطلوب" : null,
            ),
            /// --- Compteur sous le champ
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                controller.bioError.value.isNotEmpty
                    ? controller.bioError.value
                    : "${controller.bioRemaining.value} حروف متبقية",
                style: TextStyle(
                  fontSize: 15.adaptSize,
                  color: controller.bioError.value.isNotEmpty
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "الجنس", thikness: 1),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.hw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TRoundedContainer(
                      showBorder: true,
                      borderColor: TColors.greyDating,
                      padding: EdgeInsets.symmetric(horizontal: 35.v, vertical: 13.v),
                      child: Row(
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
                          SubTitleWidget(subtitle: 'امراة', color: TColors.black, fontSizeDelta: 2, fontWeightDelta: 2),
                          //TitleWidget(title: 'امراة',),
                        ],
                      )
                  ),

                  TRoundedContainer(
                      showBorder: true,
                      borderColor: TColors.greyDating,
                      padding: EdgeInsets.symmetric(horizontal: 35.v, vertical: 13.v),
                      child: Row(
                        children: [
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
                          SubTitleWidget(subtitle: 'رجل', color: TColors.black, fontSizeDelta: 2, fontWeightDelta: 2),
                          //TitleWidget(title: 'رجل',),
                        ],
                      )
                  ),
                ],
              ),
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "عمر", thikness: 1),
            SizedBox(height: TSizes.spaceBtwItems.v),
            /*
            Obx(() => Slider(
              //year2023: year2023,
              value: double.parse(controller.currentAgeValue.value.toString()),
              max: 100,
              divisions: 100,
              label: controller.currentAgeValue.round().toString(),
              onChanged: (double value) {
                controller.currentAgeValue.value = value.toInt();

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
                Text("${controller.currentAgeValue.value.round()}",
                  style: TextStyle(fontSize: 17.adaptSize, fontWeight: FontWeight.bold,
                  color: _appTheme =='light' ? TColors.black : TColors.lightGrey),
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
                      value: controller.currentAgeValue.value,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: controller.currentAgeValue.value.round().toString(),
                      onChanged: (value) {
                        controller.currentAgeValue.value = value;
                      },
                      activeColor: Colors.white, // ✅ Couleur appliquée par gradient
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "الوزن", thikness: 1),
            SizedBox(height: TSizes.spaceBtwItems.v),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Afficher l’âge sous le slider
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text("${controller.currentWeightValue.value.round()} KG",
                    style: TextStyle(fontSize: 17.adaptSize, fontWeight: FontWeight.bold,
                        color: _appTheme =='light' ? TColors.black : TColors.lightGrey),
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
                      value: controller.currentWeightValue.value,
                      min: 0,
                      max: 140,
                      divisions: 140,
                      label: controller.currentWeightValue.value.round().toString(),
                      onChanged: (value) {
                        controller.currentWeightValue.value = value;
                      },
                      activeColor: Colors.white, // ✅ Couleur appliquée par gradient
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "الطول", thikness: 1),
            SizedBox(height: TSizes.spaceBtwItems.v),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Afficher l’âge sous le slider
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text("${controller.currentHeightValue.value.round()} CM",
                    style: TextStyle(fontSize: 17.adaptSize, fontWeight: FontWeight.bold,
                        color: _appTheme =='light' ? TColors.black : TColors.lightGrey),
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
                      value: controller.currentHeightValue.value,
                      min: 100,
                      max: 220,
                      divisions: 220,
                      label: controller.currentHeightValue.value.round().toString(),
                      onChanged: (value) {
                        controller.currentHeightValue.value = value;
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

  /// additional details
  Widget _buildAdditionalDetailsForm(BuildContext context) {


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: TSizes.spaceBtwItems),
            Align(
                alignment: Alignment.topRight,
                child: TitleWidget(title: "تفاصيل إضافية".tr,
                  color:  _appTheme =='light' ? TColors.black : TColors.white,)
            ),
            Align(
                alignment: Alignment.topRight,
                child: SubTitleWidget(subtitle: "والمزيد من التفاصيل لأفضل المباريات.".tr,
                  color:  _appTheme =='light' ? TColors.gray700 : TColors.white,)
            ),
            SizedBox(height: TSizes.spaceBtwSections.v),
            CustomDropDown(
              fillColor: TColors.white, //appTheme.gray50
              //textStyle: TextStyle(color: appTheme.black),
              hintStyle: CustomTextStyles.bodyMediumTextFormField,
              //prefix: Icon(Iconsax.activity, color: appTheme.black, size: 27.adaptSize),
              hintText: "${'الحالة الاجتماعية'.tr} *",
              items: ListMaritalStatus.value,
              onChanged: (value) async {
                controller.maritalStatusController.text = value.title;
                //controller.typePieceIdentityController.text = value.title;
                debugPrint('marital status : ${controller.maritalStatusController.text}');
              },
              validator: (value) {
                if (value == null) {
                  return "${'lbl_region'.tr} ${"lbl_is_required".tr}";
                }
                return null;
              },
              themeColor: appTheme.gray50,
              borderRadius: 15.hw,
              icon: Icon(Iconsax.arrow_down_1),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
            ),
            SizedBox(height: TSizes.spaceBtwItems.v),

            CustomDropDown(
              fillColor: TColors.white, //appTheme.gray50
              //textStyle: TextStyle(color: appTheme.black),
              hintStyle: CustomTextStyles.bodyMediumTextFormField,
              //prefix: Icon(Iconsax.activity, color: appTheme.black, size: 27.adaptSize),
              hintText: "${'نوع الزواج'.tr} *",
              items: ListLookingFor.value,
              onChanged: (value) async {
                controller.lookingForController.text = value.title;
                //controller.typePieceIdentityController.text = value.title;
                debugPrint('looking for : ${controller.lookingForController.text}');
              },
              validator: (value) {
                if (value == null) {
                  return "${'lbl_region'.tr} ${"lbl_is_required".tr}";
                }
                return null;
              },
              themeColor: appTheme.gray50,
              icon: Icon(Iconsax.arrow_down_1),
              borderRadius: 15.hw,
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
            ),
            SizedBox(height: TSizes.spaceBtwItems.v),

            CustomTextFormField(
              controller: controller.jobController,
              onChange: controller.onJobChanged,
              hintText: "${'الوظيفة'.tr} *",
              maxLines: 2,
              textInputType: TextInputType.text,
              /* prefix: Container(margin: EdgeInsets.fromLTRB(20.hw, 20.v, 12.hw, 20.v),
                  child: Icon(Iconsax.user)
              ), */
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
              validator: (value) => Validator.validateEmptyText('${'Job'.tr}', value),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                controller.jobError.value.isNotEmpty
                    ? controller.jobError.value
                    : "${controller.jobRemaining.value} حروف متبقية",
                style: TextStyle(
                  fontSize: 15.adaptSize,
                  color: controller.jobError.value.isNotEmpty
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems.v),

            CustomDropDown(
              fillColor: TColors.white,
              hintStyle: CustomTextStyles.bodyMediumTextFormField,
              hintText: "${'دولة'.tr} *",
              items: ListPays.value,
              onChanged: (value) async {
                controller.paysController.text = value.title;
                debugPrint('pays : ${controller.paysController.text}');
              },
              validator: (value) {
                if (value == null) {
                  return "الدولة مطلوبة";
                }
                return null;
              },
              themeColor: appTheme.gray50,
              icon: Icon(Iconsax.arrow_down_1),
              borderRadius: 15.hw,
              contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "لون البشرة", thikness: 1),
            SizedBox(height: TSizes.spaceBtwItems.v),

            Wrap(
                spacing: 5,
                children: ColorsSkinList.map((color) {
                  final isSelected = controller.selectedColor.value == color;
                  return TChoiceChip(
                      text: color,
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) controller.selectColor(color);
                      }
                  );
                }).toList()
            ),

            SizedBox(height: TSizes.spaceBtwItems.v),
            FormDividerWidget(dividerText: "نطاق الراتب", thikness: 1),
            SizedBox(height: TSizes.spaceBtwItems.v),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Afficher les valeurs sous le slider
                Text(
                  "${controller.currentRangeValues.value.start.round()}K - ${controller.currentRangeValues.value.end.round()}K",
                  style: TextStyle(fontSize: 17.adaptSize, fontWeight: FontWeight.bold,
                      color: _appTheme =='light' ? TColors.black : TColors.lightGrey),
                ),

                // ✅ Slider avec gradient et labels toujours visibles
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [TColors.yellowAppLight, Colors.redAccent], // Dégradé
                    ).createShader(bounds);
                  },
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8, // Hauteur du slider
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                      rangeThumbShape: const RoundRangeSliderThumbShape(), // ✅ Pour 2 thumbs
                      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      showValueIndicator: ShowValueIndicator.always,
                    ),
                    child: RangeSlider(
                      values: controller.currentRangeValues.value,
                      min: 1,
                      max: 1000,
                      divisions: 140,
                      labels: RangeLabels(
                        controller.currentRangeValues.value.start.round().toString(),
                        controller.currentRangeValues.value.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        controller.currentRangeValues.value = values;
                        debugPrint("range salaire : ${controller.currentRangeValues.value}");
                      },
                      activeColor: Colors.white, // ✅ Gradient appliqué via ShaderMask
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            )

          ]
      )),
    );
  }

  /// interest
  Widget _buildInterestForm(BuildContext context, bool isTablet) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: TSizes.spaceBtwItems.v),
            Align(
                alignment: Alignment.topRight,
                child: TitleWidget(title: "أضف ميزة".tr,
                  color:  _appTheme =='light' ? TColors.black : TColors.white,
                  textAlign: TextAlign.end,)
            ),
            Align(
                alignment: Alignment.topRight,
                child: SubTitleWidget(subtitle: "أضف 5 اهتمامات للعثور على شريك يتوافق مع شغفك.".tr,
                  color:  _appTheme =='light' ? TColors.gray700 : TColors.white,
                  textAlign: TextAlign.end,)
            ),

            SizedBox(height: TSizes.spaceBtwSections.v),

            ///Method using GridView
            GridView.count(
              crossAxisCount: isTablet ? 3 : 2, // ✅ Deux colonnes fixes
              mainAxisSpacing: 2,
              crossAxisSpacing: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Empêche le scroll dans un Column
                childAspectRatio: 2, // ✅ contrôle la largeur/hauteur
              children: interestsList.map((interest) {
                final isSelected = controller.selectedInterests.contains(interest.name);
                return Align(
                  alignment: Alignment.center, // ✅ Empêche de remplir toute la colonne
                  child: InterestWidget(
                    text: interest.name,
                    iconPath: interest.icon,
                    isSelected: isSelected,
                    onTap: () => controller.toggleInterest(interest.name, context),
                  ),
                );
              }).toList()
            ),
            ///Method using Wrap
          /*  Wrap(
              spacing: 5,
              runSpacing: 5,
              children: interestsList.map((interest) {
                final isSelected = controller.selectedInterests.contains(interest.name);
                return InterestWidget(
                  text: interest.name,
                  iconPath: interest.icon,
                  isSelected: isSelected,
                  onTap: () => controller.toggleInterest(interest.name, context),
                );
              }).toList(),
            ) */
          ]
      )),
    );
  }

  /// Section Media
  Widget _buildMediaForm(BuildContext context, bool isTablet) {
    return Obx(() => Column(
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: TSizes.spaceBtwItems.v),
          Align(
              alignment: Alignment.topRight,
              child: TitleWidget(title: "أضف صورة الملف الشخصي/الفيديو".tr,
                  color:  _appTheme =='light' ? TColors.black : TColors.white,
                textAlign: TextAlign.end,
              )
          ),
          Align(
              alignment: Alignment.topRight,
              child: SubTitleWidget(subtitle: "قم بتحميل صورتك الخاصة، وسيتم عرضها كصورة ملفك الشخصي.".tr,
                  color:  _appTheme =='light' ? TColors.gray700 : TColors.white,
                textAlign: TextAlign.end,)
          ),

          SizedBox(height: TSizes.spaceBtwSections.v),

          // Grid avec Upload Button + Images sélectionnées
          Directionality(
            textDirection: TextDirection.rtl,
            child: GridLayout(
              itemCount: controller.selectedMedia.length + 1, // +1 pour l'upload
              mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
              crossAxisCount: 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // L'icône upload
                  return TRoundedContainer(
                    showBorder: false,
                    backgroundColor: TColors.white,
                    borderColor: TColors.greyDating,
                    radius: 12,
                    padding: EdgeInsets.all(1),
                    child: CustomImageView(
                      imagePath: ImageConstant.uploadImage,
                      height: 100.adaptSize,
                      width: 100.adaptSize,
                      fit: BoxFit.fill,
                      onTap: () async {
                        await controller.pickMedia();
                      },
                    ),
                  );
                } else {
                  final file = controller.selectedMedia[index - 1]; // -1 car le 1er est upload
                  return TRoundedContainer(
                    showBorder: true,
                    backgroundColor: TColors.white,
                    borderColor: TColors.greyDating,
                    radius: 12,
                    padding: EdgeInsets.all(1),
                    child: Stack(
                      children: [
                        // Utiliser CustomImageView au lieu de Image.file
                        CustomImageView(
                          file: file,
                          imagePath: null,
                          //imagePath: file.path, // très important: .path car File
                          height: Get.height,
                          width: Get.width,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(10),
                        ),
                        Positioned(
                          right: 0,
                          child: CustomImageView(
                            imagePath: ImageConstant.removeImage,
                            width: 30.adaptSize,
                            height: 30.adaptSize,
                            radius: BorderRadius.circular(30.adaptSize),
                            fit: BoxFit.cover,
                            onTap: (){
                              controller.removeMedia(index - 1);
                            },
                          ),
                         /* child: CircularContainer(
                            width: 35.adaptSize,
                            height: 35.adaptSize,
                            radius: 35.adaptSize,
                            backgroundColor: TColors.lightGrey,
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.red, size: 15.adaptSize,),
                              onPressed: () => controller.removeMedia(index - 1),
                            ),
                          ), */
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        /*
          CustomImageView(
            imagePath: ImageConstant.uploadImage,
            height: 100.adaptSize,
            width: 100.adaptSize,
            fit: BoxFit.fill,
            onTap: () async {
             await controller.pickMedia();
            },
          ),
          GridLayout(
            itemCount: controller.selectedMedia.length,
            itemBuilder: (context, index) {
              final file = controller.selectedMedia[index];
              return TRoundedContainer(
                //height: isTablet ? 20.hw : 52.hw,
                //width: isTablet ? 20.hw : 52.hw,
                //margin: EdgeInsets.only(top: 5),
                showBorder: true,
                backgroundColor: TColors.white,
                borderColor: TColors.gray700,
                radius: 12,
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    CustomImageView(
                      imagePath: file.path,
                      height: 100.adaptSize,
                      width: 100.adaptSize,
                      fit: BoxFit.fill,
                      onTap: () async {
                        await controller.pickMedia();
                      },
                    ),
                    Image.file(file, fit: BoxFit.cover),
                    Positioned(
                      right: 0,
                      child:CircularContainer(
                        width: 50.adaptSize,
                        height: 50.adaptSize,
                        radius: 50.adaptSize,
                        backgroundColor: TColors.greyDating,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => controller.removeMedia(index),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
          */
        ]
    ));
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
