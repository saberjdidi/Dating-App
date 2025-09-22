import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();
//UserModel userModel  = Get.arguments['UserModel'] ?? UserModel.empty();

  RxBool isCallVideo = true.obs;
  RxBool isCallVoice = true.obs;
  RxBool isInternetConnection = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    isCallVoice.value = await PrefUtils.getCallVoice();
    isCallVideo.value = await PrefUtils.getCallVideo();
  }

  Future<void> toggleCallVoice(bool value) async {
    if (value) {
      final granted = await PermissionsHelper.requestCallPermissions(isVideo: false);
      if (!granted) {
        Get.snackbar("Permission refusée", "Activez le micro pour les appels vocaux");
        return;
      }
    }
    isCallVoice.value = value;
    await PrefUtils.setCallVoice(value);
  }

  Future<void> toggleCallVideo(bool value) async {
    if (value) {
      final granted = await PermissionsHelper.requestCallPermissions(isVideo: true);
      if (!granted) {
        Get.snackbar("Permission refusée", "Activez la caméra et le micro pour les appels vidéo");
        return;
      }
    }
    isCallVideo.value = value;
    await PrefUtils.setCallVideo(value);
  }


}