import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:flutter/material.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  final RxList<UserModel> users = <UserModel>[].obs;
  var selectedCountries = <String>[].obs;

  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController paysController = TextEditingController();

  RxInt sexValue = 0.obs;
  RxDouble currentAgeValue = 20.toDouble().obs;
  RxDouble currentWeightValue = 50.toDouble().obs;
  RxDouble currentHeightValue = 170.toDouble().obs;
  var currentRangeValues = const RangeValues(177, 300).obs;
  //color
  RxString selectedColor = ''.obs;
  selectColor(String color) {
    selectedColor.value = color;
    debugPrint('color : $color');
  }

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void loadUsers() {
    users.value = [
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding1,
        fullName: 'نورا خالد',
        age: 25,
        bio: '🌍📸 نموذج احترافي',
      ),
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding2,
        fullName: 'نورا خالد',
        age: 32,
        bio: 'مبرمج',
      ),
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding3,
        fullName: 'ايلاف خالد',
        age: 29,
        bio: 'شخص إعلامي',
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
}