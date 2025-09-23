import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import '../app_export.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    //Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    Get.put(BottomBarController());
    //Get.put(MainController());
    //Get.lazyPut(() => MainController(), fenix: true);
  }
}