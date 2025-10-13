
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class ShaderMaskWidget extends StatelessWidget {
  const ShaderMaskWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
      return LinearGradient(
        colors: [TColors.primaryColorApp, Colors.redAccent], // ✅ Dégradé
      ).createShader(bounds);
    },
    child: child,
    );
  }
}
