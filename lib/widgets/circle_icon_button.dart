import 'dart:math' as math;
import 'package:flutter/material.dart';

/// CircleIconButton : widget réutilisable, centré, accessible et responsive.
/// - size : taille visuelle du cercle (peut être < minTap, on respectera minTap)
/// - child : widget personnalisé (Icon, Image, Svg, Text, etc.)
/// - backgroundColor, onTap, minTapSize : hit area minimale (48 logical px recommandé)

///CircleIconButton with border
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    Key? key,
    required this.child,
    this.size = 40.0,
    this.backgroundColor,
    this.onTap,
    this.minTapSize = 40.0,
    this.effectiveSize = 40.0,
    this.tooltip,
    this.showBorder = false,
    this.borderWidth = 1,
    this.borderColor,
  }) : super(key: key);

  /// Widget affiché au centre (Icon, Image, etc.)
  final Widget child;

  /// Taille visuelle du cercle
  final double size;

  /// Couleur de fond du cercle
  final Color? backgroundColor;

  /// Callback lorsque l’on clique sur le bouton
  final VoidCallback? onTap;

  /// Taille minimale pour accessibilité
  final double minTapSize;

  final double effectiveSize;

  /// Info-bulle affichée au survol / appui long
  final String? tooltip;

  /// Afficher ou non la bordure circulaire
  final bool showBorder;

  /// Largeur de la bordure circulaire
  final double borderWidth;

  /// Couleur de la bordure (par défaut noir)
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final double effectiveMin = math.max(minTapSize, effectiveSize);
    final double visualSize = size;
    final double containerSize =
    visualSize < effectiveMin ? effectiveMin : visualSize;

    final Widget content = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Colors.transparent,
        border: showBorder
            ? Border.all(
          color: borderColor ?? Colors.black.withOpacity(0.4),
          width: borderWidth,
        )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
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
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(message: tooltip!, child: content);
    }
    return content;
  }
}

///CircleIconButton without border
/*
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    Key? key,
    required this.child,
    this.size = 40.0,
    this.backgroundColor,
    this.onTap,
    this.minTapSize = 40.0,
    this.effectiveSize = 40.0,
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

  final double effectiveSize;

  /// Info-bulle affichée au survol / appui long
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    // garantit une zone tactile minimale
    final double effectiveMin = math.max(minTapSize, effectiveSize);
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
*/