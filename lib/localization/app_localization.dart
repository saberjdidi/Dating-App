import 'package:get/get.dart';
import 'ar_translations.dart';
import 'en_translations.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': ar,
    'en': en,
  };
}
