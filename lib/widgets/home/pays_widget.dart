import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

///Method 1, design 2
class PaysWidget extends StatelessWidget {
  final String text;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const PaysWidget({
    super.key,
    required this.text,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils.getTheme();

    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
        width: Get.width * 0.4,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Colonne pour l'image + texte
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5.adaptSize),
                    if (imagePath != ImageConstant.logo)
                      CustomImageView(
                        imagePath: imagePath,
                        height: 25.adaptSize,
                        width: 25.adaptSize,
                        fit: BoxFit.fill,
                      ),
                    SizedBox(width: 5.adaptSize),
                    Flexible(
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _appTheme =='light' ? TColors.black : TColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.adaptSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Colonne pour la checkbox custom
              Container(
                height: 30.adaptSize,
                width: 30.adaptSize,
                //margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey : Colors.transparent,
                  border: Border.all(color: _appTheme =='light' ? Colors.blueGrey : TColors.white, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 18, color: TColors.yellowAppDark)
                    : null,
              ),
              SizedBox(width: 20.hw,)
            ],
          ),
        ),
      ),
    );
  }
}

///Method 2, design 1
/*
class PaysWidget extends StatelessWidget {
  final String text;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const PaysWidget({
    super.key,
    required this.text,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var _appTheme = PrefUtils.getTheme();

    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
        width: Get.width * 0.4,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Colonne pour l'image + texte
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5.adaptSize),
                    if (imagePath != ImageConstant.logo)
                      CustomImageView(
                        imagePath: imagePath,
                        height: 25.adaptSize,
                        width: 25.adaptSize,
                        fit: BoxFit.fill,
                      ),
                    SizedBox(width: 5.adaptSize),
                    Flexible(
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _appTheme =='light' ? TColors.black : TColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.adaptSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Colonne pour la checkbox custom
              Container(
                height: 30.adaptSize,
                width: 30.adaptSize,
                //margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey : Colors.transparent,
                  border: Border.all(color: _appTheme =='light' ? Colors.blueGrey : TColors.white, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 18, color: TColors.yellowAppDark)
                    : null,
              ),
              SizedBox(width: 20.hw,)
            ],
          ),
        ),
      ),
    );
  }
}
*/