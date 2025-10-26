import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/helpers/helper_functions.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    this.size = 30,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final double size;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final color = ColorFunctions.getColor(text);

    final isColor = color != null;

    return SizedBox(
      width: size + 6,
      height: size + 6,
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? Colors.white : null),
        avatar: isColor
            ? CircularContainerColor(
          width: size,
          height: size,
          radius: size,
          backgroundColor: color,
        )
            : null,
        shape: isColor ? const CircleBorder() : null,
        labelPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

class CircularContainerColor extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color backgroundColor;

  const CircularContainerColor({
    super.key,
    required this.width,
    required this.height,
    required this.radius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class ColorFunctions {
  static Color? getColor(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Colors.white; // ✅ couleur par défaut
    }

    // ✅ Gestion des couleurs hexadécimales (#fff, #ffffff, #ffffffff)
    if (value.startsWith('#')) {
      try {
        String hex = value.replaceAll('#', '');

        // Supporte #fff -> #ffffff
        if (hex.length == 3) {
          hex = hex.split('').map((c) => '$c$c').join();
        }

        // Si format ARGB (#ffffffff), pas besoin de changer, sinon ajouter FF pour l’opacité
        if (hex.length == 6) {
          hex = 'ff$hex';
        }

        return Color(int.parse(hex, radix: 16));
      } catch (e) {
        return Colors.white; // fallback
      }
    }

    // ✅ Gestion des noms standards
    switch (value.toLowerCase()) {
      case 'fair':
        return const Color(0xFFFFE0BD);
      case 'light':
        return const Color(0xFFFFD1A4);
      case 'light2':
        return const Color(0xFFFFC28B);
      case 'medium':
        return const Color(0xFFE0AC69);
      case 'olive':
        return const Color(0xFFC68642);
      case 'brown':
        return const Color(0xFF8D5524);
      case 'tan':
        return const Color(0xFFD2B48C);
      case 'deep':
        return const Color(0xFF5C4033);
      default:
        return Colors.white; // ✅ fallback
    }
  }
}


class TChoiceChip2 extends StatelessWidget {
  const TChoiceChip2({
    super.key,
    required this.text,
    this.size = 30,
    required this.selected,
    this.onSelected
  });

  final String text;
  final double size;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text) != null;

    return SizedBox(
      width: size + 6, // assure une taille constante
      height: size + 6,
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? Colors.white : null),

        avatar: isColor
            ? CircularContainer(width: size, height: size, radius: size, backgroundColor: THelperFunctions.getColor(text)!)
            : null,
        /*
        avatar: CircleAvatar(
          backgroundColor: THelperFunctions.getColor(text)!,
        ),
        */
        shape: isColor ? const CircleBorder() : null,
        labelPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}