import 'dart:async';
import 'package:dating_app_bilhalal/core/utils/enums.dart';
import 'package:dating_app_bilhalal/core/utils/image_constant.dart';
import 'package:dating_app_bilhalal/core/utils/popups/search_dating.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/custom_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {

  static BottomBarController get instance => Get.find();
  final mainController = Get.put(MainController());

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.searchImg,
      activeIcon: ImageConstant.searchImg,
      title: "بحث".tr,
      type: BottomBarEnum.search,
    ),
    BottomMenuModel(
      icon: ImageConstant.discussionImg,
      activeIcon: ImageConstant.discussionImg,
      title: "محادثة".tr,
      type: BottomBarEnum.discussion,
    ),
    BottomMenuModel(
      icon: ImageConstant.mainImg,
      activeIcon: ImageConstant.mainImg,
      title: "الکل".tr,
      type: BottomBarEnum.main,
    ),
    BottomMenuModel(
      icon: ImageConstant.likeImg,
      activeIcon: ImageConstant.likeImg,
      title: "المفضلة".tr,
      type: BottomBarEnum.favoris,
    ),
    BottomMenuModel(
      icon: ImageConstant.profileSettingsImg,
      activeIcon: ImageConstant.profileSettingsImg,
      title: "إعدادات".tr,
      type: BottomBarEnum.Profile,
    )
  ];

  // index bottom bar
  RxInt selectedIndex = 0.obs;

  // title exemple (ton usage existant)
  RxString selectedCountryTitle = "الکل".obs;



  void changeTabIndex(int index) {
    selectedIndex.value = index;
    if (index == 2) { // si onglet "main" sélectionné
      openSearchDialog();
    }
  }

  void updateCountryTitle() {
    if (mainController.selectedCountries.isEmpty || mainController.selectedCountries.contains("الکل")) {
      selectedCountryTitle.value = "الکل";
    } else if (mainController.selectedCountries.length == 1) {
      selectedCountryTitle.value = mainController.selectedCountries.first;
    } else {
      selectedCountryTitle.value = "عدة دول";
    }
    debugPrint('update Country Title : ${selectedCountryTitle.value}');
  }

  void openSearchDialog() {

    Future.delayed(Duration.zero, () {
      SearchDating.openDialogFilterByPays(mainController); // 👈 appelé uniquement quand onglet "main"
    });
  }

}