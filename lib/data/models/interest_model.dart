import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class InterestModel {
  final String name;
  final IconData icon;
  //final String icon;
  InterestModel({required this.name, required this.icon});

  // Fonction pour obtenir l'icône à partir du nom
  static IconData getIconByName(String name) {
    try {
      return interestsList.firstWhere((e) => e.name == name).icon;
    } catch (e) {
      return Icons.help_outline; // Icône par défaut si non trouvé
    }
  }
}

final interestsList = [
  InterestModel(name: "التسوق", icon: Icons.shopping_bag_outlined),
  InterestModel(name: "فوتوغرافيا", icon: Icons.camera_alt_outlined),
  InterestModel(name: "اليوغا", icon: Iconsax.colorfilter),
  InterestModel(name: "كاريوكي", icon: Icons.keyboard_voice_outlined),
  InterestModel(name: "التنس", icon: Icons.sports_tennis_outlined),
  InterestModel(name: "طبخ", icon: Icons.cookie_outlined),
  InterestModel(name: "سباحة", icon: Icons.sports_handball_outlined),
  InterestModel(name: "ركض", icon: Icons.sports_handball_sharp),
  InterestModel(name: "السفر", icon: Iconsax.trade),
  InterestModel(name: "فن", icon: Iconsax.archive_tick),
  InterestModel(name: "موسيقى", icon: Iconsax.music),
  InterestModel(name: "أقصى", icon: Icons.diamond_outlined),
  InterestModel(name: "ألعاب الفيديو", icon: Iconsax.game),
  InterestModel(name: "قراءة", icon: Iconsax.book_1),
];