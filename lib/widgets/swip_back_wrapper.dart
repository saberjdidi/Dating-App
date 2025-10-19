import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Type d’action à effectuer lors du retour
enum SwipeBackAction {
  getBack,
  navigatorPop,
  systemPop,
}

class SwipeBackWrapper extends StatefulWidget {
  final Widget child;
  final bool enableSwipe;
  final double triggerDistance; // distance (en px) pour déclencher le retour
  final SwipeBackAction actionType; // Type d’action au retour

  const SwipeBackWrapper({
    super.key,
    required this.child,
    this.enableSwipe = true,
    this.triggerDistance = 100,
    this.actionType = SwipeBackAction.getBack, // par défaut : Get.back()
  });

  @override
  State<SwipeBackWrapper> createState() => _SwipeBackWrapperState();
}

class _SwipeBackWrapperState extends State<SwipeBackWrapper> {
  double _dragDelta = 0.0;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!widget.enableSwipe) return;

    // On veut swipe vers la DROITE → delta.dx négatif
    _dragDelta += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!widget.enableSwipe) return;

    final bool canPop = Navigator.canPop(context);

    if (!canPop && widget.actionType != SwipeBackAction.systemPop) {
      _dragDelta = 0;
      return;
    }

    // Swipe vers la GAUCHE pour revenir (delta négatif)
    if (_dragDelta < -widget.triggerDistance) {
      _performBackAction();
    }

    _dragDelta = 0.0;
  }

  /// Exécute le type de retour configuré
  void _performBackAction() {
    switch (widget.actionType) {
      case SwipeBackAction.getBack:
        Get.back();
        break;
      case SwipeBackAction.navigatorPop:
        Navigator.of(context).pop();
        break;
      case SwipeBackAction.systemPop:
        SystemNavigator.pop();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: widget.child,
    );
  }
}


/*
class SwipeBackWrapper extends StatefulWidget {
  final Widget child;
  final bool enableSwipe;
  final double triggerDistance; // distance px to trigger pop
  const SwipeBackWrapper({
    super.key,
    required this.child,
    this.enableSwipe = true,
    this.triggerDistance = 100,
  });

  @override
  State<SwipeBackWrapper> createState() => _SwipeBackWrapperState();
}

class _SwipeBackWrapperState extends State<SwipeBackWrapper> {
  double _dragDelta = 0.0;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!widget.enableSwipe) return;
    // details.delta.dx > 0 : swipe to right
    _dragDelta += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!widget.enableSwipe) return;

    final bool canPop = Navigator.canPop(context);
    if (!canPop) {
      _dragDelta = 0;
      return;
    }

    // If app uses RTL and you want swipe right = back, keep as is.
    // If you want "swipe toward leading edge", you can check Directionality.
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    // For simplicity: treat positive delta as swipe right.
    if (_dragDelta > widget.triggerDistance) {
      Get.back();
    } else if (_dragDelta < -widget.triggerDistance) {
      // optionally support swipe left -> back in some flows
      // Get.back();
    }
    _dragDelta = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: widget.child,
    );
  }
}
*/
