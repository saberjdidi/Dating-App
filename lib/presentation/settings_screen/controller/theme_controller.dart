import 'package:dating_app_bilhalal/core/app_export.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Lire la valeur sauvegardée (getTheme renvoie 'light' si rien)
    isDark.value = PrefUtils.getTheme() == 'dark';
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    PrefUtils.setTheme(isDark.value ? 'dark' : 'light');
    Get.changeTheme(isDark.value ? ThemeHelper().getDarkTheme() : ThemeHelper().getLightTheme());
  }
}