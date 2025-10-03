import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class InterestWidget extends StatelessWidget {
  final String text;
  final IconData iconPath;
  final bool isSelected;
  final bool activeColor;
  final VoidCallback onTap;

  const InterestWidget({
    super.key,
    required this.text,
    required this.iconPath,
    required this.isSelected,
    this.activeColor = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              ? activeColor ? TColors.yellowAppLight : TColors.greyDating
              : TColors.greyDating,
          radius: 15,
          padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 8.hw),
          margin: EdgeInsets.symmetric(vertical: 10.adaptSize, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 5.adaptSize,),
              Icon(iconPath, size: 35.adaptSize, color: isSelected
                  ?  activeColor ? Colors.white : TColors.black
                  : Colors.black),
            /*  CustomImageView(
                imagePath: iconPath,
                height: 35.adaptSize,
                width: 35.adaptSize,
                fit: BoxFit.fill,
              ), */
              //Image.asset(iconPath, height: 20, width: 20), // Icône
               SizedBox(width: 10.hw),
              Text(
                text,
                style: TextStyle(
                    color: isSelected
                        ? activeColor ? Colors.white : TColors.black
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.adaptSize
                ),
              ),
            ],
          ),
      ),
    /*  child: Container(
        width: Get.width * 0.4,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow.shade700 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomImageView(
              imagePath: iconPath,
              height: 40.adaptSize,
              width: 40.adaptSize,
              fit: BoxFit.fill,
            ),
            //Image.asset(iconPath, height: 20, width: 20), // Icône
            //const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.adaptSize
              ),
            ),
          ],
        ),
      ), */
    );
  }
}