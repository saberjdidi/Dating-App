import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class InterestModel {
  String? id;
   String? name;
  IconData? icon;
  String? createdAt;
  String? updatedAt;
  //final String icon;
  InterestModel({
    this.id,
     this.name,
     this.icon,
    this.createdAt,
    this.updatedAt
  });

  // Fonction pour obtenir l'icône à partir du nom
  static IconData getIconByName(String? name) {
    try {
      return interestsList.value.firstWhere((e) => e.name == name).icon!;
    } catch (e) {
      return Icons.help_outline; // Icône par défaut si non trouvé
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InterestModel &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  InterestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

Rx<List<InterestModel>> interestsList = Rx([
  InterestModel(name: "التسوق", icon: Icons.shopping_bag_outlined),
  InterestModel(name: "فوتوغرافيا", icon: Icons.camera_alt_outlined),
  InterestModel(name: "اليوغا", icon: Iconsax.colorfilter),
  InterestModel(name: "كاريوكي", icon: Icons.keyboard_voice_outlined),
  InterestModel(name: "التنس", icon: Icons.sports_tennis_outlined),
  InterestModel(name: "طبخ", icon: Icons.cookie_outlined),
  InterestModel(name: "سباحة", icon: Iconsax.wind_2),
  InterestModel(name: "ركض", icon: Icons.sports_handball_sharp),
  InterestModel(name: "السفر", icon: Iconsax.trade),
  InterestModel(name: "فن", icon: Iconsax.magicpen),
  InterestModel(name: "موسيقى", icon: Iconsax.music),
  InterestModel(name: "ألعاب الفيديو", icon: Iconsax.game),
  InterestModel(name: "قراءة", icon: Iconsax.book_1),
  InterestModel(name: "كرة القدم", icon: Icons.sports_score_outlined),
  InterestModel(name: "الشطرنج", icon: Icons.spoke),
  InterestModel(name: "الاسترخاء", icon: Icons.chair_outlined),
  InterestModel(name: "الرفاهية", icon: Icons.luggage_outlined),
]);