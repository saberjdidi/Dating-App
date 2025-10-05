import 'package:dating_app_bilhalal/core/utils/popups/search_dating.dart';
import 'package:dating_app_bilhalal/core/utils/pref_utils.dart';
import 'package:dating_app_bilhalal/presentation/guide/app_guide_controller.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  static BottomBarController get instance => Get.find();
  final mainController = Get.put(MainController());

  /// Index de l’onglet sélectionné
  RxInt selectedIndex = 0.obs;
  //var selectedCountries = <String>[].obs;
  /// Pays sélectionné
  RxString selectedCountryTitle = "الکل".obs;

 /* void changeTabIndex(int index) {
    selectedIndex.value = index;
  } */
  /// === Gestion des onglets ===
  void changeTabIndex(int index) {
    selectedIndex.value = index;
    if (index == 2) { // si onglet "main" sélectionné
      openSearchDialog();
    }
  }
/*
  void toggleCountry(String countryName) {
    if (selectedCountries.contains(countryName)) {
      selectedCountries.remove(countryName);
    } else {
      selectedCountries.add(countryName);
    }
    updateCountryTitle();
  } */

  void updateCountryTitle() {
    if (mainController.selectedCountries.isEmpty || mainController.selectedCountries.contains("الکل")) {
      selectedCountryTitle.value = "الکل";
    } else if (mainController.selectedCountries.length == 1) {
      selectedCountryTitle.value = mainController.selectedCountries.first;
    } else {
      selectedCountryTitle.value = "عدة دول";
    }
    debugPrint('update Country Title : ${selectedCountryTitle.value}');
  }

  void openSearchDialog() {

    Future.delayed(Duration.zero, () {
      SearchDating.openDialogFilterByPays(mainController); // 👈 appelé uniquement quand onglet "main"
    });
  }

  ///Start Section pour Guide
  /// === Guide contextuel ===
  RxBool showGuide = false.obs;
  RxInt currentMessageIndex = 0.obs;

  late Map<int, AppGuide> pageGuides;

  @override
  void onInit() {
    super.onInit();
    final firstTimeGuide = PrefUtils.getShowGuide() ?? true;
    if (firstTimeGuide) {
      _initializeGuides();
      showGuide.value = true;
      PrefUtils.setShowGuide(false);
    }
  }
/*
  @override
  void onInit() {
    super.onInit();
    _initializeGuides();
    _loadGuideState();
  } */
  Future<void> _loadGuideState() async {
    final firstTimeGuide = await PrefUtils.getShowGuide() ?? true;
    if (firstTimeGuide) {
      showGuide.value = true;
      PrefUtils.setShowGuide(false);
    }
  }
  void _initializeGuides() {
    pageGuides = {
      0: AppGuide(title: "البحث", messages: [
        "يمكنك تصفية المستخدمين حسب البلد أو العمر.",
        "استخدم شريط البحث للوصول السريع إلى المستخدمين."
      ]),
      1: AppGuide(title: "المحادثات", messages: [
        "هنا تظهر جميع المحادثات الخاصة بك.",
        "انقر على مستخدم لبدء الدردشة."
      ]),
      2: AppGuide(title: "الرئيسية", messages: [
        "هنا يمكنك تصفح جميع الملفات الشخصية.",
        "استخدم الفلاتر للعثور على الشريك المناسب."
      ]),
      3: AppGuide(title: "المفضلة", messages: [
        "جميع المستخدمين الذين أحببتهم يظهرون هنا.",
        "يمكنك إزالة أو إرسال رسالة مباشرة."
      ]),
      4: AppGuide(title: "الملف الشخصي", messages: [
        "قم بتعديل معلوماتك وصورتك هنا.",
        "تحكم بإعدادات حسابك بسهولة."
      ]),
    };
  }

  void nextGuideMessage() {
    final guide = pageGuides[selectedIndex.value];
    if (guide == null) return;

    if (currentMessageIndex.value < guide.messages.length - 1) {
      currentMessageIndex.value++;
    } else {
      closeCurrentGuide();
    }
  }

  void closeCurrentGuide() {
    if (selectedIndex.value == pageGuides.keys.last) {
      showGuide.value = false;
    } else {
      selectedIndex.value++;
      currentMessageIndex.value = 0;
    }
  }

  double getArrowXOffset(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const tabCount = 5;
    final step = selectedIndex.value;
    return (screenWidth / tabCount) * step + (screenWidth / tabCount) / 2 - 15;
  }
/// End Section
  /*
  RxBool showGuide = false.obs;
  RxInt currentGuideStep = 0.obs;
  List<String> guideTexts = [];
  void changeTabIndex(int index) {
    selectedIndex.value = index;
    _initGuideForPage(index); //use for guide
    if (index == 2) { // si onglet "main" sélectionné
      openSearchDialog();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initGuideForPage(0); // guide initial (Search)
  }

  /// 🎯 Initialisation des textes de guide selon la page
  void _initGuideForPage(int index) {
    guideTexts.clear();
    switch (index) {
      case 0:
        guideTexts = [
          "Bienvenue dans la recherche ! Utilisez cette icône pour explorer.",
          "Vous pouvez filtrer selon vos préférences ici.",
        ];
        break;
      case 1:
        guideTexts = [
          "Ici se trouvent vos discussions récentes.",
          "Touchez un contact pour ouvrir la conversation.",
        ];
        break;
      case 2:
        guideTexts = [
          "Ceci est la page principale pour explorer les profils.",
        ];
        break;
      case 3:
        guideTexts = [
          "Vos favoris s’affichent ici.",
          "Appuyez longtemps pour retirer un favori.",
        ];
        break;
      case 4:
        guideTexts = [
          "Bienvenue sur votre profil.",
          "Ici, vous pouvez modifier vos informations personnelles.",
        ];
        break;
    }

    currentGuideStep.value = 0;
    showGuide.value = guideTexts.isNotEmpty;
  }

  /// 🧭 Navigation dans le guide
  void nextGuideStep() {
    if (currentGuideStep.value < guideTexts.length - 1) {
      currentGuideStep.value++;
    } else {
      showGuide.value = false; // Fin du guide
    }
  }

  double getArrowXOffset(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const tabCount = 5;
    final step = selectedIndex.value;
    return (screenWidth / tabCount) * step + (screenWidth / tabCount) / 2 - 15;
  }
 */
}
