import '../../routes/routes.dart';
import '../app_export.dart';

class Logout {
  static void onTapLogout()  async {
    //PrefUtils().clearPreferencesData();
    await PrefUtils.clearEmail();
    await PrefUtils.clearFirstname();
    await PrefUtils.clearLastName();
    await PrefUtils.clearToken();
    await PrefUtils.clearBirthDate();
    Get.offAllNamed(Routes.signInScreen);
  }
}