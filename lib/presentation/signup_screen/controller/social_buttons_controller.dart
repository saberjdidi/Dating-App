import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/data/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialButtonsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen to authentication state change
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // Save user data to SharedPreferences
  Future<void> saveUserData(String email, String fullName) async {
    await PrefUtils.setEmail(email);
    await PrefUtils.setEmailGoogle(email);
    await PrefUtils.setFullName(fullName);
  }

  // Google Login
  Future<void> loginWithGoogleWithoutFirebase() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
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

  /// Facebook Login
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
  /*
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
  } */

  // Apple Login
  /// Apple authentication
  Future<void> signInWithApple() async {
    try {
      //Start Loading
      //FullScreenLoader.openLoadingDialog('Logging you in...', ImageConstant.lottieTrophy);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        //FullScreenLoader.stopLoading();
        return;
      }


      //Google Authentication
      var userCredentials = await AuthenticationRepository.instance.signInWithApple();
      final user = userCredentials?.user;

      if (user != null) {
        await saveUserData(user.email ?? "", user.displayName ?? "");
        MessageSnackBar.successSnackBar(
          title: "Successfully".tr,
          message: "Sign In with ${user.email}",
          duration: 2,
        );
        Get.offAllNamed(Routes.navigationScreen);
      }
      debugPrint('userCredentials : ${user}');
      //Save User Record
      // await userController.saveUserRecord(userCredentials);

      //Remove Loader
      //FullScreenLoader.stopLoading();

      //Redirect
      //AuthenticationRepository.instance.screenRedirect();
    }
    catch(e){
      //Remove Loader
      //FullScreenLoader.stopLoading();
      debugPrint("Apple Login Error: ${e.toString()}");
      //Show some generic error to the user
      MessageSnackBar.errorSnackBar(title: 'Apple Login Error', message: e.toString());
    }
  }

}