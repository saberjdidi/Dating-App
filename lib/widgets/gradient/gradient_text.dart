import 'package:flutter/material.dart';

/// A reusable widget that paints text using a linear gradient.
///
/// - `text`: the string to display
/// - `fontSize`, `fontWeight`: typography controls
/// - `textAlign`: TextAlign.left / center / right
/// - `gradient`: optional custom gradient; default is yellow -> red
/// - `maxLines`, `overflow`: usual Text properties
class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Gradient? gradient;
  final int? maxLines;
  final TextOverflow overflow;
  final TextStyle? style;

  const GradientText({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.textAlign = TextAlign.left,
    this.gradient,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.style,
  }) : super(key: key);

  /// Default two-color gradient (yellow -> red)
  Gradient get _defaultGradient => const LinearGradient(
    colors: [Color(0xFFFFEB3B), Color(0xFFFF5252)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    final Gradient usedGradient = gradient ?? _defaultGradient;

    // Wrap in LayoutBuilder so we can create a shader that matches available width
    return LayoutBuilder(builder: (context, constraints) {
      // Fallback width if unconstrained
      final double width = (constraints.maxWidth.isFinite && constraints.maxWidth > 0)
          ? constraints.maxWidth
          : (text.length * fontSize * 0.6).clamp(24.0, 1000.0);

      // Create shader for the computed rect
      final Shader textShader = usedGradient.createShader(Rect.fromLTWH(0, 0, width, fontSize * 1.2));

      final TextStyle effectiveStyle = (style ?? const TextStyle()).copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: TextDecoration.none, // 👈 Supprime le soulignement
        // Paint the text with the shader
        foreground: Paint()..shader = textShader,
      );

      // Map TextAlign to an Align widget so the widget's parent alignment is correct.
      // If you prefer relying on parent constraints, you can remove the Align wrapper.
      Alignment align;
      switch (textAlign) {
        case TextAlign.center:
          align = Alignment.center;
          break;
        case TextAlign.right:
        case TextAlign.end:
          align = Alignment.centerRight;
          break;
        case TextAlign.left:
        case TextAlign.start:
        default:
          align = Alignment.centerLeft;
      }

      return Align(
        alignment: align,
        child: Text(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: effectiveStyle,
        ),
      );
    });
  }
}
