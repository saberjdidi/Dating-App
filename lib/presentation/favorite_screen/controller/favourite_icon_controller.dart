import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/models/favorite_model.dart';
import 'package:dating_app_bilhalal/data/models/like_user_model.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/repositories/favorite_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/like_repository.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/controller/favorite_controller.dart';
import 'package:flutter/material.dart';

class FavouriteIconController extends GetxController {
  static FavouriteIconController get instance => Get.find();

  final favoriteRepository = FavoriteRepository();
  final likeRepository = LikeRepository();
  RxBool isDataProcessing = false.obs;

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

        // ✅ Supprimer de la liste des likes dans FavoriteController (si présent)
        try {
          final favoriteController = Get.find<FavoriteController>();
          favoriteController.likesUsersList.removeWhere(
                (u) => u.like?.likedUser == userId,
          );
          favoriteController.likesUsersList.refresh();
          debugPrint("🗑️ User $userId supprimé de likesUsersList");
        } catch (e) {
          debugPrint("⚠️ Impossible de trouver FavoriteController : $e");
        }

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