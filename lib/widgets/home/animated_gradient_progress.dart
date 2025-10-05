import 'package:flutter/material.dart';

class AnimatedGradientProgressWidget extends StatefulWidget {
  final double progress;
  const AnimatedGradientProgressWidget({Key? key, required this.progress})
      : super(key: key);

  @override
  State<AnimatedGradientProgressWidget> createState() =>
      _AnimatedGradientProgressWidgetState();
}

class _AnimatedGradientProgressWidgetState extends State<AnimatedGradientProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animation continue pour le dégradé
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // Fond gris ou blanc selon le thème
              Container(
                height: 6,
                color: Colors.white24,
              ),

              // Dégradé animé selon le progress
              FractionallySizedBox(
                widthFactor: widget.progress.clamp(0.0, 1.0),
                alignment: Alignment.centerLeft,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment(-1.0 + _controller.value * 2, 0),
                      end: Alignment(1.0 + _controller.value * 2, 0),
                      colors: const [
                        Color(0xFFFF6F61),
                        Color(0xFFFF8E53),
                        Color(0xFFFF2D55),
                      ],
                    ).createShader(rect);
                  },
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF6F61),
                          Color(0xFFFF8E53),
                          Color(0xFFFF2D55),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
