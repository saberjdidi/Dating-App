import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class PaysWidget extends StatelessWidget {
  final String text;
  final String imagePath;
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
                  CustomImageView(
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
                  checkColor: Colors.black,  // The color of the checkmark
                  side: BorderSide(color: Colors.black, width: 1), // Optional border for unselected
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
