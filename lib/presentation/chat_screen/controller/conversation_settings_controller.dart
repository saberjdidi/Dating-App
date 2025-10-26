import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/data/models/effective_call_permissions_model.dart';
import 'package:dating_app_bilhalal/data/models/settings_model.dart';
import 'package:dating_app_bilhalal/data/repositories/settings_repository.dart';
import 'package:flutter/foundation.dart';

class ConversationSettingsController extends GetxController {
  static ConversationSettingsController get instance => Get.find();

  final settingsRepository = SettingsRepository();
  final Rx<EffectiveCallPermissionsModel?> effectivePermissions = Rx<EffectiveCallPermissionsModel?>(null);
  final Rx<SettingsModel?> overrideSettings = Rx<SettingsModel?>(null);
  RxBool isDataProcessing = false.obs;

  // Effective permissions (what I can do to them)
  RxBool canCallVideo = false.obs;
  RxBool canCallAudio = false.obs;
  RxBool canSeeOnlineStatus = false.obs;

  // Override permissions (what they can do to me - per user)
  RxBool allowThemCallVideo = false.obs;
  RxBool allowThemCallAudio = false.obs;
  RxBool hideMyOnlineStatus = false.obs;

  String? currentUserId;

  @override
  void onInit() {
    super.onInit();
    // Permissions will be loaded when setUserId is called
  }

  /// Set the target user ID and fetch their effective permissions and overrides
  Future<void> setUserId(String? userId) async {
    if (currentUserId == userId) {
      return;
    }

    currentUserId = userId;
    await Future.wait([
      getEffectivePermissions(),
      getOverridePermissions(),
    ]);
  }

  /// Get effective call permissions for the current conversation
  Future<void> getEffectivePermissions() async {
    if (currentUserId == null) {
      return;
    }

    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      final result = await settingsRepository.getEffectiveCallPermissions(currentUserId!);

      if (result.success && result.data != null) {
        effectivePermissions.value = result.data;

        // Update reactive booleans
        canCallAudio.value = result.data!.effectiveCall?.allowAudio ?? false;
        canCallVideo.value = result.data!.effectiveCall?.allowVideo ?? false;
        canSeeOnlineStatus.value = result.data!.onlineVisibility?.visible ?? false;

      } else {
        MessageSnackBar.errorSnackBar(
          title: 'خطأ',
          message: result.message ?? 'Failed to load permissions'
        );
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(
        title: 'Exception',
        message: e.toString()
      );
    } finally {
      isDataProcessing.value = false;
    }
  }

  /// Fetch override permissions for this specific user
  Future<void> getOverridePermissions() async {
    if (currentUserId == null) {
      return;
    }

    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      final result = await settingsRepository.getCallPermissionOverrides(currentUserId!);

      if (result.success && result.data != null) {
        overrideSettings.value = result.data;

        // Update reactive booleans
        allowThemCallAudio.value = result.data!.allowAudio ?? false;
        allowThemCallVideo.value = result.data!.allowVideo ?? false;
        hideMyOnlineStatus.value = result.data!.hideOnline ?? false;
      } else {
        MessageSnackBar.errorSnackBar(
          title: 'خطأ',
          message: result.message ?? 'Failed to load override permissions'
        );
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(
        title: 'Exception',
        message: e.toString()
      );
    }
  }

  /// Update override permissions for this specific user
  Future<void> updateOverridePermissions() async {
    if (currentUserId == null) {
      debugPrint('⚠️ Cannot update override permissions: userId is null');
      return;
    }

    try {
      FullScreenLoader.openLoadingDialog('We are processing your change', ImageConstant.lottieLoading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MessageSnackBar.customToast(message: 'No Internet Connection');
        FullScreenLoader.stopLoading();
        return;
      }

      final result = await settingsRepository.updateCallPermissionOverrides(
        targetUserId: currentUserId!,
        allowAudio: allowThemCallAudio.value,
        allowVideo: allowThemCallVideo.value,
        hideOnline: hideMyOnlineStatus.value,
      );

      if (result.success && result.data != null) {
        overrideSettings.value = result.data;
        FullScreenLoader.stopLoading();
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
      } else {
        FullScreenLoader.stopLoading();
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      MessageSnackBar.errorSnackBar(title: 'Exception', message: e.toString());
    }
  }

  /// Toggle video call permission for this user
  Future<void> toggleVideoCallForThisUser(bool value) async {
    if (value) {
      final granted = await PermissionsHelper.requestCallPermissions(isVideo: true);
      if (!granted) {
        MessageSnackBar.errorSnackBar(
          title: 'رفض الإذن',
          message: 'يجب تفعيل الكاميرا والمكروفون للمكالمات الفيديو'
        );
        return;
      }
    }

    allowThemCallVideo.value = value;
    await updateOverridePermissions();
  }

  /// Toggle audio call permission for this user
  Future<void> toggleAudioCallForThisUser(bool value) async {
    if (value) {
      final granted = await PermissionsHelper.requestCallPermissions(isVideo: false);
      if (!granted) {
        MessageSnackBar.errorSnackBar(
          title: 'رفض الإذن',
          message: 'يجب تفعيل الميكروفون للمكالمات الصوتية'
        );
        return;
      }
    }

    allowThemCallAudio.value = value;
    await updateOverridePermissions();
  }

  /// Toggle online status visibility for this user
  Future<void> toggleOnlineStatusForThisUser(bool value) async {
    hideMyOnlineStatus.value = value;
    await updateOverridePermissions();
  }

  /// Clear permissions when leaving the conversation
  void clear() {
    currentUserId = null;
    effectivePermissions.value = null;
    overrideSettings.value = null;
    canCallVideo.value = false;
    canCallAudio.value = false;
    canSeeOnlineStatus.value = false;
    allowThemCallVideo.value = false;
    allowThemCallAudio.value = false;
    hideMyOnlineStatus.value = false;
  }
}