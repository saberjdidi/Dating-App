import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/controller/create_account_controller.dart';
import 'package:dating_app_bilhalal/widgets/account/choice-chip.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/account/profile_image_stack.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down_country.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/shader_mask_widget.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class OverviewAccountScreen extends GetWidget<CreateAccountController> {
  OverviewAccountScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeyOverviewAccount = GlobalKey<
      ScaffoldState>();
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
          key: controller.formOverviewAccountKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Scaffold(
            //backgroundColor: _appTheme == 'light' ? TColors.white : appTheme.primaryColor,
            appBar: TAppBar(
              title: TitleWidget(
                title: "نبذة عني",
                fontWeightDelta: 3,
                color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white,
              ),
             /* title: Text('ملخص',
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(
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
                child: Obx(() =>
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ProfileImageStack(
                              defaultImage: ImageConstant.userProfile,
                              uploadIcon: ImageConstant.uplodUserProfile,
                              controller: controller,
                              size: 120.adaptSize,
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                          CustomTextFormField(
                            controller: controller.fullNameController,
                            //onChange: controller.onFullNameChanged,
                            hintText: "${'الاسم الكامل'.tr} *",
                            onChange: (value){
                              controller.onFullNameChanged(value);
                              controller.isRTL.value = TDeviceUtils.isArabic(value);
                            },
                            focusNode: controller.fullNameFocus,
                            onTap: () => FocusScope.of(context).requestFocus(controller.fullNameFocus),
                            onEditingComplete: () => FocusScope.of(context).requestFocus(controller.bioFocus),
                            textInputType: TextInputType.text,
                            prefixConstraints: BoxConstraints(maxHeight: 60.v),
                            contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الاسم الكامل إجباري";
                              }
                              if (value.length > 100) {
                                return "الاسم الكامل لا يمكن أن يتجاوز 100 حرف.";
                              }
                              return null;
                            },
                            fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                            hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                            textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            //validator: (value) => Validator.validateEmptyText('${'lbl_lastName'.tr}', value),
                          ),
                          /// --- Compteur sous le champ
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              controller.fullNameError.value.isNotEmpty
                                  ? controller.fullNameError.value
                                  : "${"الحروف المتبقية"} ${controller.fullNameRemaining.value}",
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
                            hintText: "${'بایو'.tr} *",
                            onChange: (value){
                              controller.onBioChanged(value);
                              controller.isRTL.value = TDeviceUtils.isArabic(value);
                            },
                            focusNode: controller.bioFocus,
                            onTap: () => FocusScope.of(context).requestFocus(controller.bioFocus),
                            onEditingComplete: () => FocusScope.of(context).requestFocus(controller.jobFocus),
                            maxLines: 2,
                            textInputType: TextInputType.text,
                            prefixConstraints: BoxConstraints(maxHeight: 60.v),
                            contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                            validator: (value) => (value == null || value.isEmpty) ? "البایو إجباري" : null,
                            fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                            hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                            textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            //validator: (value) => Validator.validateEmptyText('${'lbl_firstName'.tr}', value),
                          ),
                          /// --- Compteur sous le champ
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              controller.bioError.value.isNotEmpty
                                  ? controller.bioError.value
                                  : "${"الحروف المتبقية"} ${controller.bioRemaining.value}",
                              style: TextStyle(
                                fontSize: 15.adaptSize,
                                color: controller.bioError.value.isNotEmpty
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ),

                          SizedBox(height: TSizes.spaceBtwItems.v),
                          FormDividerWidget(dividerText: "العمر", thikness: 1),
                          SizedBox(height: 10.v),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ✅ Afficher l’âge sous le slider
                              Text("${controller.currentAgeValue.value.round()} سنة",
                                style: TextStyle(fontSize: 17.adaptSize, fontWeight: FontWeight.w500,
                                    color: _appTheme =='light' ? TColors.black : TColors.lightGrey),
                              ),
                              // Slider avec gradient, label toujours visible, hauteur augmentée
                              ShaderMaskWidget(
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
                          SizedBox(height: 10.v),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ✅ Afficher l’âge sous le slider
                              Text("${controller.currentWeightValue.value.round()} كغ",
                                style: TextStyle(fontSize: 17.adaptSize, fontWeight: FontWeight.w500,
                                    color: _appTheme =='light' ? TColors.black : TColors.lightGrey),
                              ),
                              // Slider avec gradient, label toujours visible, hauteur augmentée
                              ShaderMaskWidget(
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
                          SizedBox(height: 10.v),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ✅ Afficher l’âge sous le slider
                              Text("${controller.currentHeightValue.value.round()} سم",
                                style: TextStyle(fontSize: 17.adaptSize, fontWeight: FontWeight.w500,
                                    color: _appTheme =='light' ? TColors.black : TColors.lightGrey),
                              ),
                              // Slider avec gradient, label toujours visible, hauteur augmentée
                              ShaderMaskWidget(
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
                          SizedBox(height: TSizes.spaceBtwItems.v),

                          SizedBox(height: TSizes.spaceBtwItems.v),
                          FormDividerWidget(dividerText: "الجنس", thikness: 1),
                          SizedBox(height: 10.v),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.hw),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TRoundedContainer(
                                  showBorder: true,
                                  borderColor: TColors.greyDating,
                                    backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
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
                                            return TColors.primaryColorApp; // ✅ Cercle actif jaune
                                          }
                                          return Colors.grey; // Cercle inactif gris
                                        }),
                                      ),
                                      //TitleWidget(title: 'امراة',),
                                      SubTitleWidget(subtitle: 'امراة', color: _appTheme =='light' ? TColors.black : TColors.white, fontSizeDelta: 2, fontWeightDelta: 1),
                                    ],
                                  )
                                ),

                                TRoundedContainer(
                                  showBorder: true,
                                  borderColor: TColors.greyDating,
                                    backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
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
                                            return TColors.primaryColorApp;
                                          }
                                          return Colors.grey;
                                        }),
                                      ),
                                      SubTitleWidget(subtitle: 'رجل', color: _appTheme =='light' ? TColors.black : TColors.white, fontSizeDelta: 2, fontWeightDelta: 1),
                                      //TitleWidget(title: 'رجل',),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems.v),

                          CustomDropDown(
                            //textStyle: TextStyle(color: appTheme.black),
                            hintText: "${'الحالة الاجتماعية'.tr} *",
                            items: ListMaritalStatus.value,
                            selectedValue: controller.selectedMaritalStatus.value,
                            onChanged: (val) => controller.selectedMaritalStatus.value = val,
                           /* onChanged: (value) async {
                              controller.maritalStatusController.text = value.title;
                              debugPrint('marital status : ${controller.maritalStatusController.text}');
                            }, */
                            validator: (value) {
                              if (value == null) {
                                return "الحالة الاجتماعية إجباري";
                              }
                              return null;
                            },
                            focusNode: controller.maritalStatusFocus,
                            icon: Icon(Iconsax.arrow_down_1),
                            borderRadius: 15.hw,
                            contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                            fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                            hintStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            textStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            themeColor:_appTheme =='light' ?  appTheme.gray50 : TColors.darkerGrey,
                          ),
                          SizedBox(height: TSizes.spaceBtwItems.v),

                          CustomDropDown(
                            //textStyle: TextStyle(color: appTheme.black),
                            hintText: "${'نوع الزواج'.tr} *",
                            items: ListLookingFor.value,
                            selectedValue: controller.selectedLookingFor.value,
                            onChanged: (val) => controller.selectedLookingFor.value = val,
                           /* onChanged: (value) async {
                              controller.lookingForController.text = value.title;
                              debugPrint('looking for : ${controller.lookingForController.text}');
                            }, */
                            validator: (value) {
                              if (value == null) {
                                return "نوع الزواج إجباري";
                              }
                              return null;
                            },
                            focusNode: controller.lookingForFocus,
                            icon: Icon(Iconsax.arrow_down_1),
                            borderRadius: 15.hw,
                            contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                            fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                            hintStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            textStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            themeColor:_appTheme =='light' ?  appTheme.gray50 : TColors.darkerGrey,
                          ),
                          SizedBox(height: TSizes.spaceBtwItems.v),

                          CustomTextFormField(
                            controller: controller.jobController,
                            hintText: "${'الوظيفة'.tr} *",
                            onChange: (value){
                              controller.onJobChanged(value);
                              controller.isRTL.value = TDeviceUtils.isArabic(value);
                            },
                            focusNode: controller.jobFocus,
                            onTap: () => FocusScope.of(context).requestFocus(controller.jobFocus),
                            onEditingComplete: () => FocusScope.of(context).requestFocus(controller.jobFocus),
                            maxLines: 3,
                            textInputType: TextInputType.text,
                            prefixConstraints: BoxConstraints(maxHeight: 60.v),
                            contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                            validator: (value) => Validator.validateEmptyText('${'الوظيفة'.tr}', value),
                            fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                            hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                            textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              controller.jobError.value.isNotEmpty
                                  ? controller.jobError.value
                                  : "${"الحروف المتبقية"} ${controller.jobRemaining.value}",
                              style: TextStyle(
                                fontSize: 15.adaptSize,
                                color: controller.jobError.value.isNotEmpty
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems.v),

                          CustomDropDownCountry(
                            hintText: "${'الدولة'.tr} *",
                            items: PaysList.value,
                            selectedValue: controller.selectedPays.value,
                            onChanged: (val) => controller.selectedPays.value = val,
                            /* onChanged: (value) async {
                              controller.paysController.text = value.title;
                              debugPrint('pays : ${controller.paysController.text}');
                            }, */
                            validator: (value) {
                              if (value == null) {
                                return "الدولة إجباري";
                              }
                              return null;
                            },
                            focusNode: controller.paysFocus,
                            icon: Icon(Iconsax.arrow_down_1),
                            borderRadius: 15.hw,
                            contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                            fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                            hintStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            textStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                            themeColor:_appTheme =='light' ?  appTheme.gray50 : TColors.darkerGrey,
                          ),
                         /* CustomDropDown(
                            fillColor: TColors.white,
                            hintStyle: CustomTextStyles.bodyMediumTextFormField,
                            hintText: "${'دولة'.tr} *",
                            items: ListPays.value,
                            selectedValue: controller.selectedPays.value,
                            onChanged: (val) => controller.selectedPays.value = val,
                            validator: (value) {
                              if (value == null) {
                                return "الدولة مطلوبة";
                              }
                              return null;
                            },
                            themeColor: appTheme.gray50,
                            focusNode: controller.paysFocus,
                            icon: Icon(Iconsax.arrow_down_1),
                            borderRadius: 15.hw,
                            contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                          ), */

                          SizedBox(height: TSizes.spaceBtwItems.v),
                          FormDividerWidget(dividerText: "لون البشرة", thikness: 1),
                          SizedBox(height: 10.v),

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
                          SizedBox(height: 10.v),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ✅ Afficher les valeurs sous le slider
                              Text(
                                "${controller.currentRangeValues.value.start.round()}K - ${controller.currentRangeValues.value.end.round()}K",
                                style: TextStyle(fontSize: 17.adaptSize, fontWeight: FontWeight.w500,
                                    color: _appTheme =='light' ? TColors.black : TColors.lightGrey),
                              ),

                              // ✅ Slider avec gradient et labels toujours visibles
                              ShaderMaskWidget(
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
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems.v),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubTitleWidget(subtitle: "الاهتمامات", color: _appTheme =='light' ? TColors.gray700 : TColors.white,),
                                CustomImageView(
                                  imagePath: ImageConstant.uploadImageRounded,
                                  color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                                  //height: 50.adaptSize,
                                  //width: 50.adaptSize,
                                  fit: BoxFit.fill,
                                  onTap: () async {
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.v),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: interestsList.map((interest) {
                              final isSelected = controller.selectedInterests.contains(interest.name);
                              final randomColor =
                              controller.selectedInterestColors[interest.name]; // ✅ couleur mémorisée
                              return InterestWidget(
                                text: interest.name,
                                iconPath: interest.icon,
                                isSelected: isSelected,
                                activeColor: true,
                                onTap: () => controller.toggleInterest(interest.name, context),
                                verticalPadding: 13.v,
                                showRandomColor: isSelected, // ✅ afficher la couleur seulement si sélectionné
                                randomList: randomColor != null ? [randomColor] : controller.randomColorList,
                              );
                            }).toList(),
                          ),
                          /* Wrap(
                              spacing: 8, // Espace horizontal entre les items
                              runSpacing: 8, // Espace vertical entre les lignes
                              alignment: WrapAlignment.start,
                              children: interestsList.map((interest) {
                                final isSelected = controller.selectedInterests.contains(interest.name);
                                return InterestWidget(
                                  text: interest.name,
                                  iconPath: interest.icon,
                                  isSelected: isSelected,
                                  onTap: () => controller.toggleInterest(interest.name, context),
                                  verticalPadding: 20.v,
                                );
                              }).toList()
                          ),
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
                                    verticalPadding: 20.v,
                                  ),
                                );
                              }).toList()
                          ), */

                          SizedBox(height: TSizes.spaceBtwItems.v),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems.v),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubTitleWidget(subtitle: "معرض", color: _appTheme =='light' ? TColors.gray700 : TColors.white),
                                CustomImageView(
                                  imagePath: ImageConstant.uploadImageRounded,
                                  color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                                  //height: 50.adaptSize,
                                  //width: 50.adaptSize,
                                  fit: BoxFit.fill,
                                  onTap: () async {
                                    await controller.pickMedia();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.v),
                          GridLayout(
                            itemCount: controller.selectedMedia.length, // +1 pour l'upload
                            mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
                            crossAxisCount: 3,
                            itemBuilder: (context, index) {
                              final file = controller.selectedMedia[index]; // -1 car le 1er est upload
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
                                          controller.removeMedia(index);
                                        },
                                      ),
                                    /*  child: CircularContainer(
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
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: TSizes.spaceBtwItems.v,
                  left: TSizes.defaultSpace.hw,
                  right: TSizes.defaultSpace.hw),
              //child: _buildButtonSection()
              child:
              CustomButtonContainer(
                text:"تأكيد".tr,
                color1: TColors.primaryColorApp,
                color2: TColors.primaryColorApp,
                borderRadius: 10,
                colorText: TColors.white,
                fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                height: isSmallPhone ? 80.v : 70.v,
                width: screenWidth * 0.7,
                onPressed: () async {
                  controller.saveBtn();
                },
              ),
            ),
          ),
        )
    );
  }
}