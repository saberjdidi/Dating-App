import 'dart:math';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class InterestWidget extends StatelessWidget {
  final String text;
  final IconData iconPath;
  final bool isSelected;
  final bool activeColor;
  final VoidCallback onTap;
  final double verticalPadding;
  final bool showRandomColor;
  final List<Color>? randomList;

  const InterestWidget({
    super.key,
    required this.text,
    required this.iconPath,
    required this.isSelected,
    this.activeColor = true,
    required this.onTap,
    this.verticalPadding = 10,
    this.showRandomColor = false,
    this.randomList,
  });

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils.getTheme();

    // ✅ Choisir une couleur aléatoire si activé
    final Color? randomColor = (showRandomColor && randomList != null && randomList!.isNotEmpty)
        ? randomList![Random().nextInt(randomList!.length)]
        : null;

    final Color backgroundColor = isSelected
        ? (activeColor
        ? (showRandomColor ? (randomColor ?? TColors.primaryColorApp) : TColors.primaryColorApp)
        : TColors.greyDating)
        : (showRandomColor ? (randomColor ?? TColors.white) : TColors.white);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: 12, // ✅ un padding horizontal cohérent
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          //color: isSelected ? (activeColor ? TColors.primaryColorApp : TColors.greyDating) : TColors.white,
          border: Border.all(
            color: isSelected
                ? (activeColor ? TColors.primaryColorApp : TColors.greyDating)
                : TColors.greyDating,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // ✅ s’adapte au contenu
          children: [
            Icon(
              iconPath,
              size: 22,
              color: isSelected
                  ? (activeColor
                  ? TColors.black
                  : (_appTheme == 'light' ? TColors.black : TColors.darkerGrey))
                  : (_appTheme == 'light' ? TColors.black : TColors.darkerGrey),
              //color: isSelected ? (activeColor ? TColors.black : (_appTheme == 'light' ? TColors.black : TColors.darkerGrey)) : (_appTheme == 'light' ? TColors.black : TColors.darkerGrey),
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? (activeColor
                    ? TColors.black
                    : (_appTheme == 'light' ? TColors.black : TColors.darkerGrey))
                    : (_appTheme == 'light' ? TColors.black : TColors.darkerGrey),
                //color: isSelected ? (activeColor ? TColors.black : (_appTheme == 'light' ? TColors.black : TColors.darkerGrey)) : (_appTheme == 'light' ? TColors.black : TColors.darkerGrey),
                fontWeight: FontWeight.bold,
                fontSize: 16, // ✅ taille équilibrée pour toutes les longueurs
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class InterestWidget extends StatelessWidget {
  final String text;
  final IconData iconPath;
  final bool isSelected;
  final bool activeColor;
  final VoidCallback onTap;
  final double verticalPadding;

  const InterestWidget({
    super.key,
    required this.text,
    required this.iconPath,
    required this.isSelected,
    this.activeColor = true,
    required this.onTap,
    this.verticalPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils.getTheme();

    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        //height: isTablet ? 20.hw : 52.hw,
        width: Get.width * 0.4,
        //margin: EdgeInsets.only(top: 5),
          showBorder: true,
          backgroundColor: isSelected
              ? activeColor ? TColors.yellowAppDark : TColors.greyDating
              : TColors.white,
          borderColor: isSelected
              ? activeColor ? TColors.primaryColorApp : TColors.greyDating
              : TColors.greyDating,
          radius: 15,
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 8.hw),
          margin: EdgeInsets.symmetric(vertical: 10.adaptSize, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 3.adaptSize,),
              Icon(iconPath, size: 30.adaptSize, color: isSelected
                  ?  activeColor ? TColors.black : (_appTheme =='light' ? TColors.black : TColors.darkerGrey)
                  : _appTheme =='light' ? TColors.black : TColors.darkerGrey),
              //Image.asset(iconPath, height: 20, width: 20), // Icône
               SizedBox(width: 8.hw),
              Text(
                text,
                style: TextStyle(
                    color: isSelected
                        ? activeColor ? TColors.black : (_appTheme =='light' ? TColors.black : TColors.darkerGrey)
                        : _appTheme =='light' ? TColors.black : TColors.darkerGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.adaptSize
                ),
              ),
            ],
          ),
      ),
    );
  }
}
 */