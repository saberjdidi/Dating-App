import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  //UserModel userModel  = Get.arguments['UserModel'] ?? UserModel.empty();
RxBool isCallVideo = true.obs;
RxBool isCallVoice = true.obs;
RxBool isInternetConnection = true.obs;

}