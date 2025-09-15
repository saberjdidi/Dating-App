

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/navigation_controller.dart';

/// A binding class for the HomeScreen.
///
/// This class ensures that the HomeController is created when the
/// HomeScreen is first loaded.
class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut(() => BottomBarController());
    Get.lazyPut(() => NavigationController());
  }
}