import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:flutter/material.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  var searchText = "".obs;
  final TextEditingController searchController = TextEditingController();
  var selectedTab = 0.obs;
  var favorisUsers = <UserModel>[].obs;

  @override
  void onInit() {
    loadFavorisUsers();
  }

  Future<List<UserModel>> loadFavorisUsers() async {
    var listUsers = [
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
          isFavoris: true,
          interests: ["ركض", "السفر", "قراءة", "طبخ", "سباحة"],
          images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
      ),
    ];


    return favorisUsers.value = listUsers.where((element) => element.isFavoris == true).toList();
  }

  List<UserModel> get filteredFavorisUsers {
    var list = favorisUsers.where((chat) {
      if (searchText.isNotEmpty &&
          !chat.fullName!.toLowerCase().contains(searchText.value.toLowerCase())
         ) {
          return false;
         }
      return true;
    }).toList();
    return list;
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }

  void onTabChanged(int index) {
    selectedTab.value = index;
  }

  Rx<List<String>> ListImages = Rx(
      [
        ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7
      ]
  );

}