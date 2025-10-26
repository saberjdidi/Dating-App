//ignore: unused_import    
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PrefUtils {
  static SharedPreferences? sharedPreferences;

 /* PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
    });
  } */

  // Appelée une seule fois au démarrage (main)
  static Future<void> init() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    //print('SharedPreference Initialized');
  }

  static const _KeyIsBoarding = 'isBoarding';
  static const _KeyToken = 'token';
  static const _keyEmail = 'email';
  static const _keyUsername = 'username';
  static const _keyId = 'id';
  static const _keyOTP = 'OTP';
  static const _keyImageProfile = 'imageProfile';
  static const _keyEmailGoogle = 'emailGoogle';
  static const _keyEmailFacebook = 'emailFacebook';
  static const _keyFullName = 'fullName';
  static const _KeyLangue = 'langue';
  static const _KeyTheme = 'theme';
  static const _keyShowGuide = 'show_app_guide';
  static const _KeyHasSeenGuide = 'has_seen_app_guide';
  static const _KeyFirstname = 'firstName';
  static const _KeyLastname = 'lastName';
  static const _KeyPassword = 'password';
  static const _KeyAddress = 'address';
  static const _KeyBirthDate = 'birthDate';
  static const _KeyOnBoarding = 'onBoarding';
  static const _KeyLogoUser = 'logoUser';

  static const _keyCallVoice = 'call_voice';
  static const _keyCallVideo = 'call_video';
  static const _keyHideOnline = 'hideOnline';

  static const _keySubscriptionPlan = 'subscriptionPlan';

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    sharedPreferences!.clear();
  }

/*
  Future<void> setThemeData(String value) {
    return sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'light';
      //return 'dark';
    }
  } */

  ///Is Boarding
  static Future setIsBoarding(String numIdentity) async =>
      await sharedPreferences!.setString(_KeyIsBoarding, numIdentity);

  static String? getIsBoarding() => sharedPreferences!.getString(_KeyIsBoarding);

  static Future<void> clearIsBoarding() async {
    await sharedPreferences!.remove(_KeyIsBoarding);
  }


  static Future setLangue(String lang) async =>
      await sharedPreferences!.setString(_KeyLangue, lang);

  static String? getLangue() {
    try {
      return sharedPreferences!.getString(_KeyLangue) ?? 'ar'; // Provide a default value
    } catch (e) {
      return 'ar';
    }
  }
  //static String? getLangue() => sharedPreferences!.getString(_KeyLangue);

  static Future setTheme(String theme) async =>
      await sharedPreferences!.setString(_KeyTheme, theme);

  static String getTheme() {
    return sharedPreferences?.getString(_KeyTheme) ?? 'light';
  }
  //static String? getTheme() => sharedPreferences!.getString(_KeyTheme);

  /// OnBoarding
  static Future setOnBoarding(String value) async =>
      await sharedPreferences!.setString(_KeyOnBoarding, value);

  static String? getOnBoarding() => sharedPreferences!.getString(_KeyOnBoarding);

  static Future<void> clearOnBoarding() async {
    await sharedPreferences!.remove(_KeyOnBoarding);
  }

  static Future<void> setIsOnBoarding(bool value) async {
    await sharedPreferences!.setBool(_KeyIsBoarding, value);
  }
  static Future<bool> getIsOnBoarding() async {
    return sharedPreferences!.getBool(_KeyIsBoarding) ?? false;
  }
  static Future<void> clearIsOnBoarding() async {
    await sharedPreferences!.remove(_KeyIsBoarding);
  }

  //Guide
  static Future setShowGuide(bool value) async =>
      await sharedPreferences!.setBool(_keyShowGuide, value);
  static bool getShowGuide() =>
      sharedPreferences?.getBool(_keyShowGuide) ?? true;

  static Future<void> setHasSeenGuide(bool value) async =>
      await sharedPreferences!.setBool(_KeyHasSeenGuide, value);

  static bool hasSeenGuide() => sharedPreferences?.getBool(_KeyHasSeenGuide) ?? false;

  // Vérifications
  static bool isFirstTime() {
    final onboarding = getOnBoarding();
    return onboarding == null || onboarding.isEmpty;
  }

  static bool isLoggedIn() {
    final email = getEmail();
    return email != null && email.isNotEmpty;
  }

  ///Token
  static Future setToken(String token) async =>
      await sharedPreferences!.setString(_KeyToken, token);

  static String? getToken() => sharedPreferences!.getString(_KeyToken);

  static Future<void> clearToken() async {
    await sharedPreferences!.remove(_KeyToken);
  }

  ///Email
  static Future setEmail(String email) async =>
      await sharedPreferences!.setString(_keyEmail, email);

  static String? getEmail() => sharedPreferences!.getString(_keyEmail);

  static Future<void> clearEmail() async {
    await sharedPreferences!.remove(_keyEmail);
  }

  static Future setEmailGoogle(String email) async =>
      await sharedPreferences!.setString(_keyEmailGoogle, email);

  static String? getEmailGoogle() => sharedPreferences!.getString(_keyEmailGoogle);

  static Future<void> clearEmailGoogle() async {
    await sharedPreferences!.remove(_keyEmailGoogle);
  }

  ///Full name
  static Future setFullName(String fullname) async =>
      await sharedPreferences!.setString(_keyFullName, fullname);

  static String? getFullName() => sharedPreferences!.getString(_keyFullName);

  static Future<void> clearFullName() async {
    await sharedPreferences!.remove(_keyFullName);
  }

  ///Username
  static Future setUsername(String username) async =>
      await sharedPreferences!.setString(_keyUsername, username);

  static String? getUsername() => sharedPreferences!.getString(_keyUsername);

  static Future<void> clearUsername() async {
    await sharedPreferences!.remove(_keyUsername);
  }

  ///Id
  static Future setId(String id) async =>
      await sharedPreferences!.setString(_keyId, id);

  static String? getId() => sharedPreferences!.getString(_keyId);

  static Future<void> clearId() async {
    await sharedPreferences!.remove(_keyId);
  }
  ///OTP
  static Future setOTP(String otp) async =>
      await sharedPreferences!.setString(_keyOTP, otp);

  static String? getOTP() => sharedPreferences!.getString(_keyOTP);

  static Future<void> clearOTP() async {
    await sharedPreferences!.remove(_keyOTP);
  }


  static Future setImageProfile(String url) async =>
      await sharedPreferences!.setString(_keyImageProfile, url);

  static String? getImageProfile() => sharedPreferences!.getString(_keyImageProfile);

  static Future<void> clearImageProfile() async {
    await sharedPreferences!.remove(_keyImageProfile);
  }

  ///FirstName
  static Future setFirstname(String firstName) async =>
      await sharedPreferences!.setString(_KeyFirstname, firstName);

  static String? getFirstname() => sharedPreferences!.getString(_KeyFirstname);

  static Future<void> clearFirstname() async {
    await sharedPreferences!.remove(_KeyFirstname);
  }

  ///LastName
  static Future setLastName(String lastName) async =>
      await sharedPreferences!.setString(_KeyLastname, lastName);

  static String? getLastName() => sharedPreferences!.getString(_KeyLastname);

  static Future<void> clearLastName() async {
    await sharedPreferences!.remove(_KeyLastname);
  }

  ///Address
  static Future setAddress(String address) async =>
      await sharedPreferences!.setString(_KeyAddress, address);

  static String? getAddress() => sharedPreferences!.getString(_KeyAddress);

  static Future<void> clearAddress() async {
    await sharedPreferences!.remove(_KeyAddress);
  }

  ///Password
  static Future setPassword(String password) async =>
      await sharedPreferences!.setString(_KeyPassword, password);

  static String? getPassword() => sharedPreferences!.getString(_KeyPassword);

  static Future<void> clearPassword() async {
    await sharedPreferences!.remove(_KeyPassword);
  }

  ///Birth Date
  static Future setBirthDate(String birthDate) async =>
      await sharedPreferences!.setString(_KeyBirthDate, birthDate);

  static String? getBirthDate() => sharedPreferences!.getString(_KeyBirthDate);

  static Future<void> clearBirthDate() async {
    await sharedPreferences!.remove(_KeyBirthDate);
  }


  //Logo
  static Future setLogoUser(String value) async =>
      await sharedPreferences!.setString(_KeyLogoUser, value);

  static String? getLogoUser() => sharedPreferences!.getString(_KeyLogoUser);

  static Future<void> clearLogoUser() async {
    await sharedPreferences!.remove(_KeyLogoUser);
  }

  ///Call Voice & Video
  static Future<void> setCallVoice(bool value) async {
    //final prefs = await SharedPreferences.getInstance();
    await sharedPreferences!.setBool(_keyCallVoice, value);
  }

  static Future<void> setCallVideo(bool value) async {
    await sharedPreferences!.setBool(_keyCallVideo, value);

    //final prefs = await SharedPreferences.getInstance();
    //await prefs.setBool(_keyCallVideo, value);
  }

  static Future<void> setHideOnline(bool value) async {
    await sharedPreferences!.setBool(_keyHideOnline, value);

  }

  static Future<bool> getCallVoice() async {
    return sharedPreferences!.getBool(_keyCallVoice) ?? false;
  }

  static Future<bool> getCallVideo() async {
    return sharedPreferences!.getBool(_keyCallVideo) ?? false;
  }

  static Future<bool> getHideOnline() async {
    return sharedPreferences!.getBool(_keyHideOnline) ?? false;
  }

}