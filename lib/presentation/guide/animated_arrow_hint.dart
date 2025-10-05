import 'package:dating_app_bilhalal/presentation/guide/app_guide_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedArrowHint extends StatelessWidget {
  final BottomBarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.showGuide.value) return const SizedBox.shrink();

      final offsetX = controller.getArrowXOffset(context);

      return Positioned(
        bottom: 65, // juste au-dessus du BottomNavigationBar
        left: offsetX,
        child: const _AnimatedArrow(),
      );
    });
  }
}

class _AnimatedArrow extends StatefulWidget {
  const _AnimatedArrow();

  @override
  State<_AnimatedArrow> createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends State<_AnimatedArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.3, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child:
      const Icon(Icons.arrow_drop_up, color: Colors.blueAccent, size: 35),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}