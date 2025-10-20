import 'package:flutter/material.dart';
import '../core/app_export.dart';

class TranslationController extends GetxController {
  Locale? language;

  changeLang(String langcode) async {
    Locale locale = Locale(langcode);
    //myServices.sharedPreferences.setString("lang", langcode) ;
   await PrefUtils.setLangue(langcode);
    debugPrint('sharedPrefLang : ${PrefUtils.getLangue()}');
   await Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();

    String? sharedPrefLang = PrefUtils.getLangue();
    //debugPrint('sharedPrefLang : $sharedPrefLang');
    ///First method
    language = Locale(sharedPrefLang ?? 'ar');
    ///Second method
   /* if (sharedPrefLang == "fr") {
      language = const Locale("fr");
    } else if (sharedPrefLang == "en") {
      language = const Locale('en');
    } else {
      language = const Locale("fr");
      //language = Locale(Get.deviceLocale!.languageCode);
    } */
  }
}