import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/controller/filter_controller.dart';
import 'package:dating_app_bilhalal/widgets/account/choice-chip.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/home/pays_widget.dart';
import 'package:dating_app_bilhalal/widgets/home/user_card_widget.dart';
import 'package:dating_app_bilhalal/widgets/multi_select_dopdown.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());
    return Scaffold(
      //appBar: AppBar(title: const Text("Dating App")),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return CardSwiper(
          cardsCount: controller.users.length,
          numberOfCardsDisplayed: 1,
          isLoop: true,
          padding: EdgeInsets.zero,
          //maxAngle: 30,
          cardBuilder: (context, index, percentX, percentY) {
            final user = controller.users[index];
            return UserCardWidget(
              user: user,
              onMessageTap: () async {
                debugPrint("message ${user.fullName}");
              },
              onFavoriteTap: () async {
                await dialogSearch(context, controller);
              },
            );
          },
        );
      }),
    );
  }

  dialogSearch(BuildContext context, FilterController controller) async {
    var screenWidth = MediaQuery.of(context).size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    //controller.searchVilleController.clear();

    await Dialogs.customModalBottomSheet(
        context,
        0.8,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.fSize, vertical: TSizes.spaceBtwItems.fSize),
          child: Obx(() => Directionality(
            textDirection: TextDirection.rtl,
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
                  child: TitleWidget(title: "فلتر".tr,
                      textAlign: TextAlign.right),
                ),
                SizedBox(height: TSizes.spaceBtwSections.adaptSize),
                SizedBox(height: TSizes.spaceBtwItems.v),
                FormDividerWidget(dividerText: "عمر", thikness: 2),
                SizedBox(height: TSizes.spaceBtwItems.v),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ✅ Afficher l’âge sous le slider
                    Text("${controller.currentAgeValue.value.round()}",
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
                FormDividerWidget(dividerText: "الوزن", thikness: 2),
                SizedBox(height: TSizes.spaceBtwItems.v),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ✅ Afficher l’âge sous le slider
                    Text("${controller.currentWeightValue.value.round()} KG",
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
                FormDividerWidget(dividerText: "الطول", thikness: 2),
                SizedBox(height: TSizes.spaceBtwItems.v),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ✅ Afficher l’âge sous le slider
                    Text("${controller.currentHeightValue.value.round()} CM",
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TRoundedContainer(
                        showBorder: true,
                        borderColor: TColors.greyDating,
                        padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 10.v),
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
                            TitleWidget(title: 'امراة',),
                          ],
                        )
                    ),

                    TRoundedContainer(
                        showBorder: true,
                        borderColor: TColors.greyDating,
                        padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 10.v),
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
                            TitleWidget(title: 'رجل',),
                          ],
                        )
                    ),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems.v),

                CustomDropDown(
                  fillColor: TColors.white, //appTheme.gray50
                  //textStyle: TextStyle(color: appTheme.black),
                  hintStyle: CustomTextStyles.bodyMediumTextFormField,
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
                  contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                ),
                SizedBox(height: TSizes.spaceBtwItems.v),

                CustomDropDown(
                  fillColor: TColors.white, //appTheme.gray50
                  //textStyle: TextStyle(color: appTheme.black),
                  hintStyle: CustomTextStyles.bodyMediumTextFormField,
                  hintText: "${'أبحث عن'.tr} *",
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
                  borderRadius: 15.hw,
                  contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                ),
                SizedBox(height: TSizes.spaceBtwItems.v),

                CustomTextFormField(
                  controller: controller.jobController,
                  hintText: "${'إشغال'.tr} *",
                  maxLines: 2,
                  textInputType: TextInputType.text,
                  prefixConstraints: BoxConstraints(maxHeight: 60.v),
                  contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                  validator: (value) => Validator.validateEmptyText('${'Job'.tr}', value),
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
                      return "${'lbl_region'.tr} ${"lbl_is_required".tr}";
                    }
                    return null;
                  },
                  themeColor: appTheme.gray50,
                  borderRadius: 15.hw,
                  contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                ),

                SizedBox(height: TSizes.spaceBtwItems.v),
               /* MultiSelectDropdown(
                  hint: "Sélectionner Interests",
                  items: interestsList,
                  selectedItems: controller.selectedInterests,
                  onChanged: controller.toggleInterest,
                ), */
                MultiSelectDropdown(
                  hint: "حدد الهوايات",
                  items: interestsList,
                  controller: controller,
                  borderRadius: 15,
                  fillColor: Colors.white,
                  themeColor: appTheme.gray50,
                  hintStyle: CustomTextStyles.bodyMediumTextFormField,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.selectedInterests.map((interest) {
                    return InterestWidget(
                      text: interest.name,
                      iconPath: interest.icon,
                      isSelected: true,
                      activeColor: false,
                      onTap: () => controller.toggleInterest(interest, context),
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
                    fontSize: 20.adaptSize,
                    onPressed: () async {
                      controller.applyFilters();
                      Navigator.pop(context);
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
}
