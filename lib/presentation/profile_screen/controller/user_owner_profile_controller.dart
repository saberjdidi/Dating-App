import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/data/models/media_model.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/repositories/media_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/profile_repository.dart';
import 'package:flutter/foundation.dart';

class UserOwnerProfileController extends GetxController {
  static UserOwnerProfileController get instance => Get.find();

  //UserModel userModel  = Get.arguments['UserModel'] ?? UserModel.empty();
  final profileRepository = ProfileRepository();
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  RxList<InterestModel> hobbiesList = <InterestModel>[].obs;
  RxBool isDataProcessing = false.obs;

  ///Media
  final mediaRepository = MediaRepository();
  RxList<MediaModel> mediaList = <MediaModel>[].obs;
  //Rx<List<String>> ListImages = Rx([ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]);

  var selectedTab = 0.obs;
  void onTabChanged(int index) {
    selectedTab.value = index;
  }


  @override
  void onInit() {
    super.onInit();
    getMyProfile();
    getAllMedia();
    getMyHobbies();
  }

  ///Methods
  Future<void> getMyProfile() async {
    try {
      isDataProcessing.value = true;

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      final result = await profileRepository.myProfile();

      if (result.success) {
        user.value = result.data;
        //debugPrint('data login : ${user.value!.email} - ${user.value!.username} - ${user.value!.height} - ${user.value!.weight}');
        ///MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
        isDataProcessing.value = false;
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'An error occured');
        isDataProcessing.value = false;
      }
    }
    catch (exception) {
      isDataProcessing.value = false;
      debugPrint('Exception : ${exception.toString()}');
      MessageSnackBar.errorSnackBar(title: 'Oh Snap!', message: exception.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  /// Méthode pour récupérer les médias
  Future<void> getAllMedia() async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'Pas de connexion Internet');
        return;
      }

      final result = await mediaRepository.getAllMedia();

      if (result.success) {
        mediaList.assignAll(result.data ?? []);
        debugPrint('✅ ${mediaList.length} médias chargés');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  /// Méthode pour récupérer les interets
  Future<void> getMyHobbies() async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'Pas de connexion Internet');
        return;
      }

      final result = await profileRepository.getMyHobbies();

      if (result.success) {
        hobbiesList.assignAll(result.data ?? []);
        debugPrint('✅ ${mediaList.length} hobbies chargés');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }
}