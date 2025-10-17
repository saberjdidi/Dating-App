import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
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
          bio: 'نموذج احترافي',
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

  ///Favorite icon start
  final favorites = <String, bool>{}.obs;

  bool isFavourite(String userId){
    return favorites[userId] ?? false;
  }

  void toggleFavoriteProperty(String userId) {
    if(!favorites.containsKey(userId)){
      favorites[userId] = true;
      saveFavorisProperty(userId);
    }
    else {
      favorites.remove(userId);
      saveFavorisProperty(userId);
      favorites.refresh();
    }
  }

  saveFavorisProperty(idProperty) async {
    try {
      MessageSnackBar.informationToast(
          title: 'Successfully',
          message: "Favoris modifié avec succèss",
          position: SnackPosition.TOP,
          duration: 3);
      /*
      //Start Loading
      FullScreenLoader.openLoadingDialog('Processing your request...', ImageConstant.loading_lottie);

      await apiClient.addToFavoris(token, idProperty)
          .then((response) async {
        debugPrint('response : $response');
        //Remove Loader
        FullScreenLoader.stopLoading();

        if(response['is_add_operation'] == true){
          MessageSnackBar.informationToast(
              title: 'Ajouté aux favoris',
              message: "Propriété ajoutée des favoris avec succès",
              position: SnackPosition.BOTTOM,
              duration: 3);
        } else {
          MessageSnackBar.informationToast(
              title: 'Retiré des favoris',
              message: "Propriété supprimée des favoris avec succès",
              position: SnackPosition.BOTTOM,
              duration: 3);
        }
      })
          .catchError((error, stackTraceUser) {
        debugPrint('Error : ${error.toString()}');
        //Remove Loader
        FullScreenLoader.stopLoading();

        //Show success message
        MessageSnackBar.errorToast(title: 'Erreur', message: error.toString());
      }); */
    }
    catch (e){
      //Remove Loader
      //FullScreenLoader.stopLoading();

      //Show some generic error to the user
      MessageSnackBar.errorSnackBar(title: 'Exception', message: e.toString());
    }
  }
///Favorite icon end

}