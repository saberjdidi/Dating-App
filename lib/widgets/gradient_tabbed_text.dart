
import 'package:flutter/material.dart';

class GradientTabbedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Gradient? gradient;
  final int? maxLines;
  final TextOverflow overflow;
  final TextStyle? style;

  const GradientTabbedText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.textAlign = TextAlign.left,
    this.gradient,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final Gradient usedGradient = gradient ??
        const LinearGradient(
          colors: [Color(0xFFFFEB3B), Color(0xFFFF5252)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    return ShaderMask(
      shaderCallback: (bounds) => usedGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: (style ?? const TextStyle()).copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white, // couleur ignorée, remplacée par shader
        ),
      ),
    );
  }
}