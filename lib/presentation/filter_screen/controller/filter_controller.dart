import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
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

  ///Interests Start
  var selectedInterests = <InterestModel>[].obs;

  void toggleInterest(InterestModel interest, BuildContext context) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
     /* if (selectedInterests.length >= 5) {
        showMaxInterestDialog(context);
        return;
      } */
      selectedInterests.add(interest);
    }
    debugPrint('Interests: ${selectedInterests.map((e) => e.name).toList()}');
  }
  ///Interests end

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
          interests: ["التسوق", "فوتوغرافيا", "اليوغا"],
          images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5]
      ),
      UserModel(
          imageProfile: ImageConstant.imgOnBoarding2,
          fullName: 'نورا خالد',
          age: 32,
          bio: 'مبرمج',
          interests: ["كاريوكي", "التنس", "اليوغا", "طبخ", "سباحة"],
          images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5]
      ),
      UserModel(
          imageProfile: ImageConstant.imgOnBoarding3,
          fullName: 'ايلاف خالد',
          age: 29,
          bio: 'شخص إعلامي',
          interests: ["ركض", "السفر", "قراءة", "طبخ", "سباحة"],
          images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5]
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

  ///Filter Function
  applyFilters() {
//Start Loading
    FullScreenLoader.openLoadingSearchDialog("مباراة البحث", "مطابقة الأشخاص مع متطلباتك",ImageConstant.imgLove, ImageConstant.imgLoves);
    //FullScreenLoader.openLoadingDialog('مطابقة الأشخاص مع متطلباتك..', ImageConstant.lottieTrophy);

    Future.delayed(const Duration(milliseconds: 4000), (){
      //Remove Loader
      FullScreenLoader.stopLoading();
    });

  }
}