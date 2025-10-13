# dating_app_bilhalal

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## show iconsax: https://iconsax-icon-list.netlify.app/
## Generate image (Android + iOS): https://www.appicon.co/

## Splash Screen 
https://pub.dev/packages/flutter_launcher_icons

## 1. image_picker : configuration in Android and iOS

## 2 image splash screen => supprimer une

## 3. ajouter ces configuration in info.plist pour video_player
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>


## problem showDialog et showModalBottomSheet pour Tablet => modifier par ce package: modal_bottom_sheet 

## flutter_native_splash: ^2.4.0
dart run flutter_native_splash:create --path=splash.yaml

dimension Android:
hdpi 192X192,
xhdpi 288X288,
xxhdpi 384X384,
xxxhdpi 1024X1024

create mode 100644 ios/Runner/Assets.xcassets/LaunchBackground.imageset/Contents.json
create mode 100644 ios/Runner/Assets.xcassets/LaunchBackground.imageset/background.png
create mode 100644 ios/Runner/Assets.xcassets/LaunchBackground.imageset/darkbackground.png
create mode 100644 ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImageDark.png
create mode 100644 ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImageDark@2x.png
create mode 100644 ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImageD

## Guide renommer label name et le package name (namespace) de l'application
1️⃣ Renommer le label de l’application
Android

Dans android/app/src/main/AndroidManifest.xml :

<application
android:label="BilHalal Dating"   <!-- 👈 nouveau nom -->
android:name="${applicationName}"
android:icon="@mipmap/ic_launcher">
</application>

iOS

Dans ios/Runner/Info.plist :

<key>CFBundleName</key>
<string>BilHalal Dating</string> <!-- 👈 nouveau nom -->

2️⃣ Changer le package name (namespace)

Supposons que tu veux remplacer :
com.example.dating_app_bilhalal ➝ com.bilhalal.dating

Android

Ouvre android/app/build.gradle et mets à jour :

namespace "com.bilhalal.dating"
defaultConfig {
applicationId "com.bilhalal.dating"
}


Vérifie dans android/app/src/main/AndroidManifest.xml que ça correspond :

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="com.bilhalal.dating">


⚠️ Tu devras aussi renommer le dossier Java/Kotlin :

android/app/src/main/java/com/example/dating_app_bilhalal


en

android/app/src/main/java/com/bilhalal/dating


Et mettre à jour le package en haut du fichier MainActivity.kt :

package com.bilhalal.dating

iOS (Bundle Identifier)

Ouvre ios/Runner.xcodeproj ou ios/Runner.xcworkspace dans Xcode.

Sélectionne le projet Runner > onglet Runner target > General.

Dans Identity → change Bundle Identifier :

com.bilhalal.dating


Vérifie aussi dans ios/Runner/Info.plist :

<key>CFBundleIdentifier</key>
<string>com.bilhalal.dating</string>

## Google Sign-in
Command for genrating keystore file for Mac/Linux:-
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias {your alias name}

Command for genrating keystore file for Window-
cmd > keytool -genkey -v -keystore upload-bilhalal.jks -alias bilhalal -keyalg RSA -keysize 2048 -validity 10000
or use cmd> keytool -genkey -v -keystore %userprofile%\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias {your alias name}
commande generate by google > keytool -keystore path-to-debug-or-production-keystore -list -v

Command to get SHA1 key:-
keytool -list -v -keystore {path-to-keystore}
## android/app > keytool -list -v -keystore upload-bilhalal.jks


C:\Users\saber.jdidi\StudioProjects\dating_app_bilhalal\android\app>keytool -list -v -keystore upload-bilhalal.jks
Entrez le mot de passe du fichier de clés :

Type de fichier de clés : PKCS12
Fournisseur de fichier de clés : SUN

Votre fichier de clés d'accès contient 1 entrée

Nom d'alias : bilhalal
Empreintes du certificat :
MD5 : C9:B0:ED:AF:69:A9:41:A9:00:3C:DD:A5:5F:65:85:35:7F:21:F1:5D
SHA1 : 82:26:48:61:FD:29:32:5B:39:61:9B:87:EC:BA:FB:36:CB:6A:04:73:67:44:3E:EF:D4:06:C0:28:D9:AB:62:B4
SHA256 : SHA256withRSA
Nom de l'algorithme de signature : Clé RSA 2048 bits
*******************************************
Serial number: 804c17851a554248
Valid from: Wed Oct 01 20:12:49 CEST 2025 until: Sun Feb 16 19:12:49 CET 2053
Certificate fingerprints:
SHA1: 2E:5C:8D:68:00:C5:6F:41:D7:C9:05:67:FF:50:D6:92:61:56:83:60
SHA256: 96:E0:CA:29:6C:66:0F:36:E3:20:32:94:1C:51:EC:F5:52:0A:81:65:B6:09:D2:95:23:AF:DD:3D:FB:2E:9D:31
Signature algorithm name: SHA384withRSA
Subject Public Key Algorithm: 2048-bit RSA key
*******************
Certificate fingerprints:
SHA1: 01:8E:EE:7F:07:A1:E6:09:F4:35:8B:AF:65:7E:FB:3A:47:A7:46:87
SHA256: FD:01:FA:E8:E4:05:2E:E4:8F:9B:F7:DD:43:5A:6F:E6:11:45:D1:DD:BC:2E:17:51:2B:47:A3:7B:7F:B7:DB:AA
Signature algorithm name: SHA384withRSA
*******************************************
## ajouter SHA1 to credentiels pour créer idclient: 
## *******************ID CLIENT**** : 437512375831-082v2fchi8ftqgnp44q5aql8q7vs89nk.apps.googleusercontent.com

Client OAuth créé: https://console.cloud.google.com/apis/credentials?project=bilhalal-dating

## configuration android : 
1. drag and drop the file upload-bilhalal.jks in  android/app/
2. Ajouter signingConfigs to android/app/build.gradle: 
     signingConfigs {
        release {
            keyAlias 'bilhalal'
            keyPassword 'saber1992'
            storePassword 'saber1992'
            storeFile file('upload-bilhalal.jks')
        }

        debug {
            storeFile file('upload-bilhalal.jks')
            keyAlias 'bilhalal'
            keyPassword 'saber1992'
            storePassword 'saber1992'
        }
   }

## Configuration Google Sign-in on iOS: 
1. Créer le client OAuth pour iOS
2. Modification in Info.plist
info.plist: 
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLSchemes</key>
<array>
<!-- Met l’ID client iOS récupéré de Google Cloud -->
<string>com.googleusercontent.apps.YOUR_CLIENT_ID</string>
</array>
</dict>
</array>

<key>GIDClientID</key>
<string>YOUR_IOS_CLIENT_ID.apps.googleusercontent.com</string>

<key>LSApplicationQueriesSchemes</key>
<array>
<string>google</string>
<string>com.googleusercontent.apps.YOUR_CLIENT_ID</string>
</array>

## Firebase + Google Sign-in
Étape 1 : Générer les empreintes SHA correctement

Si ta commande avec keytool ne marche pas, c’est souvent parce que :

tu n’as pas Java JDK installé ou pas dans le PATH

ou que tu es sous Windows et la commande %USERPROFILE% ne marche pas comme prévu

👉 Voici les bonnes commandes selon ton OS :

Sous Windows (PowerShell ou CMD) :
keytool -list -v -alias androiddebugkey -keystore "%USERPROFILE%\.android\debug.keystore" -storepass android -keypass android

Sous Mac/Linux :
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android


⚠️ storepass et keypass par défaut sont android (sauf si tu as créé un keystore custom).

C:\Users\LENOVO\StudioProjects\Dating-App>keytool -list -v -alias androiddebugkey -keystore "%USERPROFILE%\.android\debug.keystore" -storepass android -keypass android
Alias name: androiddebugkey

Certificate fingerprints:
SHA1: 17:DA:D7:61:D6:4C:E7:A6:81:B7:E4:A8:CF:08:62:70:FC:BC:CE:87
SHA256: 50:E0:51:D1:E2:BF:FB:D4:71:67:F0:A1:F3:32:BD:E7:3B:F8:AC:B4:72:67:41:FF:DE:D5:E0:93:B8:05:24:D1
Signature algorithm name: SHA1withRSA (weak)


🚨 la version Release

Pour la publication en PlayStore, tu dois aussi ajouter le SHA1/SHA256 du keystore release :

keytool -list -v -keystore my-release-key.jks -alias my-key-alias

## Firebase configuration
### Méthode 1
1. create project firebase
2. Préparer votre espace de travail
   Le plus simple pour vous aider à démarrer est d'utiliser la CLI FlutterFire.

Avant de continuer, veillez à :

Installez la CLI Firebase et connectez-vous (exécutez firebase login)
installer le SDK Flutter ;
créer un projet Flutter (exécuter flutter create).

3. Installer et exécuter la CLI FlutterFire
   Depuis n'importe quel répertoire, exécutez cette commande :

dart pub global activate flutterfire_cli
Ensuite, à la racine du répertoire de votre projet Flutter, exécutez cette commande :

flutterfire configure --project=bilhalaldatingapp => cmd : C:\Users\saber.jdidi\StudioProjects\dating_app_bilhalal>flutterfire configure

Cela enregistre automatiquement vos applications par plate-forme auprès de Firebase et ajoute un fichier de configuration lib/firebase_options.dart à votre projet Flutter.

4. Initialiser Firebase et ajouter des plug-ins
   Pour initialiser Firebase, appelez Firebase.initializeApp à partir du package firebase_core avec la configuration de votre nouveau fichier firebase_options.dart :

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

## Méthode 2
1. Ajouter Firebase à votre application Apple
télécharger GoogleService-Info.plist puis placer dans ios/Runner/GoogleService-Info.plist
2. Ajouter Firebase à votre application Android
télécharger google-services.json puis placer dans android/app/google-services.json
id("com.google.gms.google-services") version "4.4.3" apply false

plugins {
id("com.android.application")

// Add the Google services Gradle plugin
id("com.google.gms.google-services")

...
}

dependencies {
// Import the Firebase BoM
implementation(platform("com.google.firebase:firebase-bom:34.3.0"))


// TODO: Add the dependencies for Firebase products you want to use
// When using the BoM, don't specify versions in Firebase dependencies
// https://firebase.google.com/docs/android/setup#available-libraries
}


## How to get the SHA-1 fingerprint certificate in Android Studio for debug mode? 
dating_app_bilhalal/android cmd>        ./gradlew signingReport

## WebSocket: 
https://www.youtube.com/watch?v=YS0NfnRCtCg&list=PLCQvK2R5a8CLDC98o9xdVF9Uktqs0M82d&index=6

## Facebook Auth
https://www.youtube.com/watch?v=Hj0csDW6WUs
https://www.youtube.com/watch?v=jbNhiQRugPI
https://www.youtube.com/watch?v=8MQf2kAU3GA
https://www.youtube.com/watch?v=sOa9xJuJDII

1. https://developers.facebook.com/apps/1330583908717882/settings/basic/
   Application: Dating App Bilhalal
   Identifiant de l’application : 1330583908717882
   Clé secrète : a8b94364be548f17a4a24a591fbd3431
   token client: 5874447de2422b0d178dc388bae5a651

2. Firebase: activer facebook
   https://dating-app-bilhalal.firebaseapp.com/__/auth/handler

3. configuration android: https://developers.facebook.com/apps/1330583908717882/use_cases/customize/?use_case_enum=FB_LOGIN&selected_tab=quickstart&product_route=fb-login
   👉 Pour générer la debug key hash - Création d’une clé de hachage de développement :

   keytool -exportcert -alias androiddebugkey -keystore "C:\Users\USERNAME\.android\debug.keystore" | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" sha1 -binary | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" base64
   C:\Users\LENOVO>keytool -exportcert -alias androiddebugkey -keystore "%USERPROFILE%\.android\debug.keystore" -storepass android | openssl sha1 -binary | openssl base64
   izpgQ+bXvAYb+Yx5lnwr2n8By1k=
   ieDm1CpwQ5k3uRV2u/2BqvXtliE=

   👉 Pour générer la release key hash - Création d’une clé de hachage de publication :
   keytool -exportcert -alias YOUR_RELEASE_KEY_ALIAS -keystore YOUR_RELEASE_KEY_PATH | openssl sha1 -binary | openssl base64
   keytool -exportcert -alias YOUR_RELEASE_ALIAS -keystore YOUR_RELEASE_KEY_PATH | openssl sha1 -binary | openssl base64

https://developers.facebook.com/apps/1330583908717882/use_cases/customize/?use_case_enum=APP_INSTALL_ADS_APP_EVENTS&selected_tab=quickstart&product_route=analytics
4. site pour générer Clés de hachage 👉 https://tomeko.net/online_tools/hex_to_base64.php?lang=en
 ce site remplace keytool, 
donne le code SHA-1 : 17:da:d7:61:d6:4c:e7:a6:81:b7:e4:a8:cf:08:62:70:fc:bc:ce:87
Clés de hachage : F9rXYdZM56aBt+SozwhicPy8zoc=

## Android :
dependencies {
implementation 'com.facebook.android:facebook-android-sdk:[4,5)'
}

strings.xml:
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="facebook_app_id">1234</string>
    <string name="fb_login_protocol_scheme">fb1234</string>
    <string name="facebook_client_token">56789</string>
</resources>

configuration AndroidManifest.xml

✅ Rappel : pourquoi ce key hash ?

Facebook Android attend un key hash (base64), généré à partir du SHA-1 du certificat utilisé pour signer l’APK. Tu dois ajouter chaque key hash utilisée (debug, release, upload) dans la console Facebook → Settings > Basic → Android → Key Hashes.

Commandes utiles
1) Sur macOS / Linux (avec keytool et openssl)

debug keystore :

keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64


release / upload keystore (remplace upload-bilhalal.jks et alias/storepass):

keytool -exportcert -alias <your_alias> -keystore path/to/upload-bilhalal.jks -storepass <storepass> | openssl sha1 -binary | openssl base64


Remplace les mots de passe/alias par les tiens.

2) Sur Windows (PowerShell) — si openssl n'est pas disponible

Récupère le SHA-1 hex (exemple pour debug keystore) :

$keytool = "C:\Program Files\Java\jdk...\bin\keytool.exe"
& $keytool -list -v -alias androiddebugkey -keystore $env:USERPROFILE + "\.android\debug.keystore" -storepass android | Select-String "SHA1"


Tu obtiendras une ligne SHA1: AA:BB:CC:....

Convertir le SHA-1 hex en base64 (PowerShell 7+ : FromHexString), si tu as la chaîne hex (sans :) :

$sha = "AA:BB:CC:...".Replace(":", "")
[Convert]::ToBase64String([System.Convert]::FromHexString($sha))


(Si tu es sur Windows + Git Bash / WSL, mieux d’utiliser la commande openssl Mac/Linux ci-dessus.)

3) Méthode alternative si tu n’as pas openssl / PowerShell helper

Fais keytool -list -v ... → copie le SHA-1 (hex, avec :).

Va sur le site que tu as cité (ou tout autre convertisseur hex → base64) : entre le SHA-1 sans les :, convertis en base64 et colles ce résultat dans Facebook.

## Apple sign-in
https://www.youtube.com/watch?v=JEwGol44xFQ
activer le fournisseur Apple dans Firebase

NB: swipe user card automatic after 10 secondes 
support email screen : upload juste one file


## immersive mode => for Android device : https://www.youtube.com/watch?v=X_hQijCqaKA

## integration API
Parfait — je te donne une solution professionnelle, structurée et prête à l’emploi (GetX + Dio) pour consommer tes API register / login proprement, avec gestion d’erreur, constantes centralisées, modèles de réponse, repository, ApiClient et exemples d’utilisation dans tes controllers (signup + signin).
Tu pourras l’adapter facilement à d’autres endpoints.

Je fournis :

constants.dart — base URL + endpoints + codes HTTP

api_client.dart — client Dio réutilisable + interception / timeout / log

models — réponse d’auth (minimal)

auth_repository.dart — couche d’accès aux API

modifications dans SignUpWithEmailController et SignInController pour consommer la repo

suggestion InitialBindings pour injecter le repo

bonnes pratiques (gestion d’erreur utilisateur / messages / loader)

Remarque : j’utilise Dio (très utilisé en prod). Si tu préfères http, dis-le et je fournis l’équivalent.

1) lib/core/constants.dart
   // lib/core/constants.dart
   class ApiConstants {
   // Base URL centralisée
   static const String baseUrl = 'http://164.92.138.66/api/v1/app/';

// Endpoints (relatif à baseUrl)
static const String authRegister = 'auth/register';
static const String authLogin = 'auth/login';
// ajouter les autres endpoints ici...
}

class HttpStatusCode {
static const int ok = 200;
static const int created = 201;
static const int unauthorized = 401;
static const int badRequest = 400;
static const int internalServerError = 500;
}

2) lib/data/api/api_client.dart
   // lib/data/api/api_client.dart
   import 'package:dio/dio.dart';
   import 'package:flutter/foundation.dart';
   import '../../core/constants.dart';

class ApiClient {
static final ApiClient _instance = ApiClient._internal();
factory ApiClient() => _instance;

late final Dio dio;

ApiClient._internal() {
BaseOptions options = BaseOptions(
baseUrl: ApiConstants.baseUrl,
connectTimeout: const Duration(seconds: 15),
receiveTimeout: const Duration(seconds: 15),
headers: {
'Accept': 'application/json',
'Content-Type': 'application/json',
},
);

    dio = Dio(options);

    // Logging interceptor (debug only)
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ));
    }

    // Optional: add token interceptor later
    // dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async { ... }));
}

Future<Response> post(String path, {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters, Options? options}) async {
return await dio.post(path, data: data, queryParameters: queryParameters, options: options);
}

Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
return await dio.get(path, queryParameters: queryParameters, options: options);
}

// Ajoute patch/put/delete si besoin...
}

3) lib/data/models/auth_response.dart
   // lib/data/models/auth_response.dart
   class AuthData {
   final String? email;
   final String? token; // si le backend renvoie token, sinon null

AuthData({this.email, this.token});

factory AuthData.fromJson(Map<String, dynamic> json) {
return AuthData(
email: json['email'] as String?,
token: json['token'] as String?,
);
}
}

class ApiResult<T> {
final bool success;
final String? message;
final T? data;

ApiResult({required this.success, this.message, this.data});
}

4) lib/data/repositories/auth_repository.dart
   // lib/data/repositories/auth_repository.dart
   import 'package:dio/dio.dart';
   import '../api/api_client.dart';
   import '../../core/constants.dart';
   import '../models/auth_response.dart';

class AuthRepository {
static final AuthRepository _instance = AuthRepository._internal();
factory AuthRepository() => _instance;
AuthRepository._internal();

final ApiClient _client = ApiClient();

/// Register
Future<ApiResult<AuthData>> register({required String email, required String password}) async {
try {
final body = {'email': email, 'password': password};
final resp = await _client.post(ApiConstants.authRegister, data: body);

      if (resp.statusCode == HttpStatusCode.created || resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final authData = dataMap != null ? AuthData.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: authData);
      } else {
        return ApiResult(success: false, message: resp.data.toString());
      }
    } on DioError catch (e) {
      String msg = _handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
}

/// Login
Future<ApiResult<AuthData>> login({required String email, required String password}) async {
try {
final body = {'email': email, 'password': password};
final resp = await _client.post(ApiConstants.authLogin, data: body);

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final authData = dataMap != null ? AuthData.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: authData);
      } else {
        // backend retourne 4xx avec message dans body
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : resp.statusMessage;
        return ApiResult(success: false, message: msg?.toString());
      }
    } on DioError catch (e) {
      String msg = _handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
}

String _handleDioError(DioError e) {
if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout) {
return 'Connection timeout. Vérifie ta connexion.';
}
if (e.response != null && e.response?.data != null) {
try {
final body = e.response!.data;
if (body is Map<String, dynamic> && body['message'] != null) return body['message'].toString();
return body.toString();
} catch (_) {
return e.response.toString();
}
}
return e.message;
}
}

5) Injection dans InitialBindings
   // dans InitialBindings.dependencies()
   Get.put(ApiClient()); // optionnel (ApiClient singleton)
   Get.put(AuthRepository()); // pour l’injecter si tu veux

6) Mise à jour du controller d’inscription (signup)

Exemple minimal — adapte ton UI (loader/snackbar).

// lib/presentation/auth/sign_up_controller.dart
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/utils/pref_utils.dart';
import '../../core/constants.dart';
import '../../data/models/auth_response.dart';

class SignUpWithEmailController extends GetxController {
final formSignUpKey = GlobalKey<FormState>();
final authRepo = AuthRepository();

RxBool isShowPassword = true.obs;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

Future<void> signupFn() async {
if (formSignUpKey.currentState == null) return;
if (!formSignUpKey.currentState!.validate()) return;
if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
MessageSnackBar.errorToast(title: "Warning".tr, message: "Mot de passe ne correspondent pas");
return;
}
try {
FullScreenLoader.openLoadingDialog('We are processing...', ImageConstant.lottieTrophy);
final result = await authRepo.register(email: emailController.text.trim(), password: passwordController.text.trim());
FullScreenLoader.stopLoading();

      if (result.success) {
        // sauvegarde email ou naviguer vers OTP
        await PrefUtils.setEmail(emailController.text.trim());
        Get.toNamed(Routes.otpScreen, arguments: {
          "SourceOTP": "FromSignup",
          "Email": emailController.text.trim(),
        });
        MessageSnackBar.successSnackBar(title: 'Successfully', message: result.message ?? 'Inscription initiée');
      } else {
        MessageSnackBar.errorSnackBar(title: 'Erreur', message: result.message ?? 'Erreur serveur');
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      MessageSnackBar.errorSnackBar(title: 'Erreur', message: e.toString());
    }
}
}

7) Mise à jour du controller de login (signin)
   // lib/presentation/auth/sign_in_controller.dart
   import 'package:get/get.dart';
   import '../../data/repositories/auth_repository.dart';
   import '../../core/utils/pref_utils.dart';

class SignInController extends GetxController {
final formLoginKey = GlobalKey<FormState>();
final authRepo = AuthRepository();

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
RxBool isShowPassword = true.obs;

Future<void> loginFn() async {
if (formLoginKey.currentState == null) return;
if (!formLoginKey.currentState!.validate()) return;

    try {
      FullScreenLoader.openLoadingDialog('Logging in...', ImageConstant.lottieTrophy);
      final res = await authRepo.login(email: emailController.text.trim(), password: passwordController.text.trim());
      FullScreenLoader.stopLoading();

      if (res.success) {
        // si backend renvoie token: PrefUtils.setToken(res.data?.token)
        await PrefUtils.setEmail(emailController.text.trim());

        // règle ton index et navigation
        await BottomBarController.instance.changeTabIndex(2);
        Get.offAllNamed(Routes.navigationScreen);

        MessageSnackBar.successSnackBar(title: 'Successfully', message: 'Login with ${emailController.text.trim()}');
      } else {
        MessageSnackBar.errorSnackBar(title: 'Erreur', message: res.message ?? 'Vérifie tes identifiants');
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      MessageSnackBar.errorSnackBar(title: 'Erreur', message: e.toString());
    }
}
}

8) PrefUtils : ajout token & hasSeenGuide example (tu as déjà PrefUtils — j’ajoute méthodes utiles)
   // dans PrefUtils (existante)
   static const _KeyToken = 'token';
   static Future setToken(String token) async => await sharedPreferences!.setString(_KeyToken, token);
   static String? getToken() => sharedPreferences!.getString(_KeyToken);

static const _KeyHasSeenGuide = 'has_seen_app_guide';
static Future<void> setHasSeenGuide(bool value) async => await sharedPreferences!.setBool(_KeyHasSeenGuide, value);
static bool hasSeenGuide() => sharedPreferences?.getBool(_KeyHasSeenGuide) ?? false;

9) Remarques d’intégration & bonnes pratiques

Séparer couche : View (widget), Controller (Getx), Repository (AuthRepository), ApiClient (Dio), Models. Tu as déjà structure GetX — place les fichiers dans data/, presentation/, core/.

Gestion loader/erreur : j’utilise FullScreenLoader et MessageSnackBar (tu as déjà). Toujours stop loader dans finally ou après await.

Token : si backend renvoie token, stocke-le PrefUtils.setToken(token) puis ajoute un AuthInterceptor pour ajouter Authorization: Bearer <token> aux requêtes.

Retry / Timeout : Dio options déjà configurées. Pour un usage réel, pense à gérer rafraîchissement de token.

Tests : commence par tester register et login via Postman et logs Dio pour voir body exact. Les messages du backend (arabic) sont remontés et affichés aux users.

Status code central : j’ai ajouté HttpStatusCode dans constants.dart pour centraliser.

10) Exemple d’appel complet (vue => controller => repo)

Ton widget déjà appelle controller.signupFn() — avec le controller fourni ci-dessus ça fonctionne de façon professionnelle et testable.

Si tu veux je peux :

ajouter interceptor d’auth (pour rafraîchir token + header Authorization) ;

fournir un exemple pour OTP verification (endpoint) ;

convertir la logique pour utiliser http (si tu préfères) ;

ajouter tests unitaires simples pour AuthRepository.

Souhaites-tu que j’ajoute l’AuthInterceptor (pour ajouter automatiquement Authorization si token présent) et le code pour sauvegarder le token quand le backend le renvoie ?