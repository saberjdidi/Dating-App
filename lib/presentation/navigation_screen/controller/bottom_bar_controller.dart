import 'dart:async';
import 'package:dating_app_bilhalal/core/utils/enums.dart';
import 'package:dating_app_bilhalal/core/utils/image_constant.dart';
import 'package:dating_app_bilhalal/core/utils/popups/search_dating.dart';
import 'package:dating_app_bilhalal/core/utils/pref_utils.dart';
import 'package:dating_app_bilhalal/presentation/guide/app_guide_controller.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/custom_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {

  static BottomBarController get instance => Get.find();
  final mainController = Get.put(MainController());

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.searchImg,
      activeIcon: ImageConstant.searchImg,
      title: "بحث".tr,
      type: BottomBarEnum.search,
    ),
    BottomMenuModel(
      icon: ImageConstant.discussionImg,
      activeIcon: ImageConstant.discussionImg,
      title: "محادثة".tr,
      type: BottomBarEnum.discussion,
    ),
    BottomMenuModel(
      icon: ImageConstant.mainImg,
      activeIcon: ImageConstant.mainImg,
      title: "الکل".tr,
      type: BottomBarEnum.main,
    ),
    BottomMenuModel(
      icon: ImageConstant.likeImg,
      activeIcon: ImageConstant.likeImg,
      title: "المفضلة".tr,
      type: BottomBarEnum.favoris,
    ),
    BottomMenuModel(
      icon: ImageConstant.profileSettingsImg,
      activeIcon: ImageConstant.profileSettingsImg,
      title: "إعدادات".tr,
      type: BottomBarEnum.Profile,
    )
  ];

  // index bottom bar
  RxInt selectedIndex = 0.obs;

  // title exemple (ton usage existant)
  RxString selectedCountryTitle = "الکل".obs;



  void changeTabIndex(int index) {
    selectedIndex.value = index;
    // open guide for this index only if user asked (we open automatically on first load
    // or when user taps the "show guide again" in settings)
    openGuideForIndex(index, autoHide: true); //test for guide
  }

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

  ///Guide Start
  // Guide related
  RxBool showGuide = false.obs;
  RxBool showArrow = false.obs;
  RxInt currentSlideIndex = 0.obs;

  // slides per tab (modifiable, localizable)
  final List<List<String>> guideSlides = [
    ["بحث: استخدم المرشحات للعثور على المستخدمين حسب البلد.", "اسحب لليمين أو لليسار لتصفح المستخدمين."],
    ["محادثة: افتح المحادثات وابدأ الحديث."],
    ["الکل: اسحب لرؤية المستخدمين. اضغط للإطلاع على الملف."],
    ["المفضلة: هنا تجد مستخدميك المفضلين."],
    ["الملف: حرر معلوماتك الشخصية.", "تأكد من إضافة صورة و بایو جيد."],
  ];

  Timer? _autoHideTimer;
  final int guideAutoHideSeconds = 12;

  /// Call this from binding init once
  Future<void> initGuideAutoShowIfNeeded() async {
    // show guide by default the FIRST time, unless stored
    final hasSeen = PrefUtils.hasSeenGuide();
    if (!hasSeen) {
      // small delay to ensure UI ready
      Future.delayed(Duration(milliseconds: 300), () {
        openGuideForIndex(selectedIndex.value, autoHide: true);
        PrefUtils.setHasSeenGuide(true);
      });
    }
  }

  void openGuideForIndex(int idx, {bool autoHide = true}) {
    if (idx < 0 || idx >= guideSlides.length) return;
    selectedIndex.value = idx;
    currentSlideIndex.value = 0;
    showGuide.value = true;
    showArrow.value = true;

    _autoHideTimer?.cancel();
    if (autoHide) {
      _autoHideTimer = Timer(Duration(seconds: guideAutoHideSeconds), closeGuide);
    }
  }

  void closeGuide() {
    _autoHideTimer?.cancel();
    showGuide.value = false;
    showArrow.value = false;
  }

  void nextGuideAction() {
    final slides = guideSlides[selectedIndex.value];
    if (currentSlideIndex.value < slides.length - 1) {
      currentSlideIndex.value++;
    } else {
      // last slide: move to next tab if exists
      if (selectedIndex.value < guideSlides.length - 1) {
        final nextIndex = selectedIndex.value + 1;
        selectedIndex.value = nextIndex;
        currentSlideIndex.value = 0;
        // open next guide
        openGuideForIndex(nextIndex, autoHide: true);
      } else {
        closeGuide();
      }
    }
    _autoHideTimer?.cancel();
    _autoHideTimer = Timer(Duration(seconds: guideAutoHideSeconds), closeGuide);
  }

  void prevGuideAction() {
    if (currentSlideIndex.value > 0) {
      currentSlideIndex.value--;
      _autoHideTimer?.cancel();
      _autoHideTimer = Timer(Duration(seconds: guideAutoHideSeconds), closeGuide);
    }
  }

  @override
  void onClose() {
    _autoHideTimer?.cancel();
    super.onClose();
  }
///Guide End
}

/*
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
*/