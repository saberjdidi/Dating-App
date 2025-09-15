import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/controller/create_account_controller.dart';
import 'package:dating_app_bilhalal/widgets/account/choice-chip.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/account/profile_image_stack.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/custom_drop_down.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/form_divider_widget.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class OverviewAccountScreen extends GetWidget<CreateAccountController> {
  OverviewAccountScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeyOverviewAccount = GlobalKey<
      ScaffoldState>();
  var _appTheme = PrefUtils().getThemeData();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        child: Form(
          key: controller.formOverviewAccountKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Scaffold(
            backgroundColor: _appTheme == 'light' ? TColors.white : appTheme
                .primaryColor,
            appBar: TAppBar(
              showBackArrow: true,
              rightToLeft: true,
              title: Text('ملخص',
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
                            hintText: "${'الاسم الكامل'.tr} *",
                            textInputType: TextInputType.text,
                            prefixConstraints: BoxConstraints(maxHeight: 60.v),
                            contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                            validator: (value) => Validator.validateEmptyText('${'lbl_lastName'.tr}', value),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems.v),

                          CustomTextFormField(
                            controller: controller.bioController,
                            hintText: "${'بایو'.tr} *",
                            maxLines: 3,
                            textInputType: TextInputType.text,
                            prefixConstraints: BoxConstraints(maxHeight: 60.v),
                            contentPadding: EdgeInsets.only(top: 21.v, right: 30.hw, left: 30.hw, bottom: 21.v),
                            validator: (value) => Validator.validateEmptyText('${'lbl_firstName'.tr}', value),
                          ),

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
                            maxLines: 3,
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
                          FormDividerWidget(dividerText: "نطاق الراتب", thikness: 2),
                          SizedBox(height: TSizes.spaceBtwItems.v),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ✅ Afficher les valeurs sous le slider
                              Text(
                                "${controller.currentRangeValues.value.start.round()}K - ${controller.currentRangeValues.value.end.round()}K",
                                style: TextStyle(fontSize: 16.adaptSize, fontWeight: FontWeight.bold),
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
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems.v),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubTitleWidget(subtitle: "الاهتمامات"),
                                CustomImageView(
                                  imagePath: ImageConstant.uploadImageRounded,
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

                          SizedBox(height: TSizes.spaceBtwItems.v),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems.v),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubTitleWidget(subtitle: "معرض"),
                                CustomImageView(
                                  imagePath: ImageConstant.uploadImageRounded,
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
                                      child: CircularContainer(
                                        width: 35.adaptSize,
                                        height: 35.adaptSize,
                                        radius: 35.adaptSize,
                                        backgroundColor: TColors.lightGrey,
                                        child: IconButton(
                                          icon: Icon(Icons.close, color: Colors.red, size: 15.adaptSize,),
                                          onPressed: () => controller.removeMedia(index - 1),
                                        ),
                                      ),
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
                  left: TSizes.spaceBtwItems.hw,
                  right: TSizes.spaceBtwItems.hw),
              //child: _buildButtonSection()
              child:
              CustomButtonContainer(
                text:"تأكيد الحساب".tr,
                color1: TColors.yellowAppDark,
                color2: TColors.yellowAppLight,
                borderRadius: 10,
                colorText: TColors.white,
                fontSize: 20.adaptSize,
                onPressed: () async {
                  Get.offAllNamed(Routes.successAccountScreen);
                  //controller.saveBtn();
                },
              ),
            ),
          ),
        )
    );
  }
}