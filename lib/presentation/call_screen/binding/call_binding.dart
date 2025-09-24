import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/call_screen/controller/call_controller.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/controller/favorite_controller.dart';

class CallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CallController());
  }
}