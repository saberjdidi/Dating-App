import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/presentation/guide/guide_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:dating_app_bilhalal/presentation/settings_screen/controller/theme_controller.dart';
import '../app_export.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    //Get.put(PrefUtils());
    Get.put(ThemeController());
    //Get.put(ApiClient());
    Get.put(NetworkManager()); //first method
    //Connectivity connectivity = Connectivity();
    //Get.put(NetworkInfo(connectivity)); //second method
    Get.put(BottomBarController());
    Get.put(GuideController());
    //Get.put(MainController());
    //Get.lazyPut(() => MainController(), fenix: true);
    /*
     Get.put(MainController(), permanent: true);
  Get.put(FilterController(), permanent: true);
  Get.put(FavoriteController(), permanent: true);
  Get.put(ProfileController(), permanent: true);
     */
  }
}