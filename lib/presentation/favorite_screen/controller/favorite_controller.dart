import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/models/favorite_model.dart';
import 'package:dating_app_bilhalal/data/models/like_user_model.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/repositories/favorite_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/like_repository.dart';
import 'package:flutter/material.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  final favoriteRepository = FavoriteRepository();
  final likeRepository = LikeRepository();

  RxList<FavoriteModel> favoritesMediaList = <FavoriteModel>[].obs;
  RxList<LikeUserModel> likesUsersList = <LikeUserModel>[].obs;
  RxList<LikeUserModel> usersLikeMeList = <LikeUserModel>[].obs;
  RxBool isDataProcessing = false.obs;
  var isDataProcessingFavouritesLikeMe = false.obs;
  var isDataProcessingFavouritesLikeUser = false.obs;
  void onTabChanged(int index) {
    selectedTab.value = index;
  }

  var searchText = "".obs;
  final TextEditingController searchController = TextEditingController();
  var selectedTab = 0.obs;
  var favorisUsers = <UserModel>[].obs;

  /*
  @override
  void onInit() {
    getLikesUsers();
    getUsersLikeMe();
    getMediaFavorites();
  }
  */

  @override
  void onReady() {
    super.onReady();
    getLikesUsers();
    getUsersLikeMe();
    getMediaFavorites();
  }

  void refreshData() {
    getLikesUsers();
    getUsersLikeMe();
    getMediaFavorites();
  }

  @override
  void onResume() {
    refreshData();
  }

  ///Likes Users Start
  final favorites = <String, bool>{}.obs;
  /// ✅ Chargement du statut initial du user (favori ou pas)
  Future<void> loadFavoriteStatus(String userId) async {
    if (favorites.containsKey(userId)) return; // déjà chargé une fois

    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet connexion');
        favorites[userId] = false;
      }
      final result = await likeRepository.getStatusLikeUser(userId);
      if (result.success) {
        bool isLiked = result.data?['liked'] ?? false;
        favorites[userId] = isLiked;
      } else {
        favorites[userId] = false;
      }
    } catch (e) {
      favorites[userId] = false;
      debugPrint("Error loadFavoriteStatus : $e");
    }
  }

  bool isFavourite(String userId) => favorites[userId] ?? false;

  /// ✅ Basculer le statut favori d’un user
  Future<void> toggleFavorite(String userId) async {
    bool current = favorites[userId] ?? false;
    //favorites[userId] = !current; // changement visuel immédiat

    try {
      if (!current) {
        // Ajouter aux favoris
        final result = await addUserToFavorite(userId);
       if (result) {
         favorites[userId] = true;
         favorites.refresh();
       }
        //final result = await likeRepository.addUserToFavorite(userId);
        //if (!result.success) throw result.message ?? "Erreur ajout favori";
      } else {
        // Retirer des favoris
        final result = await deleteUserFromFavorite(userId);
        if (result) {
          favorites[userId] = false;
          favorites.refresh();
        }
        //final result = await likeRepository.deleteUserFromFavorite(userId);
        //if (!result.success) throw result.message ?? "Erreur suppression favori";
      }
    } catch (e) {
      // rollback visuel si erreur
      //favorites[userId] = current;
      MessageSnackBar.errorSnackBar(title: "Erreur", message: e.toString());
    } finally {
      //favorites.refresh();
    }
  }

  Future<bool> addUserToFavorite(String userId) async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet connexion');
        return false;
      }

      final result = await likeRepository.addUserToFavorite(userId);

      if (result.success) {
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
        var currentUserId = result.data?['user_id'];
        var likedUserId = result.data?['liked_user'];
        var likedAt = result.data?['liked_at'];
        debugPrint('currentUserId : $currentUserId - likedUserId : $likedUserId - likedAt : $likedAt');
        return true;
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
        return false;
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
      return false;
    }
  }

  Future<bool> deleteUserFromFavorite(String userId) async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet connexion');
        return false;
      }

      final result = await likeRepository.deleteUserFromFavorite(userId);

      if (result.success) {
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
        var currentUserId = result.data?['user_id'];
        var likedUserId = result.data?['liked_user'];
        var likedAt = result.data?['liked_at'];
        debugPrint('currentUserId : $currentUserId - likedUserId : $likedUserId - likedAt : $likedAt');
        return true;
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
        return false;
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
      return false;
    }
  }

  Future<void> getLikesUsers() async {
    try {
      isDataProcessingFavouritesLikeUser.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessingFavouritesLikeUser.value = false;
        MessageSnackBar.customToast(message: 'No Internet connexion');
        return;
      }

      final result = await likeRepository.getLikesUsers();

      if (result.success) {
        isDataProcessingFavouritesLikeUser.value = false;
        likesUsersList.assignAll(result.data ?? []);
        debugPrint('✅ ${likesUsersList.length} likes users chargés');
      } else {
        isDataProcessingFavouritesLikeUser.value = false;
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      isDataProcessingFavouritesLikeUser.value = false;
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessingFavouritesLikeUser.value = false;
    }
  }

  Future<void> getUsersLikeMe() async {
    try {
      isDataProcessingFavouritesLikeMe.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessingFavouritesLikeMe.value = false;
        MessageSnackBar.customToast(message: 'No Internet connexion');
        return;
      }

      final result = await likeRepository.getUsersLikeMe();

      if (result.success) {
        isDataProcessingFavouritesLikeMe.value = false;
        usersLikeMeList.assignAll(result.data ?? []);
        debugPrint('✅ ${usersLikeMeList.length} users likes me chargés');
      } else {
        isDataProcessingFavouritesLikeMe.value = false;
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      isDataProcessingFavouritesLikeMe.value = false;
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessingFavouritesLikeMe.value = false;
    }
  }

  /*
   Future<bool> getStatusLikeUser(String userId) async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet connexion');
        return false;
      }

      final result = await likeRepository.getStatusLikeUser(userId);

      if (result.success) {
        var liked = result.data?['liked'];
       bool isLikeUser = liked != null ? liked : false;
        debugPrint('liked user : $liked');
        return isLikeUser;
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
        return false;
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
      return false;
    } finally {
      isDataProcessing.value = false;
    }
  }
   */
  ///Like User End

  Future<void> getMediaFavorites() async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet connexion');
        return;
      }

      final result = await favoriteRepository.getMediasFavorites();

      if (result.success) {
        favoritesMediaList.assignAll(result.data ?? []);
        debugPrint('✅ ${favoritesMediaList.length} media favorites chargés');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  List<LikeUserModel> get filteredFavorisUsers {
    var list = likesUsersList.where((item) {
      if (searchText.isNotEmpty &&
          !item.target!.username!.toLowerCase().contains(searchText.value.toLowerCase())
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

  Rx<List<String>> ListImages = Rx(
      [
        ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7
      ]
  );

  ///Favorite icon start
  final favoritess = <String, bool>{}.obs;

  bool isFavorite(String userId){
    return favoritess[userId] ?? false;
  }

  void toggleFavoriteProperty(String userId) {
    if(!favoritess.containsKey(userId)){
      favoritess[userId] = true;
      saveFavorisProperty(userId);
    }
    else {
      favoritess.remove(userId);
      saveFavorisProperty(userId);
      favoritess.refresh();
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