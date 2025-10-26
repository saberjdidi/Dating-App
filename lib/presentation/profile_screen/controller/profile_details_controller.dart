import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/models/media_model.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/repositories/media_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/profile_repository.dart';
import 'package:flutter/foundation.dart';

class ProfileDetailsController extends GetxController {
  static ProfileDetailsController get instance => Get.find();

  UserModel userModel  = Get.arguments['UserModel'] ?? UserModel.empty();
  final profileRepository = ProfileRepository();
  RxBool isDataProcessing = false.obs;
  ///Media
  final mediaRepository = MediaRepository();
  RxList<MediaModel> mediaList = <MediaModel>[].obs;

  //Tabbed Page
  var selectedTab = 0.obs;
  void onTabChanged(int index) {
    selectedTab.value = index;
  }
  ///Static list for images in profile message
  Rx<List<String>> ListImages = Rx([ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]);

  @override
  void onInit() {
    super.onInit();
    debugPrint('Id of user onInit : : ${userModel.id ?? ''}');
    //MessageSnackBar.customToast(message: 'Id of user onInit : ${userModel.id ?? ''}');
    getAllMediaByUserId(userModel.id ?? '');
  }
  
  ///Methods
  /// Méthode pour récupérer les médias
  Future<void> getAllMediaByUserId(String userId) async {
    try {
      //MessageSnackBar.customToast(message: 'Id of user is $userId');
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'Pas de connexion Internet');
        return;
      }

      if(userId == null || userId.isEmpty){
        MessageSnackBar.customToast(message: 'Id of user is required');
        return;
      }

      final result = await mediaRepository.getAllMediaByUserId(userId: '2975');
      //final result = await mediaRepository.getAllMediaByUserId(userId: userModel.id ??'');

      if (result.success) {
        mediaList.assignAll(result.data ?? []);
        debugPrint('✅ ${mediaList.length} médias de utilisateur ${userModel.id} chargés');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  Future<void> sendReport() async {
    try {
      isDataProcessing.value = true;
      //FullScreenLoader.openLoadingDialog('Loading...', ImageConstant.lottieLoading);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        isDataProcessing.value = false;
        //Remove Loader
        //FullScreenLoader.stopLoading();
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      final result = await profileRepository.profileReport(id: 1, commentaire: "comment");

      //FullScreenLoader.stopLoading();

      if (result.success) {
        Get.back();
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
        isDataProcessing.value = false;
      } else {
        Get.back();
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'An error occured');
        isDataProcessing.value = false;
      }
    }
    catch (exception) {
      isDataProcessing.value = false;
      debugPrint('Exception : ${exception.toString()}');
      //FullScreenLoader.stopLoading();
      //Show some generic error to the user
      MessageSnackBar.errorSnackBar(title: 'Oh Snap!', message: exception.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  /// Show/Hide user infos Start
  var showUserInfo = true.obs; // ✅ visible par défaut
  void toggleUserInfo() => showUserInfo.toggle();
  void hideUserInfo() => showUserInfo.value = false;
  void showInfo() => showUserInfo.value = true;
/// Show/Hide user infos End
}