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
cmd > keytool -genkey -v -keystore upload-bilhalal.jks -alias upload-bilhalal -keyalg RSA -keysize 2048 -validity 10000
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
]

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
