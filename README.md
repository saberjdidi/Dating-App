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
Date de création : 1 oct. 2025
Type d'entrée : PrivateKeyEntry
Longueur de chaîne du certificat : 1
Certificat[1]:
Propriétaire : CN=Saber, OU=BILHALAL, O=ASTREE, L=tunis, ST=Tunis, C=TN
Emetteur : CN=Saber, OU=BILHALAL, O=ASTREE, L=tunis, ST=Tunis, C=TN
Numéro de série : 58474cc
Valide du : Wed Oct 01 09:00:17 GMT+01:00 2025 au : Sun Feb 16 09:00:17 GMT+01:00 2053
Empreintes du certificat :
MD5 : C9:B0:ED:AF:69:A9:41:A9:00:3C:DD:A5:5F:65:85:35:7F:21:F1:5D
SHA1 : 82:26:48:61:FD:29:32:5B:39:61:9B:87:EC:BA:FB:36:CB:6A:04:73:67:44:3E:EF:D4:06:C0:28:D9:AB:62:B4
SHA256 : SHA256withRSA
Nom de l'algorithme de signature : Clé RSA 2048 bits
Algorithme de clé publique du sujet : 3
Version : {10}

Extensions :

#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
KeyIdentifier [
0000: 92 DE 0D BB BB 51 8A 47   A5 FF 12 F0 53 36 7C A7  .....Q.G....S6..
0010: 26 D8 75 C3                                        &.u.
]
*******************************************
Serial number: 804c17851a554248
Valid from: Wed Oct 01 20:12:49 CEST 2025 until: Sun Feb 16 19:12:49 CET 2053
Certificate fingerprints:
SHA1: 2E:5C:8D:68:00:C5:6F:41:D7:C9:05:67:FF:50:D6:92:61:56:83:60
SHA256: 96:E0:CA:29:6C:66:0F:36:E3:20:32:94:1C:51:EC:F5:52:0A:81:65:B6:09:D2:95:23:AF:DD:3D:FB:2E:9D:31
Signature algorithm name: SHA384withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 3

Extensions:

#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
KeyIdentifier [
0000: DF F6 2A F2 8C 72 0A 5B   71 A5 34 2F 44 D4 1C 59  ..*..r.[q.4/D..Y
0010: B8 60 09 D0                                        .`..
]
]
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

## Facebook Auth
https://www.youtube.com/watch?v=Hj0csDW6WUs
https://www.youtube.com/watch?v=8MQf2kAU3GA


Identifiant de l’application: 1330583908717882
Clé secrète: a8b94364be548f17a4a24a591fbd3431

https://developers.facebook.com/apps/1330583908717882/use_cases/customize/?use_case_enum=APP_INSTALL_ADS_APP_EVENTS&selected_tab=quickstart&product_route=analytics

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

AndroidManifest.xml: 
<!--use for Facebook auth-->
    <uses-permission android:name="com.google.android.gms.permission.AD_ID" tools:node="remove"/>
<application
android:label="BilHalal Dating"
android:name="${applicationName}"
android:icon="@mipmap/launcher_icon"
android:requestLegacyExternalStorage="true">
 <!--Using for facebook auth-->
        <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
        <meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>

        <activity android:name="com.facebook.FacebookActivity"
            android:configChanges=
                "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
            android:label="@string/app_name" />
        <activity
            android:name="com.facebook.CustomTabActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="@string/fb_login_protocol_scheme" />
            </intent-filter>
        </activity>

    </application>
</manifest>

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


## Firebase + Google Sign-in
Nom d'alias : bilhalalgooglesignin
Date de création : 2 oct. 2025
Type d'entrée : PrivateKeyEntry
Longueur de chaîne du certificat : 1
Certificat[1]:
Propriétaire : CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown
Emetteur : CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown
Numéro de série : 43c39eba
Valide du : Thu Oct 02 17:06:11 GMT+01:00 2025 au : Mon Feb 17 17:06:11 GMT+01:00 2053
Empreintes du certificat :
MD5 : E5:ED:1F:DE:01:2A:A6:70:34:63:E1:E1:BC:7F:65:70:C4:60:5A:5A
SHA1 : D3:61:CD:A2:C6:E6:9C:0E:27:6A:3F:8A:79:27:61:15:AF:09:D2:C8:D5:D0:39:0B:48:A1:30:33:BD:91:55:AC
SHA256 : SHA256withRSA