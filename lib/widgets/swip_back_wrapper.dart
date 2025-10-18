import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwipeBackWrapper extends StatelessWidget {
  final Widget child;
  final bool enableSwipe;

  const SwipeBackWrapper({
    super.key,
    required this.child,
    this.enableSwipe = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (!enableSwipe) return;
        // Si le swipe est vers la droite → revenir en arrière
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          if (Navigator.canPop(context)) {
            Get.back();
          }
        }
      },
      child: child,
    );
  }
}
