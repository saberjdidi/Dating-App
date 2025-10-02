import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialButtonsController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save user data to SharedPreferences
  Future<void> saveUserData(String email, String fullName) async {
    await PrefUtils.setEmail(email);
    await PrefUtils.setEmailGoogle(email);
    await PrefUtils.setFullName(fullName);
  }

  // Google Login
  Future<void> loginWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        debugPrint("Google Login : email : ${account.email} - fullame : ${account.displayName}");
        await saveUserData(account.email, account.displayName ?? '');
        MessageSnackBar.successSnackBar(
            title: "Successfully".tr,
            message: "Sign In with ${account.email}",
            duration: 2);
        Get.offAllNamed(Routes.navigationScreen);
      }
    } catch (e) {
      MessageSnackBar.errorToast(
          title: "Error".tr,
          message: "Google Login Error: $e",
          position: SnackPosition.TOP,
          duration: 2);
      debugPrint("Google Login Error: $e");
    }
  }

  // Facebook Login
  Future<void> signInWithFacebook() async {
    try {
      // Début connexion Facebook
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);

        // Connexion Firebase
        UserCredential userCred = await _auth.signInWithCredential(credential);
        debugPrint("Google Login : email : ${userCred.user?.email} - fullame : ${userCred.user?.displayName}");
        await saveUserData(userCred.user!.email!, userCred.user?.displayName ?? '');
        //await saveUserData(userData['email'], userData['name']);
        Get.offAllNamed(Routes.navigationScreen);
      } else {
        print("Facebook Login failed: ${result.status}");
        return null;
      }
    } catch (e) {
      MessageSnackBar.errorToast(
          title: "Error".tr,
          message: "Facebook Login Error: $e",
          position: SnackPosition.TOP,
          duration: 2);
      print("Facebook Login Error: $e");
    }
  }
  Future<void> loginWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        debugPrint("Google Login : email : ${userData['email']} - fullame : ${userData['name']}");
        await saveUserData(userData['email'], userData['name'] ?? '');
        //await saveUserData(userData['email'], userData['name']);
        Get.offAllNamed(Routes.navigationScreen);
      }
    } catch (e) {
      MessageSnackBar.errorToast(
          title: "Error".tr,
          message: "Facebook Login Error: $e",
          position: SnackPosition.TOP,
          duration: 2);
      debugPrint("Facebook Login Error: $e");
    }
  }
/*
  // Apple Login
  Future<void> loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );
      await saveUserData(credential.email ?? '', credential.givenName ?? '');
      Get.offAllNamed(Routes.navigationScreen);
    } catch (e) {
      debugPrint("Apple Login Error: $e");
    }
  }
  */
}