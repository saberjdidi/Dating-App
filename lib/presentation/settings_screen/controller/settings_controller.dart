import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/models/settings_model.dart';
import 'package:dating_app_bilhalal/data/repositories/settings_repository.dart';
import 'package:flutter/foundation.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final settingsRepository = SettingsRepository();
  final Rx<SettingsModel?> settingModel = Rx<SettingsModel?>(null);
  RxBool isDataProcessing = false.obs;

  RxBool isCallVideo = true.obs;
  RxBool isCallAudio = true.obs;
  RxBool isInternetOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    initSettings();
  }

  /// 🔹 Chargement initial (API + cache local)
  Future<void> initSettings() async {
    // Charger localement (si pas encore en ligne)
    await _loadPreferences();

    // Charger depuis API
    await getMyPermissions();
  }

  /// 🔹 Charger depuis SharedPreferences
  Future<void> _loadPreferences() async {
    isCallAudio.value = await PrefUtils.getCallVoice();
    isCallVideo.value = await PrefUtils.getCallVideo();
    isInternetOnline.value = await PrefUtils.getHideOnline();
  }

  /// 🔹 Sauvegarder en local
  Future<void> _savePreferences(SettingsModel model) async {
    await PrefUtils.setCallVoice(model.allowAudio ?? false);
    await PrefUtils.setCallVideo(model.allowVideo ?? false);
    await PrefUtils.setHideOnline(model.hideOnline ?? false);
  }

  ///Methods
  /// 🔹 Récupérer les permissions depuis le serveur
  Future<void> getMyPermissions() async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      final result = await settingsRepository.getMyPermissions();

      if (result.success && result.data != null) {
        settingModel.value = result.data;
        isCallAudio.value = result.data!.allowAudio ?? false;
        isCallVideo.value = result.data!.allowVideo ?? false;
        isInternetOnline.value = result.data!.hideOnline ?? false;

        // 🔸 Sauvegarder localement
        await _savePreferences(result.data!);

        debugPrint('✅ Permissions synchronisées depuis API');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'Erreur inconnue');
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'Exception', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  /// 🔹 Mise à jour des permissions serveur + locale
  Future<void> updatePermission() async {
    try {
      FullScreenLoader.openLoadingDialog('We are processing your change', ImageConstant.lottieLoading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MessageSnackBar.customToast(message: 'No Internet Connection');
        //Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      final result = await settingsRepository.updatePermission(
        allowAudio: isCallAudio.value,
        allowVideo: isCallVideo.value,
        hideOnline: isInternetOnline.value,
      );

      if (result.success && result.data != null) {
        settingModel.value = result.data;
        await _savePreferences(result.data!);
        //Remove Loader
        FullScreenLoader.stopLoading();
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
      } else {
        //Remove Loader
        FullScreenLoader.stopLoading();
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      //Remove Loader
      FullScreenLoader.stopLoading();
      MessageSnackBar.errorSnackBar(title: 'Exception', message: e.toString());
    }
  }

  /// 🔹 Basculer Audio en temps réel
  Future<void> toggleCallAudio(bool value) async {
    // Test permission
    if (value) {
      final granted = await PermissionsHelper.requestCallPermissions(isVideo: false);
      if (!granted) {
        MessageSnackBar.errorSnackBar(title: 'رفض الإذن', message: 'يجب تفعيل الميكروفون للمكالمات الصوتية');
        return;
      }
    }

    isCallAudio.value = value; // 🔸 Mettre à jour immédiatement
    await PrefUtils.setCallVoice(value); // Sauvegarde locale
    await updatePermission(); // 🔸 Mise à jour serveur
  }

  /// 🔹 Basculer Vidéo en temps réel
  Future<void> toggleCallVideo(bool value) async {
    if (value) {
      final granted = await PermissionsHelper.requestCallPermissions(isVideo: true);
      if (!granted) {
        MessageSnackBar.errorSnackBar(title: 'رفض الإذن', message: 'يجب تفعيل الكاميرا والمكروفون للمكالمات الفيديو');
        return;
      }
    }

    isCallVideo.value = value;
    await PrefUtils.setCallVideo(value);
    await updatePermission();
  }

  /// 🔹 Basculer statut en ligne
  Future<void> toggleInternetOnline(bool value) async {
    isInternetOnline.value = value;
    await PrefUtils.setHideOnline(value);
    //await PrefUtils.sharedPreferences?.setBool('hide_online', value);
    await updatePermission();
  }

}
