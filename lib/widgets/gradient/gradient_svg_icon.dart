import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientSvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final Gradient gradient;

  const GradientSvgIcon({
    Key? key,
    required this.assetPath,
    this.size = 35.0,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      blendMode: BlendMode.srcIn, // 👈 très important
      child: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        color: Colors.white, // 👈 couleur de base remplacée par le gradient
      ),
    );
  }
}