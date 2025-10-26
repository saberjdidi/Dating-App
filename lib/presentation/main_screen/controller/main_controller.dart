import 'dart:async';
import 'dart:math';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/search_dating.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MainController extends GetxController with WidgetsBindingObserver {
  static MainController get instance => Get.find();

  final RxList<UserModel> users = <UserModel>[].obs;
  var selectedCountries = <String>[].obs;

  //Card Swiper
  final CardSwiperController swiperController = CardSwiperController();
  final RxInt currentIndex = 0.obs;
  int get cardsCount => usersList.length; // Getter pour la taille (performant)

  final userRepository = UserRepository();
  RxList<UserModel> usersList = <UserModel>[].obs;
  RxBool isDataProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    getUsers();
    //loadUsers();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  /// 🔁 Appelé quand l’écran redevient visible
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint("🔄 MainScreen resumed → refresh users");
      getUsers();
    }
  }


  @override
  void onReady() {
    super.onReady();

   /* Future.delayed(const Duration(milliseconds: 300), (){
      SearchDating.openDialogFilterByPays(instance);
    }); */
  }

  /// Méthode pour récupérer les utilisateurs
  Future<void> getUsers({String? country}) async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'Pas de connexion Internet');
        return;
      }

      final body = {
        "page": 1,
        "pageSize": 20,
        "social_states": "single",
        "sort": "relevance",
        if (country != null && country.isNotEmpty) "countries": country,
      };
      final result = await userRepository.searchUsers(body);


      if (result.success) {
        isDataProcessing.value = false;
        usersList.assignAll(result.data ?? []);
        debugPrint('✅ Liste users rechargée: ${usersList.length}');
      } else {
        isDataProcessing.value = false;
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      isDataProcessing.value = false;
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }


  Future<void> filterUsersByCountry() async {
    MessageSnackBar.successSnackBar(title: 'Country', message:  selectedCountries.first ?? '');
    if (selectedCountries.isEmpty) {
      await getUsers(); // pas de filtre
    } else {
      // pour l’instant on prend le premier pays sélectionné
      await getUsers(country: selectedCountries.first);
    }
  }
  /* toggleCountry(String countryName) {
    if (selectedCountries.contains(countryName)) {
      selectedCountries.remove(countryName);
    } else {
      selectedCountries.add(countryName);
    }
  } */
  /// Sélectionne / désélectionne un pays
  void toggleCountry(String countryName) {
    // Si on clique sur "الکل"
    if (countryName == "الکل") {
      if (selectedCountries.contains("الکل")) {
        // Si "الکل" est déjà sélectionné → tout désélectionner
        selectedCountries.clear();
      } else {
        // Si on sélectionne "الکل" → tout sélectionner
        selectedCountries.assignAll(countriesList.map((c) => c.name).toList());
      }
    } else {
      // Si on clique sur un autre pays
      if (selectedCountries.contains(countryName)) {
        // On désélectionne ce pays
        selectedCountries.remove(countryName);
        // Si "الکل" était sélectionné → on le retire
        selectedCountries.remove("الکل");
      } else {
        // On ajoute le pays
        selectedCountries.add(countryName);
        // Si tous les pays sont sélectionnés → on coche "الکل"
        if (selectedCountries.length == countriesList.length - 1 &&
            !selectedCountries.contains("الکل")) {
          selectedCountries.add("الکل");
        }
      }
    }
  }

  //titre qui sera affiché dans la bottom navigation bar
  var selectedCountryTitle = "الکل".obs;
  //Mettre à jour le titre affiché dans le bottom bar
  updateCountryTitle(){
      if(selectedCountries.isEmpty){
        selectedCountryTitle.value = "الکل";
      } else if(selectedCountries.length == 1){
        selectedCountryTitle.value = selectedCountries.first;
      } else {
        selectedCountryTitle.value = "عدة دول";
      }
      debugPrint('selectedCountryTitle : ${selectedCountryTitle.value}');
  }
}

