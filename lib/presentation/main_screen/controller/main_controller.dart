import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/popups/search_dating.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:flutter/foundation.dart';

class MainController extends GetxController {
  static MainController get instance => Get.find();

  final RxList<UserModel> users = <UserModel>[].obs;
  var selectedCountries = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }
/*
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 300), (){
      SearchDating.openDialogFilterByPays(instance);
    });
  } */

  void loadUsers() {
    users.value = [
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding1,
        fullName: 'نورا خالد',
        age: 25,
        bio: '🌍📸 نموذج احترافي',
        isFavoris: true,
        interests: ["التسوق", "فوتوغرافيا", "اليوغا"],
        images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
      ),
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding2,
        fullName: 'نورا خالد',
        age: 32,
        bio: 'مبرمج',
          isFavoris: true,
        interests: ["كاريوكي", "التنس", "اليوغا", "طبخ", "سباحة"],
          images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
      ),
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding3,
        fullName: 'ايلاف خالد',
        age: 29,
        bio: 'شخص إعلامي',
          isFavoris: false,
        interests: ["ركض", "السفر", "قراءة", "طبخ", "سباحة"],
        images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
      ),
    ];
  }

   toggleCountry(String countryName) {
    if (selectedCountries.contains(countryName)) {
      selectedCountries.remove(countryName);
    } else {
      selectedCountries.add(countryName);
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