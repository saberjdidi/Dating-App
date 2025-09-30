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