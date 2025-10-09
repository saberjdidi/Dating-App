import 'dart:async';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/core/utils/popups/search_dating.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  final RxList<UserModel> users = <UserModel>[].obs;
  var selectedCountries = <String>[].obs;

  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController paysController = TextEditingController();

  RxInt sexValue = 0.obs;
  //RxDouble currentAgeValue = 20.toDouble().obs; //choice one age
  var currentRangeAgeValues = const RangeValues(20, 40).obs; // choice range of ages
  //RxDouble currentWeightValue = 50.toDouble().obs;
  var currentRangeWeightValues = const RangeValues(20, 100).obs;
  RxDouble currentHeightValue = 170.toDouble().obs;
  var currentRangeHeightValues = const RangeValues(100, 200).obs;
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
    // Démarre le swipe automatique après un petit délai
    Future.delayed(const Duration(seconds: 2), startAutoSwipe);
  }
  @override
  void onReady() {
    super.onReady();
    SearchDating.openDialogFilterUser(instance);
  }


  void loadUsers() {
    users.value = [
      UserModel(
          imageProfile: ImageConstant.imgOnBoarding1,
          fullName: 'نورا خالد',
          age: 25,
          bio: '🌍📸 نموذج احترافي',
          interests: ["التسوق", "فوتوغرافيا", "اليوغا"],
          images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
      ),
      UserModel(
          imageProfile: ImageConstant.imgOnBoarding2,
          fullName: 'نورا خالد',
          age: 32,
          bio: 'مبرمج',
          interests: ["كاريوكي", "التنس", "اليوغا", "طبخ", "سباحة"],
          images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
      ),
      UserModel(
          imageProfile: ImageConstant.imgOnBoarding3,
          fullName: 'ايلاف خالد',
          age: 29,
          bio: 'شخص إعلامي',
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

  ///Filter Function
  applyFilters() async {
//Start Loading
    FullScreenLoader.openLoadingSearchDialog("مباراة البحث", "مطابقة الأشخاص مع متطلباتك",ImageConstant.imgLove, ImageConstant.imgLoves);
    //FullScreenLoader.openLoadingDialog('مطابقة الأشخاص مع متطلباتك..', ImageConstant.lottieTrophy);

    Future.delayed(const Duration(milliseconds: 4000), (){
      //Remove Loader
      FullScreenLoader.stopLoading();
    });

  }

  ///LinearProgressIndicator Start
  final CardSwiperController swiperController = CardSwiperController();
  final RxDouble progress = 0.0.obs;
  //Timer? autoSwipeTimer;
  Timer? progressTimer;
  void startAutoSwipe() {
    stopAutoSwipe();

    const swipeInterval = Duration(seconds: 10);
    const tickInterval = Duration(milliseconds: 100);
    const totalTicks = 10000 ~/ 100; // 10s -> 100 ticks

    int tickCount = 0;
    progress.value = 0;

    progressTimer = Timer.periodic(tickInterval, (timer) {
      tickCount++;
      progress.value = tickCount / totalTicks;
      if (tickCount >= totalTicks) {
        timer.cancel();
        swiperController.swipe(CardSwiperDirection.right);
        startAutoSwipe(); // relance le cycle automatiquement
      }
    });
  }

  //without progress timer
  /* void startAutoSwipe() {
    // 🔁 Swipe automatique toutes les 10 secondes
    autoSwipeTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      swiperController.swipe(CardSwiperDirection.right);
    });
  } */

  void stopAutoSwipe() {
    //autoSwipeTimer?.cancel();
    progressTimer?.cancel(); //if add progess timer
  }

  /// 🔁 Appelé après chaque swipe (manuel ou auto)
  void onSwipe() {
    stopAutoSwipe();
    startAutoSwipe();
  }

  @override
  void onClose() {
    stopAutoSwipe();
    super.onClose();
  }
  ///LinearProgressIndicator End
}