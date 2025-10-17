import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/selection_popup_model.dart';

class DropdownFunctions {
// ---------- SOCIAL STATE (الحالة الاجتماعية) ----------
  // valeur envoyée au backend (enum keys)
  static const Map<String, String> _socialStateMap = {
    'single': 'أعزب',   // backend -> display
    'married': 'متزوج',
    'divorced': 'مُطلّق',
    'widowed': 'أرمل',
    'other': 'آخر',
  };

  // inverse map : display -> backend enum
  static final Map<String, String> _socialStateReverse =
  { for (var e in _socialStateMap.entries) e.value : e.key };

  // retourne enum backend à partir du texte affiché (arabe) ou si déjà enum, retourne tel quel
  static String getSocialStateEnum(String? displayOrEnum) {
    if (displayOrEnum == null) return 'other';
    // si valeur déjà ressemble à enum (latin letters) et contenue dans keys
    if (_socialStateMap.containsKey(displayOrEnum)) return displayOrEnum;
    // sinon convertit depuis l'affichage (arabe)
    return _socialStateReverse[displayOrEnum] ?? 'other';
  }

  // retourne libellé d'affichage (arabe) à partir de enum reçu
  static String getSocialStateDisplay(String? enumValue) {
    if (enumValue == null) return _socialStateMap['other']!;
    return _socialStateMap[enumValue] ?? _socialStateMap['other']!;
  }

  // ---------- MARRIAGE TYPE (نوع الزواج / intent) ----------
  static const Map<String, String> _marriageTypeMap = {
    'friend': 'الصداقة',
    'date': 'مواعدة',
    'living_partner': 'معيشة',
    'marriage': 'زواج',
  };

  static final Map<String, String> _marriageTypeReverse =
  { for (var e in _marriageTypeMap.entries) e.value : e.key };

  static String getMarriageTypeEnum(String? displayOrEnum) {
    if (displayOrEnum == null) return 'friend';
    if (_marriageTypeMap.containsKey(displayOrEnum)) return displayOrEnum;
    return _marriageTypeReverse[displayOrEnum] ?? 'friend';
  }

  static String getMarriageTypeDisplay(String? enumValue) {
    if (enumValue == null) return _marriageTypeMap['friend']!;
    return _marriageTypeMap[enumValue] ?? _marriageTypeMap['friend']!;
  }

  // ---------- COUNTRY (pays) ----------
  // Ici on mappe "EnglishName" <-> "Arabe affiché".
  // Adapte les clés/valeurs selon ce que ton backend attend (p.ex. 'Tunisia' ou 'Tunis' ?)
  static const Map<String, String> _countryMap = {
    'Bahrain': 'البحرین',
    'United Arab Emirates': 'الامارات',
    'Qatar': 'قطر',
    'Tunisia': 'تونس',
    'Kuwait': 'الکویت',
    'Saudi Arabia': 'السعودیة',
    'Iraq': 'العراق',
    'Oman': 'عمان',
    'Morocco': 'المغرب',
    // ajoute le reste...
  };

  static final Map<String, String> _countryReverse =
  { for (var e in _countryMap.entries) e.value : e.key };

  // Convertit label arabe -> valeur envoyée (ex: "تونس" -> "Tunisia")
  static String getCountryForRequest(String? displayOrEnum) {
    if (displayOrEnum == null) return '';
    if (_countryMap.containsKey(displayOrEnum)) return displayOrEnum; // si déjà English key (rare)
    return _countryReverse[displayOrEnum] ?? displayOrEnum; // si display arabe -> retourne english
  }

  // Convertit valeur backend -> label arabe pour affichage
  static String getCountryDisplay(String? backendValue) {
    if (backendValue == null || backendValue.isEmpty) return '';
    return _countryMap[backendValue] ?? backendValue;
  }

  // fournit la liste d'items SelectionPopupModel (affichage arabe) à partir du map
  static List<SelectionPopupModel> socialStateDropdownItems() {
    return _socialStateMap.entries
        .map((e) => SelectionPopupModel(id: 0, title: e.value))
        .toList();
  }

  static List<SelectionPopupModel> marriageTypeDropdownItems() {
    return _marriageTypeMap.entries
        .map((e) => SelectionPopupModel(id: 0, title: e.value))
        .toList();
  }

  static List<CountryModel> countriesDropdownItems() {
    return _countryMap.entries
        .map((e) => CountryModel(name: e.value, imagePath: '')) // ajoute image si tu as
        .toList();
  }
}