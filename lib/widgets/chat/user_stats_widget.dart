import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/account/choice-chip.dart';
import 'package:flutter/material.dart';

class UserStatsWidget extends StatelessWidget {
  final String height;
  final String weight;
  final String salary;
  final String skinColor;
  final Color dividerColor;
  final double iconSize;
  final TextStyle? textStyle;

   UserStatsWidget({
    Key? key,
    required this.height,
    required this.weight,
    required this.salary,
    required this.skinColor,
    this.dividerColor = Colors.grey,
    this.iconSize = 26,
    this.textStyle,
  }) : super(key: key);

  var _appTheme = PrefUtils.getTheme();

  Widget _buildDivider(Color color, double height) {

    return Container(
      height: height,
      //height: height * 0.7,
      width: 1,
      color: color,
      margin:  EdgeInsets.symmetric(horizontal: 8),
    );
  }

  /// 👇 Définition des couleurs des icônes selon le type
  Color _getIconColor(String imagePath) {
    if (imagePath == ImageConstant.iconHeight) {
      return Colors.green; // ✅ Hauteur = vert
    } else if (imagePath == ImageConstant.iconWeight) {
      return Colors.pinkAccent; // ✅ Poids = rose
    } else if (imagePath == ImageConstant.iconSalary) {
      return Colors.blue; // ✅ Salaire = bleu
    } else {
      return _appTheme == 'light' ? TColors.darkerGrey : TColors.white;
    }
  }

  Widget _buildStatItem(BuildContext context, String text, String imagePath) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 400;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: imagePath,
            color: _getIconColor(imagePath),
            //color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
            height: imagePath == ImageConstant.iconSkinColor ? 30 : (isSmallScreen ? iconSize * 0.8 : iconSize),
            width: imagePath == ImageConstant.iconSkinColor ? 30 : (isSmallScreen ? iconSize * 0.8 : iconSize),
            fit: BoxFit.cover,
          ),
          if (imagePath == ImageConstant.iconSkinColor)
             SizedBox(height: 2)
          else
            SizedBox(height: 6),
          /// Si c’est le champ de couleur → affiche le TChoiceChip
          if (imagePath == ImageConstant.iconSkinColor)
            TChoiceChip(
              text: text,
              size: 30,
              selected: false,
              onSelected: (_) {},
            )
          else
            Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textStyle ??
                  TextStyle(
                    color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                    fontSize: isSmallScreen ? 12 : 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(context, height.toString(), ImageConstant.iconHeight),
          _buildDivider(dividerColor, 50),
          _buildStatItem(context, weight, ImageConstant.iconWeight),
          //_buildDivider(dividerColor, 50),
         // _buildStatItem(context, salary, ImageConstant.iconSalary),
          _buildDivider(dividerColor, 50),
          _buildStatItem(context, skinColor, ImageConstant.iconSkinColor),
        ],
      ),
    );
  }
}

//Method without ChoiceChip
/*
class UserStatsWidget extends StatelessWidget {
  final String height;
  final String weight;
  final String salary;
  final String skinColor;
  final Color dividerColor;
  final double iconSize;
  final TextStyle? textStyle;

  const UserStatsWidget({
    Key? key,
    required this.height,
    required this.weight,
    required this.salary,
    required this.skinColor,
    this.dividerColor = Colors.grey,
    this.iconSize = 26,
    this.textStyle,
  }) : super(key: key);

  Widget _buildStatItem(String text, String imagePath, {bool addDivider = false, Color? dividerColor}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: imagePath,
            height: iconSize,
            width: iconSize,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 6),
          Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textStyle ??
                const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Wrap(
        spacing: 6,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(height, ImageConstant.iconHeight),
          Container(
            height: 30,
            width: 1,
            color: dividerColor,
          ),
          _buildStatItem(weight, ImageConstant.iconWeight),
          Container(
            height: 30,
            width: 1,
            color: dividerColor,
          ),
          _buildStatItem(salary, ImageConstant.iconSalary),
          Container(
            height: 30,
            width: 1,
            color: dividerColor,
          ),
          _buildStatItem(skinColor, ImageConstant.iconSkinColor),
        ],
      ),
    );
  }
}
*/