import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/repositories/profile_repository.dart';
import 'package:flutter/foundation.dart';

class ProfileDetailsController extends GetxController {
  static ProfileDetailsController get instance => Get.find();

  UserModel userModel  = Get.arguments['UserModel'] ?? UserModel.empty();
  final profileRepository = ProfileRepository();
  RxBool isDataProcessing = false.obs;

  var showUserInfo = true.obs; // ✅ visible par défaut
  void toggleUserInfo() => showUserInfo.toggle();
  void hideUserInfo() => showUserInfo.value = false;
  void showInfo() => showUserInfo.value = true;

  //Tabbed Page
  var selectedTab = 0.obs;
  void onTabChanged(int index) {
    selectedTab.value = index;
  }
  ///Static list for images in profile message
  Rx<List<String>> ListImages = Rx(
      [
        ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7
      ]
  );

  ///Methods
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
}