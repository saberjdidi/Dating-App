import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 5000), (){
      Get.offAllNamed(Routes.navigationScreen);
    });
  }
}