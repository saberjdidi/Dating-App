import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/controller/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());
  }
}