import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/guide/guide_model.dart';
import 'package:flutter/material.dart';

class AppGuideController extends GetxController {
  RxBool showGuide = false.obs;
  RxInt currentPage = 0.obs; // index du bottom bar actuel
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

  void _initializeGuides() {
    pageGuides = {
      0: AppGuide(title: "Recherche", messages: [
        "Balayez à droite pour aimer un profil.",
        "Balayez à gauche pour passer au suivant.",
        "Utilisez le filtre pour rechercher par pays ou critères."
      ]),
      1: AppGuide(title: "Discussions", messages: [
        "Ici, vous pouvez discuter avec vos correspondances.",
        "Appuyez sur un contact pour ouvrir la conversation."
      ]),
      2: AppGuide(title: "Explorer", messages: [
        "Découvrez de nouveaux profils chaque jour.",
        "Appuyez sur le cœur pour les ajouter aux favoris."
      ]),
      3: AppGuide(title: "Favoris", messages: [
        "Tous vos profils favoris sont ici.",
        "Vous pouvez les supprimer ou leur écrire directement."
      ]),
      4: AppGuide(title: "Profil", messages: [
        "Gérez vos informations personnelles.",
        "Accédez aux paramètres et préférences."
      ]),
    };
  }

  void setCurrentPage(int index) {
    currentPage.value = index;
    currentMessageIndex.value = 0;
  }

  void nextMessage() {
    final guide = pageGuides[currentPage.value];
    if (guide != null && currentMessageIndex.value < guide.messages.length - 1) {
      currentMessageIndex.value++;
    } else {
      closeGuideForPage();
    }
  }

  void closeGuideForPage() {
    // Si on a vu toutes les pages, désactive le guide globalement
    if (currentPage.value == pageGuides.keys.last) {
      showGuide.value = false;
    } else {
      currentPage.value++;
      currentMessageIndex.value = 0;
    }
  }

  double getArrowXOffset(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const tabCount = 5;
    final step = currentPage.value;
    return (screenWidth / tabCount) * step + (screenWidth / tabCount) / 2 - 15;
  }
}

class AppGuide {
  final String title;
  final List<String> messages;
  AppGuide({required this.title, required this.messages});
}

