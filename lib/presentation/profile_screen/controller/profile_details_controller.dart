import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';

class ProfileDetailsController extends GetxController {
  static ProfileDetailsController get instance => Get.find();

  UserModel userModel  = Get.arguments['UserModel'] ?? UserModel.empty();

  var showUserInfo = true.obs; // ✅ visible par défaut
  void toggleUserInfo() => showUserInfo.toggle();
  void hideUserInfo() => showUserInfo.value = false;
  void showInfo() => showUserInfo.value = true;
}