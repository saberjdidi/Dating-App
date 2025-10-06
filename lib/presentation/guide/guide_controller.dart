import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import '../../core/utils/pref_utils.dart';
import '../navigation_screen/controller/bottom_bar_controller.dart';

class GuideController extends GetxController {
  static GuideController get instance => Get.find();

  var showGuide = false.obs;
  var currentStep = 0.obs;
  var currentGuidePage = 0.obs;

  final Map<int, List<String>> pageGuides = {
    0: ["Page d'accueil", "Découvrez les fonctionnalités ici", "Swipe à gauche et à droite pour voir tous les utilisateurs"],
    1: ["Discussion", "Gérez une discussion avec vos amis", "Partagez votre connaissance"],
    2: ["Filtre", "Rechercher utilisateurs par pays", "Utilisez les filtres avancés"],
    3: ["Favoris", "Voir vos utilisateurs préférés", "Gérez vos favoris"],
    4: ["Profil", "Paramétrez votre compte", "Modifiez vos informations personnelles"],
  };

  @override
  void onInit() {
    super.onInit();
    final hasSeen = PrefUtils.hasSeenGuide();
    if (!hasSeen && PrefUtils.getShowGuide()) {
      showGuide.value = true;
    }
  }

  void markGuideAsSeen() async {
    await PrefUtils.setHasSeenGuide(true);
    showGuide.value = false;
  }

  void resetGuide() async {
    await PrefUtils.setHasSeenGuide(false);
    await PrefUtils.setShowGuide(true);
    currentStep.value = 0;
    currentGuidePage.value = 0;
    showGuide.value = true;
  }

  /// Aller à l’étape suivante (si la dernière → aller à la page suivante)
  void nextStep(List<String> guideTexts) {
    if (currentStep.value < guideTexts.length - 1) {
      currentStep.value++;
    } else {
      final bottomBar = BottomBarController.instance;
      if (currentGuidePage.value < pageGuides.length - 1) {
        currentGuidePage.value++;
        bottomBar.changeTabIndex(currentGuidePage.value);
        currentStep.value = 0;
      } else {
        markGuideAsSeen();
      }
    }
  }

  /// Fermer uniquement le guide du current page
  void closeCurrentGuide() {
    if (currentGuidePage.value < pageGuides.length - 1) {
      currentGuidePage.value++;
      BottomBarController.instance.changeTabIndex(currentGuidePage.value);
      currentStep.value = 0;
    } else {
      markGuideAsSeen();
    }
  }
}

/*
class GuideController extends GetxController {
  static GuideController get instance => Get.find();
  final storage = GetStorage();
  var showGuide = false.obs;
  var currentStep = 0.obs;

  final Map<int, List<String>> pageGuides = {
    0: ["Page d'accueil", "Découvrez les fonctionnalités ici", "Swipe à gauche et à droite pour voir tous les utilisateurs"],
    1: ["Discussion", "Gérez une discussion avec vos amis", "partagez votre connaissance avec vos amis"],
    2: ["Filter", "Rechercher utilisateurs par pays",  "Swipe en haut et en bas pour voir les utilisateurs"],
    3: ["Votre Favoris", "Modifiez vos informations personnelles", "voir les users et media on favoris"],
    4: ["Settings", "Paramétrer votre compte", "Modifiez vos informations personnelles"],
  };

  @override
  void onInit() {
    super.onInit();
    final hasSeenGuide = storage.read('hasSeenGuide') ?? false;
    if (!hasSeenGuide) {
      showGuide.value = true;
    }
  }

  void markGuideAsSeen() {
    storage.write('hasSeenGuide', true);
    showGuide.value = false;
  }

  void resetGuide() {
    storage.write('hasSeenGuide', false);
    showGuide.value = true;
    currentStep.value = 0;
  }

  void nextStep(int totalSteps) {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      markGuideAsSeen();
    }
  }
}
*/