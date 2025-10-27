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

  // Access MainController that's registered in InitialBindings
  MainController get mainController => Get.find<MainController>();

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
      title: "المحادثات".tr,
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
      title: "المفضلات".tr,
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
  RxInt selectedIndex = 2.obs;

  // title exemple (ton usage existant)
  RxString selectedCountryTitle = "الکل".obs;

  // 🔹 indique si on vient d’ouvrir la main screen pour la première fois
  bool isFirstOpenMain = true;

   changeTabIndex(int index) async {
     final oldIndex = selectedIndex.value;
    selectedIndex.value = index;

    /*
    switch (index) {
      case 0:
        // Onglet filtre
        if (filterController.users.isEmpty) {
          await filterController.getUsers();
        }
        break;

      case 2:
        // Onglet principal
        if (mainController.usersList.isEmpty) {
          await mainController.getUsers();
        }
        break;

      case 3:
        // Favoris
        if (favoriteController.usersList.isEmpty) {
          await favoriteController.loadFavorisUsers();
        }
        break;
    }
     */

     // 🔸 Si on clique sur "main"
     if (index == 2) {
       // Cas 1 : première ouverture (navigation initiale)
       if (isFirstOpenMain) {
         isFirstOpenMain = false; // On désactive le mode "première ouverture"
         return; // Ne pas ouvrir le dialog
       }

       // Cas 2 : on clique manuellement sur "main" déjà actif
       if (oldIndex == 2) {
         openSearchDialog();
       }
     }
  }

  //open dialog when go to main screen
 /* changeTabIndex(int index) async {
    selectedIndex.value = index;
    if (index == 2) { // si onglet "main" sélectionné
      openSearchDialog();
    }
  } */

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

    //mainController.selectedCountries.clear(); //clear country when open diaog
    Future.delayed(Duration.zero, () {
      SearchDating.openDialogFilterByPays(mainController); // 👈 appelé uniquement quand onglet "main"
    });
  }

}