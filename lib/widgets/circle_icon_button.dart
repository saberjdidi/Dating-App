import 'dart:math' as math;
import 'package:flutter/material.dart';

/// CircleIconButton : widget réutilisable, centré, accessible et responsive.
/// - size : taille visuelle du cercle (peut être < minTap, on respectera minTap)
/// - child : widget personnalisé (Icon, Image, Svg, Text, etc.)
/// - backgroundColor, onTap, minTapSize : hit area minimale (48 logical px recommandé)
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    Key? key,
    required this.child,
    this.size = 48.0,
    this.backgroundColor,
    this.onTap,
    this.minTapSize = 48.0,
    this.tooltip,
  }) : super(key: key);

  /// Widget affiché au centre (Icon, Image.asset, Text, etc.)
  final Widget child;

  /// Taille visuelle du cercle
  final double size;

  /// Couleur de fond du cercle
  final Color? backgroundColor;

  /// Callback lorsque l’on clique sur le bouton
  final VoidCallback? onTap;

  /// Taille minimale pour accessibilité
  final double minTapSize;

  /// Info-bulle affichée au survol / appui long
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    // garantit une zone tactile minimale
    final double effectiveMin = math.max(minTapSize, 48.0);
    final double visualSize = size;
    final double containerSize = visualSize < effectiveMin ? effectiveMin : visualSize;

    final Widget content = Material(
      color: backgroundColor ?? Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: containerSize,
            minHeight: containerSize,
            maxWidth: containerSize,
            maxHeight: containerSize,
          ),
          child: Center(child: child),
        ),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(message: tooltip!, child: content);
    }
    return content;
  }
}
