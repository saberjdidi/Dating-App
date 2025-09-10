import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomButtonContainer extends StatelessWidget {
   CustomButtonContainer({
    super.key,
    required this.text,
    required this.color1,
    required this.color2,
    required this.borderRadius,
     this.paddingHorizontal = 10,
     this.paddingVertical = 12,
     this.fontSize,
    required this.colorText,
     this.textAlign,
    this.onPressed,
     this.width = 400,
     this.height = 50,
  });

  final String text;
  final Color color1;
  final Color color2;
  final double borderRadius;
  final double paddingHorizontal;
  final double paddingVertical;
  double? fontSize;
  final Color colorText;
  TextAlign? textAlign;
  VoidCallback? onPressed;
   final double? width;
   final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color1,
                color2,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
            child: Center(
              child: Text( text,
                style: TextStyle(
                  color: colorText,
                  fontSize: fontSize ?? 16.adaptSize,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign ?? TextAlign.left,
              ),
            ),
          )
      ),
    );
  }
}
