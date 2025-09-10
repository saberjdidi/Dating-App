import 'package:connectivity_plus/connectivity_plus.dart';
import '../app_export.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    //Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    //Get.put(BottomBarController());
    //Get.lazyPut(() => AnnoneController(), fenix: true);
  }
}