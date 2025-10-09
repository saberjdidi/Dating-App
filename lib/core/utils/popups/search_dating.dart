import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/controller/filter_controller.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:dating_app_bilhalal/widgets/account/choice-chip.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/home/pays_widget.dart';
import 'package:dating_app_bilhalal/widgets/multi_select_dopdown.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SearchDating {
  static Future<void> openDialogFilterUser(FilterController controller) async {
    var screenWidth = Get.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    var _appTheme = PrefUtils.getTheme();

    await Dialogs.customModalBottomSheet(
        Get.context!,
        0.8,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.fSize, vertical: TSizes.spaceBtwItems.fSize),
            child: Obx(() => Directionality(
              textDirection: TextDirection.rtl,
              child: ListBody(
                children: <Widget>[
                  SizedBox(height: TSizes.spaceBtwSections.adaptSize),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
                    child: TitleWidget(title: "فلتر".tr,
                        color: _appTheme =='light' ? TColors.black : TColors.white,
                        textAlign: TextAlign.right),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.adaptSize),
                  FormDividerWidget(dividerText: "عمر", thikness: 2),
                  SizedBox(height: TSizes.spaceBtwItems.v),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Afficher l’âge sous le slider
                      Text(
                        "${controller.currentRangeAgeValues.value.start.round()} ${'سنة'} - ${controller.currentRangeAgeValues.value.end.round()} ${'سنة'}",
                        //"${controller.currentAgeValue.value.round()}",
                        style: TextStyle(fontSize: 16.adaptSize, fontWeight: FontWeight.bold,
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
                            min: 15,
                            max: 70,
                            divisions: 70,
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
                        /*  child: Slider(
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
                          ), */
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
                      Text(
                        "${controller.currentRangeWeightValues.value.start.round()} ${'كلغ'} - ${controller.currentRangeWeightValues.value.end.round()} ${'كلغ'}",
                        //"${controller.currentWeightValue.value.round()} KG",
                        style: TextStyle(fontSize: 16.adaptSize, fontWeight: FontWeight.bold,
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
                            min: 15,
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
                         /* child: Slider(
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
                          ), */
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
                      Text(
                        "${controller.currentRangeHeightValues.value.start.round()} ${'صم'} - ${controller.currentRangeHeightValues.value.end.round()} ${'صم'}",
                        //"${controller.currentHeightValue.value.round()} CM",
                        style: TextStyle(fontSize: 16.adaptSize, fontWeight: FontWeight.bold,
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
                            min: 80,
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
                         /* child: Slider(
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
                          ), */
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: TSizes.spaceBtwItems.v),
                  FormDividerWidget(dividerText: "لون البشرة", thikness: 2),
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
                  FormDividerWidget(dividerText: "جنسك", thikness: 2),
                  SizedBox(height: TSizes.spaceBtwItems.v),

                  /*
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
                                      return TColors.yellowAppDark; // ✅ Cercle actif jaune
                                    }
                                    return Colors.grey; // Cercle inactif gris
                                  }),
                                ),
                                SubTitleWidget(subtitle: 'امراة', color: _appTheme =='light' ? TColors.black : TColors.white, fontSizeDelta: 2, fontWeightDelta: 2),
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
                                      return TColors.yellowAppDark;
                                    }
                                    return Colors.grey;
                                  }),
                                ),
                                SubTitleWidget(subtitle: 'رجل', color: _appTheme =='light' ? TColors.black : TColors.white, fontSizeDelta: 2, fontWeightDelta: 2,),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.v),
                  */

                  CustomDropDown(
                    //textStyle: TextStyle(color: appTheme.black),
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
                    icon: Icon(Iconsax.arrow_down_1),
                    borderRadius: 15.hw,
                    contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                    fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                    hintStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:_appTheme =='light' ?  appTheme.gray50 : TColors.darkerGrey,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.v),

                  CustomDropDown(
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
                    icon: Icon(Iconsax.arrow_down_1),
                    borderRadius: 15.hw,
                    contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                    fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                    hintStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:_appTheme =='light' ?  appTheme.gray50 : TColors.darkerGrey,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.v),

                /*  CustomTextFormField(
                    controller: controller.jobController,
                    hintText: "${'الوظيفة'.tr} *",
                    maxLines: 2,
                    textInputType: TextInputType.text,
                    prefixConstraints: BoxConstraints(maxHeight: 60.v),
                    contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                    validator: (value) => Validator.validateEmptyText('${'Job'.tr}', value),
                    fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                    hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                    textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems.v), */

                  CustomDropDown(
                    hintText: "${'دولة'.tr} *",
                    items: ListPays.value,
                    onChanged: (value) async {
                      controller.paysController.text = value.title;
                      debugPrint('pays : ${controller.paysController.text}');
                    },
                    validator: (value) {
                      if (value == null) {
                        return "${'lbl_region'.tr} ${"lbl_is_required".tr}";
                      }
                      return null;
                    },
                    icon: Icon(Iconsax.arrow_down_1),
                    borderRadius: 15.hw,
                    contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                    fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                    hintStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:_appTheme =='light' ?  appTheme.gray50 : TColors.darkerGrey,
                  ),

                  SizedBox(height: TSizes.spaceBtwItems.v),
                  MultiSelectDropdown(
                    hint: "حدد الهوايات",
                    items: interestsList,
                    controller: controller,
                    borderRadius: 15,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: isSmallPhone ? 8 : 14),
                    fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                    hintStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    textStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSourceSansPro : CustomTextStyles.bodyMediumTextFormFieldWhite,
                    themeColor:_appTheme =='light' ?  appTheme.gray50 : TColors.darkerGrey,
                  ),
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
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: controller.selectedInterests.map((interest) {
                      return InterestWidget(
                        text: interest.name,
                        iconPath: interest.icon,
                        isSelected: true,
                        activeColor: false,
                        onTap: () => controller.toggleInterest(interest, Get.context!),
                        verticalPadding: 20.v,
                      );
                    }).toList(),
                  ),

                  SizedBox(height: TSizes.spaceBtwItems.v),
                  SizedBox(
                    width: isTablet ? mediaQueryData.size.width * 0.2 : mediaQueryData.size.width * 0.4,
                    child: CustomButtonContainer(
                      text:"تطبيق المرشحات".tr,
                      color1: TColors.yellowAppDark,
                      color2: TColors.yellowAppLight,
                      borderRadius: 10,
                      colorText: TColors.redAppLight,
                      fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                      height: isSmallPhone ? 80.v : 70.v,
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
        0.7,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.fSize, vertical: TSizes.spaceBtwItems.fSize),
            child: ListBody(
              children: <Widget>[
                /*   Center(
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.keyboard_arrow_down_rounded, color: TColors.textSecondary, size: 40.adaptSize,)
                ),
              ), */
                SizedBox(height: TSizes.spaceBtwSections.adaptSize),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
                  child: TitleWidget(title: "اختر الدولة".tr,
                      color: _appTheme =='light' ? TColors.black : TColors.white,
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
                    text:"حفظ التغييرات".tr,
                    color1: TColors.yellowAppDark,
                    color2: TColors.yellowAppLight,
                    borderRadius: 10,
                    colorText: TColors.redAppLight,
                    fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                    height: isSmallPhone ? 80.v : 70.v,
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