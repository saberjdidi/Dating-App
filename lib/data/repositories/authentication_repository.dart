import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:dating_app_bilhalal/core/utils/exceptions/firebase_exceptions.dart';
import 'package:dating_app_bilhalal/core/utils/exceptions/format_exceptions.dart';
import 'package:dating_app_bilhalal/core/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///Variables
  //final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  ///Get authenticated user data
  User? get authUser => _auth.currentUser;

  /*
  ///Called from main.dart on app launch
  @override
  void onReady() {
    //Redirect to the appropriate screen
    screenRedirect();
  }

  ///Function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if(user != null){
      if(user.emailVerified){

        //Initialize user specific storage
        await TLocalStorage.init(user.uid);

        Get.offAll(() => const NavigationMenuWidget());
      }
      else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    }
    else {
      ///First Method using GetStorage()
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
      ///Second Method using SharedPreference
      /* await PrefUtils.getIsBoarding() == "true"
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen()); */
    }

  } */

  /* --------------------------------  Email & Password Sign-in   --------------------------------------- */
  ///[EmailAuthentication] - SignIn
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailAuthentication] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[ReAuthenticate] - RE AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      //Create credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      //ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /* --------------------------------  Federated identity & Social Sign-in   --------------------------------------- */
  ///[GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //Create a new credential
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //Once Signed in, return the user credentials
      return await _auth.signInWithCredential(credentials);
    }
   /* on FirebaseAuthException catch (e){
      debugPrint("Google Login Error: ${e.toString()}");
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      debugPrint("Google Login Error: ${e.toString()}");
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      debugPrint("Google Login Error: ${e.toString()}");
      throw TPlatformException(e.code).message;
    } */
    catch (e) {
      debugPrint("Google Login Error: ${e.toString()}");
      if(kDebugMode) print('Something went wrong : $e');
      return null;
      //throw 'Something went wrong. Please try again';
    }
  }

  ///[AppleAuthentication] - APPLE
  Future<UserCredential?> signInWithApple() async {
    try {
      //obtain the auth details from the request
      //if connect with android
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'apple.com', // Your Apple Service ID
          //clientId: 'your.service.id', // Your Apple Service ID
          redirectUri: Uri.parse('https://your.domain.com/callbacks/sign_in_with_apple'), // Your redirect URI
        ),
      );
      //if connect with ios
     /* final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      ); */

      debugPrint("appleCredential : $appleCredential");

      //Create a new credential
      final credentials = OAuthProvider('apple.com').credential(
          accessToken: appleCredential.authorizationCode,
          idToken: appleCredential.identityToken
      );

      //Once Signed in, return the user credentials
      return await _auth.signInWithCredential(credentials);
    } catch (e) {
      MessageSnackBar.errorToast(
          title: "Error".tr,
          message: "Apple Login Error: $e",
          position: SnackPosition.TOP,
          duration: 2);
      debugPrint("Apple Login Error: $e");
      return null;
    }
  }

  ///[logoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      await PrefUtils.clearEmail();
      //await PrefUtils.clearFirstname();
      //await PrefUtils.clearLastName();
      await PrefUtils.clearFullName();
      //await PrefUtils.clearToken();
      Get.offAllNamed(Routes.signInScreen);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}