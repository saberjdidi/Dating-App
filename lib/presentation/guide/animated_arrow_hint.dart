import 'package:dating_app_bilhalal/presentation/guide/app_guide_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedArrowHint extends StatefulWidget {
  final int currentIndex;
  final int itemCount;
  final double arrowSize;
  final double bottomOffset;

  const AnimatedArrowHint({
    Key? key,
    required this.currentIndex,
    this.itemCount = 5,
    this.arrowSize = 44,
    this.bottomOffset = 90, // ajuste selon ton bottom bar height
  }) : super(key: key);

  @override
  State<AnimatedArrowHint> createState() => _AnimatedArrowHintState();
}

class _AnimatedArrowHintState extends State<AnimatedArrowHint> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: Duration(milliseconds: 900))..repeat(reverse: true);
    _anim = Tween<double>(begin: -6, end: -18).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  double _calcLeft(BuildContext ctx, int index) {
    final w = MediaQuery.of(ctx).size.width;
    final itemWidth = w / widget.itemCount;
    final arrowW = widget.arrowSize;
    final rtl = Directionality.of(ctx) == TextDirection.rtl;

    double center;
    if (!rtl) {
      center = itemWidth * index + itemWidth / 2 - arrowW / 2;
    } else {
      center = w - (itemWidth * index + itemWidth / 2) - arrowW / 2;
    }
    return center.clamp(8.0, w - arrowW - 8.0);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        final left = _calcLeft(context, widget.currentIndex);
        return Positioned(
          bottom: widget.bottomOffset + _anim.value + bottomPad,
          left: left,
          child: Transform.rotate(
            angle: math.pi, // pointe vers le bas
            child: Container(
              width: widget.arrowSize,
              height: widget.arrowSize,
              alignment: Alignment.center,
              child: Icon(Icons.arrow_drop_down_rounded, size: widget.arrowSize, color: Colors.amber),
            ),
          ),
        );
      },
    );
  }
}
