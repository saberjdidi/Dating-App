import 'package:dating_app_bilhalal/core/utils/popups/search_dating.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  static BottomBarController get instance => Get.find();
  final mainController = Get.put(MainController());

  RxInt selectedIndex = 0.obs;
  //var selectedCountries = <String>[].obs;
  RxString selectedCountryTitle = "الکل".obs;

 /* void changeTabIndex(int index) {
    selectedIndex.value = index;
  } */

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    if (index == 2) { // si onglet "main" sélectionné
      openSearchDialog();
    }
  }
/*
  void toggleCountry(String countryName) {
    if (selectedCountries.contains(countryName)) {
      selectedCountries.remove(countryName);
    } else {
      selectedCountries.add(countryName);
    }
    updateCountryTitle();
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

    Future.delayed(Duration.zero, () {
      SearchDating.openDialogFilterByPays(mainController); // 👈 appelé uniquement quand onglet "main"
    });
  }


}
