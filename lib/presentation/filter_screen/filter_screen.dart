import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/controller/filter_controller.dart';
import 'package:dating_app_bilhalal/widgets/home/animated_gradient_progress.dart';
import 'package:dating_app_bilhalal/widgets/home/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FilterScreen extends StatelessWidget {
   FilterScreen({super.key});

  final controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: AppBar(title: const Text("Dating App")),
      body: Stack(
        children: [
          Obx(() {
            if (controller.users.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return CardSwiper(
              controller: controller.swiperController,
              cardsCount: controller.users.length,
              numberOfCardsDisplayed: 1,
              isLoop: true,
              padding: EdgeInsets.zero,
              allowedSwipeDirection: const AllowedSwipeDirection.only(
                up: true,
                down: true,
                left: false,
                right: false,
              ),
              onSwipe: (previousIndex, currentIndex, direction) {
                if (direction == CardSwiperDirection.top) {
                  // 🔼 Swipe vers le haut → précédent
                  final targetIndex =
                      (previousIndex! - 1 + controller.cardsCount) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false; // Bloque le swipe horizontal
                } else if (direction == CardSwiperDirection.bottom) {
                  // 🔽 Swipe vers le bas → suivant
                  final targetIndex = (previousIndex! + 1) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false;
                }

                // Si tu veux encore gérer les swipes gauche/droite :
                if (direction == CardSwiperDirection.left) {
                  final targetIndex =
                      (previousIndex! - 1 + controller.cardsCount) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false;
                } else if (direction == CardSwiperDirection.right) {
                  final targetIndex = (previousIndex! + 1) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false;
                }

                return true;
              },
              //maxAngle: 30,
              cardBuilder: (context, index, percentX, percentY) {
                final user = controller.users[index];
                return UserCardWidget(
                  user: user,
                  onMessageTap: () async {
                    debugPrint("message ${user.fullName}");
                  },
                  onFavoriteTap: () async {

                  },
                /*  onTapFilter: () async {
                    await dialogSearch(context);
                  }, */
                );
              },
            );
          }),
        ],
      ),
    );
  }
  /*
  dialogSearch(BuildContext context) async {
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
                    color2: TColors.primaryColorApp,
                    borderRadius: 10,
                    colorText: TColors.white,
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
  }  */
}

///FilterScreen avec  progression animée
/*
class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: AppBar(title: const Text("Dating App")),
      body: Stack(
        children: [
          Obx(() {
            if (controller.users.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return CardSwiper(
              controller: controller.swiperController,
              cardsCount: controller.users.length,
              numberOfCardsDisplayed: 1,
              isLoop: true,
              padding: EdgeInsets.zero,
              //Auto Swiper with timer - Mise à jour du callback onSwipe
              onSwipe: (previousIndex, currentIndex, direction) {
                // Relance toujours le timer sur geste manuel
                controller.onSwipe();

                if (direction == CardSwiperDirection.left) {
                  // Swipe gauche : Va au précédent (non aléatoire)
                  final targetIndex = (previousIndex! - 1 + controller.cardsCount) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false; // Annule le swipe gauche pour éviter le next par défaut
                } else {
                  // Swipe droite (ou autre) : Autorise le next séquentiel
                  // Met à jour l'index après l'animation (microtask pour sync)
                  Future.microtask(() {
                    controller.currentIndex.value = currentIndex ?? 0;
                  });
                  return true;
                }
              },
              //Auto Swiper with timer
              /* onSwipe: (previousIndex, currentIndex, direction) {
                // ✅ Lorsqu’on swipe manuellement, on relance le timer
                controller.onSwipe();
                return true;
              }, */
              //maxAngle: 30,
              cardBuilder: (context, index, percentX, percentY) {
                final user = controller.users[index];
                return UserCardWidget(
                  user: user,
                  onMessageTap: () async {
                    debugPrint("message ${user.fullName}");
                  },
                  onFavoriteTap: () async {

                  },
                  /*  onTapFilter: () async {
                    await dialogSearch(context);
                  }, */
                );
              },
            );
          }),

          // ✅ Barre de progression animée
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Obx(() => AnimatedGradientProgressWidget(
              progress: controller.progress.value,
            )),
          ),
        ],
      ),
    );
  }
}
*/