//ignore: unused_import    
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  static const _KeyIsBoarding = 'isBoarding';
  static const _KeyToken = 'token';
  static const _KeyTokenVerifAccount = 'tokenVerifAccount';
  static const _keyEmail = 'email';
  static const _KeyLangue = 'langue';
  static const _KeyTheme = 'theme';
  static const _KeyFirstname = 'firstName';
  static const _KeyLastname = 'lastName';
  static const _KeyPhoneNumber = 'phoneNumber';
  static const _KeyAddress = 'address';
  static const _KeyBirthDate = 'birthDate';
  static const _KeyEmailLogin = 'emailLogin';
  static const _KeyPasswordLogin = 'passwordLogin';
  static const _KeyOnBoarding = 'onBoarding';
  static const _KeyLogoUser = 'logoUser';

  static const _keyCallVoice = 'call_voice';
  static const _keyCallVideo = 'call_video';

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    //print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'light';
      //return 'dark';
    }
  }

  /*String getThemeData() {
    try {
      // Check if the 'themeData' key is present
      if (_sharedPreferences!.containsKey('themeData')) {
        // If yes, return the stored value
        return _sharedPreferences!.getString('themeData')!;
      } else {
        // If not, set the default value ('dark') and return it
         setThemeData('dark');
        return 'dark';
      }
    } catch (e) {
      return 'dark';
    }
  } */

  ///Is Boarding
  static Future setIsBoarding(String numIdentity) async =>
      await _sharedPreferences!.setString(_KeyIsBoarding, numIdentity);

  static String? getIsBoarding() => _sharedPreferences!.getString(_KeyIsBoarding);

  static Future<void> clearIsBoarding() async {
    await _sharedPreferences!.remove(_KeyIsBoarding);
  }


  static Future setLangue(String lang) async =>
      await _sharedPreferences!.setString(_KeyLangue, lang);

  static String? getLangue() {
    try {
      return _sharedPreferences!.getString(_KeyLangue) ?? 'fr'; // Provide a default value
    } catch (e) {
      return 'fr';
    }
  }
  //static String? getLangue() => _sharedPreferences!.getString(_KeyLangue);

  static Future setTheme(String lang) async =>
      await _sharedPreferences!.setString(_KeyTheme, lang);

  static String? getTheme() => _sharedPreferences!.getString(_KeyTheme);

  ///Token
  static Future setToken(String token) async =>
      await _sharedPreferences!.setString(_KeyToken, token);

  static String? getToken() => _sharedPreferences!.getString(_KeyToken);

  static Future<void> clearToken() async {
    await _sharedPreferences!.remove(_KeyToken);
  }

  ///Token
  static Future setTokenVerifAccount(String token) async =>
      await _sharedPreferences!.setString(_KeyTokenVerifAccount, token);

  static String? getTokenVerifAccount() => _sharedPreferences!.getString(_KeyTokenVerifAccount);

  static Future<void> clearTokenVerifAccount() async {
    await _sharedPreferences!.remove(_KeyTokenVerifAccount);
  }

  ///Email
  static Future setEmail(String username) async =>
      await _sharedPreferences!.setString(_keyEmail, username);

  static String? getEmail() => _sharedPreferences!.getString(_keyEmail);

  static Future<void> clearEmail() async {
    await _sharedPreferences!.remove(_keyEmail);
  }

  ///FirstName
  static Future setFirstname(String firstName) async =>
      await _sharedPreferences!.setString(_KeyFirstname, firstName);

  static String? getFirstname() => _sharedPreferences!.getString(_KeyFirstname);

  static Future<void> clearFirstname() async {
    await _sharedPreferences!.remove(_KeyFirstname);
  }

  ///LastName
  static Future setLastName(String lastName) async =>
      await _sharedPreferences!.setString(_KeyLastname, lastName);

  static String? getLastName() => _sharedPreferences!.getString(_KeyLastname);

  static Future<void> clearLastName() async {
    await _sharedPreferences!.remove(_KeyLastname);
  }

  ///Address
  static Future setAddress(String address) async =>
      await _sharedPreferences!.setString(_KeyAddress, address);

  static String? getAddress() => _sharedPreferences!.getString(_KeyAddress);

  static Future<void> clearAddress() async {
    await _sharedPreferences!.remove(_KeyAddress);
  }

  ///Phone Number
  static Future setPhoneNumber(String phone) async =>
      await _sharedPreferences!.setString(_KeyPhoneNumber, phone);

  static String? getPhoneNumber() => _sharedPreferences!.getString(_KeyPhoneNumber);

  static Future<void> clearPhoneNumber() async {
    await _sharedPreferences!.remove(_KeyPhoneNumber);
  }

  ///Birth Date
  static Future setBirthDate(String birthDate) async =>
      await _sharedPreferences!.setString(_KeyBirthDate, birthDate);

  static String? getBirthDate() => _sharedPreferences!.getString(_KeyBirthDate);

  static Future<void> clearBirthDate() async {
    await _sharedPreferences!.remove(_KeyBirthDate);
  }

  ///Email & Password Login
  static Future setEmailLogin(String value) async =>
      await _sharedPreferences!.setString(_KeyEmailLogin, value);

  static String? getEmailLogin() => _sharedPreferences!.getString(_KeyEmailLogin);

  static Future<void> clearEmailLogin() async {
    await _sharedPreferences!.remove(_KeyEmailLogin);
  }

  static Future setPasswordLogin(String password) async =>
      await _sharedPreferences!.setString(_KeyPasswordLogin, password);

  static String? getPasswordLogin() => _sharedPreferences!.getString(_KeyPasswordLogin);

  static Future<void> clearPasswordLogin() async {
    await _sharedPreferences!.remove(_KeyPasswordLogin);
  }

  ///OnBoarding
  static Future setOnBoarding(String value) async =>
      await _sharedPreferences!.setString(_KeyOnBoarding, value);

  static String? getOnBoarding() => _sharedPreferences!.getString(_KeyOnBoarding);

  static Future<void> clearOnBoarding() async {
    await _sharedPreferences!.remove(_KeyOnBoarding);
  }

  //Logo
  static Future setLogoUser(String value) async =>
      await _sharedPreferences!.setString(_KeyLogoUser, value);

  static String? getLogoUser() => _sharedPreferences!.getString(_KeyLogoUser);

  static Future<void> clearLogoUser() async {
    await _sharedPreferences!.remove(_KeyLogoUser);
  }

  ///Call Voice & Video
  static Future<void> setCallVoice(bool value) async {
    //final prefs = await SharedPreferences.getInstance();
    await _sharedPreferences!.setBool(_keyCallVoice, value);
  }

  static Future<void> setCallVideo(bool value) async {
    await _sharedPreferences!.setBool(_keyCallVideo, value);

    //final prefs = await SharedPreferences.getInstance();
    //await prefs.setBool(_keyCallVideo, value);
  }

  static Future<bool> getCallVoice() async {
    return _sharedPreferences!.getBool(_keyCallVoice) ?? false;
  }

  static Future<bool> getCallVideo() async {
    return _sharedPreferences!.getBool(_keyCallVideo) ?? false;
  }
}
    