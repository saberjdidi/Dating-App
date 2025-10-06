
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/logger.dart';
import 'package:flutter/foundation.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  var email = PrefUtils.getEmail();
  var firstName = PrefUtils.getFirstname() ?? 'Saber';
  var lastName = PrefUtils.getLastName() ?? 'Jdidi';

  RxInt selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
  //final apiClient = Get.find<ApiClient>();
  final token = PrefUtils.getToken();

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.search:
        return Routes.filterScreen;
      case BottomBarEnum.discussion:
        return Routes.chatScreen;
      case BottomBarEnum.main:
        return Routes.mainScreen;
      case BottomBarEnum.favoris:
        return Routes.favoriteScreen;
      case BottomBarEnum.Profile:
        return Routes.profileScreen;
      default: return "/";
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

}