import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../routes/routes.dart';
import '../app_export.dart';

class Logout {
  static void onTapLogout()  async {
    //google signout
    //final GoogleSignIn _googleSignIn = GoogleSignIn();
    //await _googleSignIn.signOut();
    await PrefUtils.clearEmail();
    await PrefUtils.clearToken();
    await PrefUtils.clearId();
    await PrefUtils.clearUsername();
    //await PrefUtils.clearFirstname();
    //await PrefUtils.clearLastName();
    //await PrefUtils.clearFullName();
    //await PrefUtils.clearToken();

    //set index with 2 to go to mainscreen
    //BottomBarController.instance.selectedIndex.value = 0;
    Get.offAllNamed(Routes.signInScreen);
  }
}