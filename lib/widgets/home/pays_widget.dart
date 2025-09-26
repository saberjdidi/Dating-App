import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
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
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                        fit: BoxFit.fill,
                      ),
                    SizedBox(width: 5.adaptSize),
                    Flexible(
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
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
                  border: Border.all(color: Colors.blueGrey, width: 1),
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

///Method 2, pas l'alignement vertical des checkbox
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
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        //height: isTablet ? 20.hw : 52.hw,
        width: Get.width * 0.4,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                /*  ClipOval(
                    child: Image.asset(
                      imagePath,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 5), */
                  imagePath == ImageConstant.logo
                  ? SizedBox.shrink()
                  : CustomImageView(
                    imagePath: imagePath,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 5.adaptSize),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: isSelected ? TColors.yellowAppDark : Colors.transparent, // Blue background if selected
                  borderRadius: BorderRadius.circular(6), // Rounded corners
                ),
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => onTap(),
                  activeColor: Colors.white, // The fill color of the checkbox itself
                  checkColor: TColors.yellowAppDark,  // The color of the checkmark
                  side: BorderSide(color: Colors.blueGrey, width: 1), // Optional border for unselected
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */