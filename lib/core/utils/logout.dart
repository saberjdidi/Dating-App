import 'package:google_sign_in/google_sign_in.dart';
import '../../routes/routes.dart';
import '../app_export.dart';

class Logout {
  static void onTapLogout()  async {
    //google signout
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();

    await PrefUtils.clearEmail();
    //await PrefUtils.clearFirstname();
    //await PrefUtils.clearLastName();
    await PrefUtils.clearFullName();
    //await PrefUtils.clearToken();
    Get.offAllNamed(Routes.signInScreen);
  }
}