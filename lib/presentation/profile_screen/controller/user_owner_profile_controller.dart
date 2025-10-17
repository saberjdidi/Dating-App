import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';

class UserOwnerProfileController extends GetxController {
  static UserOwnerProfileController get instance => Get.find();

  //UserModel userModel  = Get.arguments['UserModel'] ?? UserModel.empty();
  var selectedTab = 0.obs;

  Rx<List<String>> ListImages = Rx(
      [
        ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7
      ]
  );

  void onTabChanged(int index) {
    selectedTab.value = index;
  }
}