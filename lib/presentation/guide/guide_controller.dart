import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GuideController extends GetxController {
  static GuideController get instance => Get.find();
  final storage = GetStorage();
  var showGuide = false.obs;
  var currentStep = 0.obs;

  final Map<int, List<String>> pageGuides = {
    0: ["Bienvenue sur la page d'accueil", "Découvrez les fonctionnalités ici"],
    1: ["Voici vos discussion", "Gérez une discussion avec vos amis"],
    2: ["Filter", "Modifiez vos informations personnelles"],
    3: ["Votre Favoris", "Modifiez vos informations personnelles", "voir les users et media on favoris"],
    4: ["Settings", "Paramétrer votre compte", "Modifier vos données"],
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
