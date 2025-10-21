import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/controller/filter_controller.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:dating_app_bilhalal/widgets/account/choice-chip.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down_country.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down_string.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/home/pays_widget.dart';
import 'package:dating_app_bilhalal/widgets/multi_select_dopdown.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/shader_mask_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SearchDating {
  static Future<void> openDialogFilterUser(FilterController controller) async {
    var screenWidth = Get.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    var isArabe = PrefUtils.getLangue() == 'ar';
    var isLight = PrefUtils.getTheme() == "light";

    await Dialogs.customModalBottomSheet(
        Get.context!,
        0.9,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.fSize, vertical: TSizes.spaceBtwItems.fSize),
            child: Obx(() => Directionality(
              textDirection: TextDirection.rtl,
              child: ListBody(
                children: <Widget>[
                  /*SizedBox(height: TSizes.spaceBtwSections.adaptSize),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
                    child: TitleWidget(title: "فلتر".tr,
                        color: isLight ? TColors.black : TColors.white,
                        textAlign: TextAlign.right),
                  ), */
                  SizedBox(height: TSizes.spaceBtwItems.adaptSize),
                  FormDividerWidget(dividerText: "lbl_age".tr, thikness: 2),
                  SizedBox(height: TSizes.spaceBtwItems.v),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Afficher l’âge sous le slider
                      Text(
                        "${controller.currentRangeAgeValues.value.start.round()} ${'lbl_year'.tr} - ${controller.currentRangeAgeValues.value.end.round()} ${'lbl_year'.tr}",
                        //"${controller.currentAgeValue.value.round()}",
                        style: TextStyle(fontSize: 16.adaptSize, fontWeight: FontWeight.w500,
                            color: isLight ? TColors.black : TColors.lightGrey),
                      ),
                      // Slider avec gradient, label toujours visible, hauteur augmentée
                      ShaderMaskWidget(
                        child: SliderTheme(
                          data: SliderTheme.of(Get.context!).copyWith(
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
                          child: RangeSlider(
                            values: controller.currentRangeAgeValues.value,
                            min: 18,
                            max: 100,
                            divisions: 100,
                            labels: RangeLabels(
                              controller.currentRangeAgeValues.value.start.round().toString(),
                              controller.currentRangeAgeValues.value.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              controller.currentRangeAgeValues.value = values;
                              debugPrint("range ages : ${controller.currentRangeAgeValues.value}");
                            },
                            activeColor: Colors.white, // ✅ Gradient appliqué via ShaderMask
                            inactiveColor: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: TSizes.spaceBtwItems.v),
                  FormDividerWidget(dividerText: "lbl_weight".tr, thikness: 2),
                  SizedBox(height: TSizes.spaceBtwItems.v),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Afficher l’âge sous le slider
                      Text(
                        "${controller.currentRangeWeightValues.value.start.round()} ${'lbl_kg'.tr} - ${controller.currentRangeWeightValues.value.end.round()} ${'lbl_kg'.tr}",
                        //"${controller.currentWeightValue.value.round()} KG",
                        style: TextStyle(fontSize: 16.adaptSize, fontWeight: FontWeight.w500,
                            color: isLight ? TColors.black : TColors.lightGrey),
                      ),
                      // Slider avec gradient, label toujours visible, hauteur augmentée
                      ShaderMaskWidget(
                        child: SliderTheme(
                          data: SliderTheme.of(Get.context!).copyWith(
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
                          child: RangeSlider(
                            values: controller.currentRangeWeightValues.value,
                            min: 40,
                            max: 200,
                            divisions: 200,
                            labels: RangeLabels(
                              controller.currentRangeWeightValues.value.start.round().toString(),
                              controller.currentRangeWeightValues.value.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              controller.currentRangeWeightValues.value = values;
                              debugPrint("range weight : ${controller.currentRangeWeightValues.value}");
                            },
                            activeColor: Colors.white, // ✅ Gradient appliqué via ShaderMask
                            inactiveColor: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: TSizes.spaceBtwItems.v),
                  FormDividerWidget(dividerText: "lbl_height".tr, thikness: 2),
                  SizedBox(height: TSizes.spaceBtwItems.v),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Afficher l’âge sous le slider
                      Text(
                        "${controller.currentRangeHeightValues.value.start.round()} ${'lbl_cm'.tr} - ${controller.currentRangeHeightValues.value.end.round()} ${'lbl_cm'.tr}",
                        //"${controller.currentHeightValue.value.round()} CM",
                        style: TextStyle(fontSize: 16.adaptSize, fontWeight: FontWeight.w500,
                            color: isLight ? TColors.black : TColors.lightGrey),
                      ),
                      // Slider avec gradient, label toujours visible, hauteur augmentée
                      ShaderMaskWidget(
                        child: SliderTheme(
                          data: SliderTheme.of(Get.context!).copyWith(
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
                          child: RangeSlider(
                            values: controller.currentRangeHeightValues.value,
                            min: 100,
                            max: 240,
                            divisions: 240,
                            labels: RangeLabels(
                              controller.currentRangeHeightValues.value.start.round().toString(),
                              controller.currentRangeHeightValues.value.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              controller.currentRangeHeightValues.value = values;
                              debugPrint("range Height : ${controller.currentRangeHeightValues.value}");
                            },
                            activeColor: Colors.white, // ✅ Gradient appliqué via ShaderMask
                            inactiveColor: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: TSizes.spaceBtwItems.v),
                  FormDividerWidget(dividerText: "lbl_skin_color".tr, thikness: 2),
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

                  CustomDropDownString(
                    hintText: 'marital_status'.tr,
                    items: ListMaritalStatusFilter,
                    selectedValue: controller.maritalStatusController.text,
                    onChanged: (value) async {
                      controller.maritalStatusController.text = value;
                      debugPrint('marital status : ${controller.maritalStatusController.text}');
                    },
                    icon: Icon(Iconsax.arrow_down_1),
                    borderRadius: 15.hw,
                    contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                    fillColor: isLight ? TColors.white : TColors.dark,
                    hintStyle: isLight ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: isLight ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:isLight ?  appTheme.gray50 : TColors.darkerGrey,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.hw),
                      borderSide: BorderSide(color: TColors.darkGrey, width: 1),
                      //borderSide: BorderSide.none,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.v),

                  CustomDropDownString(
                    hintText: 'type_marriage'.tr,
                    items: ListMarriageTypeFilter,
                    selectedValue: controller.lookingForController.text,
                    onChanged: (value) async {
                      controller.lookingForController.text = value;
                      debugPrint('marriage type : ${controller.lookingForController.text}');
                    },
                    icon: Icon(Iconsax.arrow_down_1),
                    borderRadius: 15.hw,
                    contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                    fillColor: isLight ? TColors.white : TColors.dark,
                    hintStyle: isLight ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: isLight ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:isLight ?  appTheme.gray50 : TColors.darkerGrey,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.hw),
                      borderSide: BorderSide(color: TColors.darkGrey, width: 1),
                      //borderSide: BorderSide.none,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.v),

                /*  CustomTextFormField(
                    controller: controller.jobController,
                    hintText: "${'الوظيفة'.tr} *",
                    maxLines: 2,
                    textInputType: TextInputType.text,
                    prefixConstraints: BoxConstraints(maxHeight: 60.v),
                    contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                    validator: (value) => Validator.validateEmptyText('${'Job'.tr}', value),
                    fillColor: isLight ? TColors.white : TColors.dark,
                    hintStyle: isLight ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                    textStyle: isLight ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.v), */

                  CustomDropDownCountry(
                    hintText: 'state'.tr,
                    items: PaysListFilter.value,
                    selectedValue: controller.selectedPays.value,
                    onChanged: (val) => controller.selectedPays.value = val,
                    //focusNode: controller.paysFocus,
                    icon: Icon(Iconsax.arrow_down_1),
                    borderRadius: 15.hw,
                    contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                    fillColor: isLight ? TColors.white : TColors.dark,
                    hintStyle: isLight ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: isLight ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:isLight ?  appTheme.gray50 : TColors.darkerGrey,
                  ),
                  /*
                  CustomDropDown(
                    hintText: "${'دولة'.tr}",
                    items: ListPays.value,
                    selectedValue: controller.selectedPays.value,
                    onChanged: (value) async {
                      controller.selectedPays.value = value;
                      controller.paysController.text = value.title;
                      debugPrint('pays : ${controller.paysController.text}');
                    },
                    icon: Icon(Iconsax.arrow_down_1),
                    borderRadius: 15.hw,
                    contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                    fillColor: isLight ? TColors.white : TColors.dark,
                    hintStyle: isLight ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: isLight ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:isLight ?  appTheme.gray50 : TColors.darkerGrey,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.hw),
                      borderSide: BorderSide(color: TColors.darkGrey, width: 1),
                      //borderSide: BorderSide.none,
                    ),
                  ),
                   */

                  SizedBox(height: TSizes.spaceBtwItems.v),
                 /* MultiSelectDropdown(
                    hint: "حدد الهوايات",
                    items: interestsList,
                    controller: controller,
                    borderRadius: 15,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: isSmallPhone ? 8 : 12),
                    fillColor: isLight ? TColors.white : TColors.dark,
                    hintStyle: isLight ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: isLight ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:isLight ?  appTheme.gray50 : TColors.darkerGrey,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.v), */

                  ///Method with Wrap
                  /*  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: controller.selectedInterests.map((interest) {
                      return InterestWidget(
                        text: interest.name,
                        iconPath: interest.icon,
                        isSelected: true,
                        activeColor: true,
                        onTap: () => controller.toggleInterest(interest, Get.context!),
                        verticalPadding: 10.v,
                        showRandomColor: true, // ✅ active les couleurs aléatoires
                        randomList: [
                          const Color(0xFFFFF9C4), // jaune clair
                          const Color(0xFFE1BEE7), // violet clair
                          const Color(0xFFB3E5FC), // bleu clair
                          const Color(0xFFC8E6C9), // vert clair
                          const Color(0xFFFFE0B2), // orange clair
                          const Color(0xFFFFCDD2), // rose clair
                        ],
                      );
                    }).toList(),
                  ), */
                  ///Method with GridView
                  /* GridView.count(
                    crossAxisCount: isTablet ? 3 : 2, // ✅ Deux colonnes fixes
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Empêche le scroll dans un Column
                    childAspectRatio: 2, // ✅ contrôle la largeur/hauteur
                    children: controller.selectedInterests.map((interest) {
                      return InterestWidget(
                        text: interest.name,
                        iconPath: interest.icon,
                        isSelected: true,
                        activeColor: false,
                        onTap: () => controller.toggleInterest(interest, context),
                      );
                    }).toList()
                ), */

                  SizedBox(height: TSizes.spaceBtwItems.v),
                  SizedBox(
                    width: isTablet ? mediaQueryData.size.width * 0.2 : mediaQueryData.size.width * 0.4,
                    child: CustomButtonContainer(
                      text:"lbl_filter".tr,
                      color1: TColors.primaryColorApp,
                      color2: TColors.primaryColorApp,
                      borderRadius: 10,
                      colorText: TColors.white,
                      fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                      height: isSmallPhone ? 80.v : isTablet ? 70.v : 65.v,
                      width: screenWidth * 0.8,
                      onPressed: () async {
                        Navigator.pop(Get.context!);
                       await controller.applyFilters();
                      },
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwItems.v),
                ],
              ),
            ))
        )
    );
  }

  static Future<void> openDialogFilterByPays(MainController controller) async {
    var screenWidth = Get.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    var _appTheme = PrefUtils.getTheme();

    await Dialogs.customModalBottomSheet(
        //await Dialogs.customModalBottomSheetMethod2(
        Get.context!,
        0.6,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.fSize, vertical: TSizes.spaceBtwItems.fSize),
            child: ListBody(
              children: <Widget>[
                SizedBox(height: TSizes.spaceBtwSections.adaptSize),

                /// 1️⃣ Pays "الکل" sur toute la largeur
            Obx(() {
              final countryAlkol = countriesList.firstWhere((c) => c.name == "الکل");
              final isSelected = controller.selectedCountries.contains(countryAlkol.name);

              return Align(
                alignment: Alignment.centerRight, // ✅ positionne le bloc à droite comme les autres
                child: SizedBox(
                  width: Get.width * 0.47, // ✅ limite à 40% de la largeur de l’écran
                  child: GestureDetector(
                    onTap: () => controller.toggleCountry(countryAlkol.name),
                    child: TRoundedContainer(
                      backgroundColor: _appTheme == 'light' ? TColors.white : TColors.dark,
                      //margin: EdgeInsets.only(right: 20.hw),
                      //padding: EdgeInsets.only(right: 30, left: 20, top: 12, bottom: 12),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Directionality(
                        textDirection: TextDirection.rtl, // ✅ texte arabe à droite
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ texte à droite, checkbox à gauche
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                countryAlkol.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: _appTheme == 'light' ? TColors.black : TColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.adaptSize,
                                ),
                              ),
                            ),
                            Container(
                              height: 30.adaptSize,
                              width: 30.adaptSize,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.grey : Colors.transparent,
                                border: Border.all(
                                  color: _appTheme == 'light'
                                      ? Colors.blueGrey
                                      : TColors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: isSelected
                                  ? Icon(Icons.check, size: 18, color: TColors.primaryColorApp)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),

               /* Obx(() {
                  final countryAlkol = countriesList.firstWhere((c) => c.name == "الکل");
                  final isSelected = controller.selectedCountries.contains(countryAlkol.name);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: PaysWidget(
                      text: countryAlkol.name,
                      imagePath: countryAlkol.imagePath,
                      isSelected: isSelected,
                      onTap: () => controller.toggleCountry(countryAlkol.name),
                      fullWidth: true,   // ✅ prend toute la ligne
                    ),
                  );
                }), */

                SizedBox(height: 15),

                /// 2️⃣ Les autres pays (3 par ligne)
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Obx(() {
                    final otherCountries =
                    countriesList.where((c) => c.name != "الکل").toList();

                    return GridView.count(
                      crossAxisCount: isTablet ? 3 : 2, // ✅ Trois par ligne
                      shrinkWrap: true,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: isTablet ? 3.2 : 3.1,
                      //childAspectRatio: 2.2,
                      children: otherCountries.map((country) {
                        final isSelected = controller.selectedCountries.contains(country.name);
                        return PaysWidget(
                          text: country.name,
                          imagePath: country.imagePath,
                          isSelected: isSelected,
                          onTap: () => controller.toggleCountry(country.name),
                        );
                      }).toList(),
                    );
                  }),
                ),

                SizedBox(height: TSizes.spaceBtwItems.v),

                /// 3️⃣ Bouton Enregistrer
                SizedBox(
                  width: isTablet
                      ? mediaQueryData.size.width * 0.2
                      : mediaQueryData.size.width * 0.4,
                  child: CustomButtonContainer(
                    text: "حفظ".tr,
                    color1: TColors.primaryColorApp,
                    color2: TColors.primaryColorApp,
                    borderRadius: 10,
                    colorText: TColors.white,
                    fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                    height: isSmallPhone ? 80.v : isTablet ? 70.v : 65.v,
                    width: screenWidth * 0.8,
                    onPressed: () async {
                      var bottomController = BottomBarController.instance;
                      bottomController.updateCountryTitle();
                      Get.back();
                      controller.filterUsersByCountry();
                    },
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwItems),
              ],
            )

        )
    );
  }

  static Future<void> openDialogFilterByPaysDesign2(MainController controller) async {
    var screenWidth = Get.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    var isLight = PrefUtils.getTheme() == "light";

    await Dialogs.customModalBottomSheet(
      //await Dialogs.customModalBottomSheetMethod2(
        Get.context!,
        0.7,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.fSize, vertical: TSizes.spaceBtwItems.fSize),
            child: ListBody(
              children: <Widget>[
                SizedBox(height: TSizes.spaceBtwSections.adaptSize),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
                  child: TitleWidget(title: "اختر الدولة".tr,
                      color: isLight ? TColors.black : TColors.white,
                      textAlign: TextAlign.right),
                ),
                SizedBox(height: TSizes.spaceBtwSections.adaptSize),
                Obx(() => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.2,
                  children: countriesList.map((country) {
                    final isSelected = controller.selectedCountries.contains(country.name);
                    return PaysWidget(
                      text: country.name,
                      imagePath: country.imagePath,
                      isSelected: isSelected,
                      onTap: () => controller.toggleCountry(country.name),
                    );
                  }).toList(),
                )),
                SizedBox(height: TSizes.spaceBtwItems.v),
                SizedBox(
                  width: isTablet ? mediaQueryData.size.width * 0.2 : mediaQueryData.size.width * 0.4,
                  child: CustomButtonContainer(
                    text:"حفظ".tr,
                    color1: TColors.primaryColorApp,
                    color2: TColors.primaryColorApp,
                    borderRadius: 10,
                    colorText: TColors.white,
                    fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                    height: isSmallPhone ? 80.v : isTablet ? 70.v : 65.v,
                    width: screenWidth * 0.8,
                    onPressed: () async {
                      var bottomController = BottomBarController.instance;
                      bottomController.updateCountryTitle();
                      //controller.updateCountryTitle();
                      Get.back();
                      //controller.saveBtn();
                    },
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
              ],
            )
        )
    );
  }
}