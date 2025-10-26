import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/controller/create_account_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/edit_profile_controller.dart';
import 'package:dating_app_bilhalal/widgets/account/choice-chip.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/account/profile_image_stack.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down_country.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down_string.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/hobbies_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/shader_mask_widget.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/swip_back_wrapper.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends GetWidget<EditProfileController> {
  EditProfileScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeyEditProfile = GlobalKey<
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
          key: controller.formEditProfileKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SwipeBackWrapper(
            child: Scaffold(
              key: _scaffoldKeyEditProfile,
              //backgroundColor: _appTheme == 'light' ? TColors.white : appTheme.primaryColor,
              appBar: TAppBar(
                title: TitleWidget(
                  title: "ملفي",
                  fontWeightDelta: 3,
                  color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white,
                ),
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
                          /*  Center(
                              child: ProfileImageStack(
                                defaultImage: ImageConstant.userProfile,
                                uploadIcon: ImageConstant.uplodUserProfile,
                                controller: controller,
                                size: 120.adaptSize,
                              ),
                            ), */
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
                                      min: 18,
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
                                      min: 40,
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
                                        debugPrint('Height value : ${controller.currentHeightValue.value.round()}');
                                      },
                                      activeColor: Colors.white, // ✅ Couleur appliquée par gradient
                                      inactiveColor: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: TSizes.spaceBtwItems.v),

                            CustomDropDownString(
                              hintText: 'marital_status'.tr,
                              items: ListMaritalStatuss,
                              selectedValue:controller.maritalStatusController.text,
                              onChanged: (value) async {
                                controller.maritalStatusController.text = value;
                                debugPrint('marital status : ${controller.maritalStatusController.text}');
                              },
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

                            CustomDropDownString(
                              hintText: 'type_marriage'.tr,
                              items: ListMarriageType,
                              selectedValue: controller.lookingForController.text,
                              onChanged: (value) async {
                                controller.lookingForController.text = value;
                                debugPrint('marriage type : ${controller.lookingForController.text}');
                              },
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

                           /* SizedBox(height: TSizes.spaceBtwItems.v),
                            CustomDropDownCountry(
                              hintText: 'state'.tr,
                              items: PaysList.value,
                              selectedValue: controller.selectedPays.value,
                              //onChanged: (val) => controller.selectedPays.value = val,
                               onChanged: (value) async {
                                 controller.selectedPays.value = value;
                                controller.paysController.text = value.name;
                                debugPrint('pays : ${controller.paysController.text}');
                              },
                              enabled: true,
                              focusNode: controller.paysFocus,
                              icon: Icon(Iconsax.arrow_down_1),
                              borderRadius: 15.hw,
                              contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                              fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                              hintStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                              textStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                              themeColor:_appTheme =='light' ?  appTheme.gray50 : TColors.darkerGrey,
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
                                        debugPrint("range salaire : ${controller.currentRangeValues.value.start.round()} - ${controller.currentRangeValues.value.end.round()}");
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
                            HobbiesWidget(),

                            SizedBox(height: TSizes.spaceBtwItems.v),
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
                child: Obx(() => CustomButtonContainer(
                  text:"حفظ".tr,
                  color1: TColors.primaryColorApp,
                  color2: TColors.primaryColorApp,
                  borderRadius: 10,
                  colorText: TColors.white,
                  fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                  height: isSmallPhone ? 80.v : 70.v,
                  width: screenWidth * 0.7,
                  onPressed:controller.isDataProcessing.value
                      ? null // désactive le clic pendant chargement
                      :  () async {
                    controller.saveBtn();
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
                ),
                )

              ),
            ),
          ),
        )
    );
  }
}