import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/guide/guide_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_export.dart';
import '../navigation_screen/controller/bottom_bar_controller.dart';
import 'guide_controller.dart';

class GuideDialog extends StatelessWidget {
  final bottomBarController = BottomBarController.instance;
  final guideController = GuideController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!guideController.showGuide.value) return const SizedBox();

      final index = bottomBarController.selectedIndex.value;
      guideController.currentGuidePage.value = index;
      final guideTexts = guideController.pageGuides[index] ?? [];
      final media = MediaQuery.of(context);
      final iconOffset =
          (media.size.width / bottomBarController.bottomMenuList.length * index) +
              (media.size.width / bottomBarController.bottomMenuList.length) / 2 -
              20;

      return Stack(
        children: [
          Positioned(
            bottom: 80,
            left: iconOffset,
            child: const AnimatedArrowHint(),
          ),
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: GuideBubble(guideTexts: guideTexts),
          ),
        ],
      );
    });
  }
}

class GuideBubble extends StatelessWidget {
  final List<String> guideTexts;
  final guideController = GuideController.instance;

  GuideBubble({required this.guideTexts});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedScale(
        scale: 1,
        duration: const Duration(milliseconds: 400),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => guideController.closeCurrentGuide(),
                    child: const Icon(Icons.close, size: 28, color: Colors.black),
                  ),
                ],
              ),
              CarouselSlider(
                items: guideTexts
                    .map((text) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ))
                    .toList(),
                options: CarouselOptions(
                  height: 90,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (i, _) =>
                  guideController.currentStep.value = i,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  guideTexts.length,
                      (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == guideController.currentStep.value
                          ? TColors.yellowAppDark
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButtonContainer(
                height: 60.v,
                width: Get.width * 0.3,
                text: "التالي",
                color1: TColors.greenAccept,
                color2: TColors.greenAccept,
                borderRadius: 10,
                colorText: TColors.white,
                fontSize: 20.adaptSize,
                onPressed: () => guideController.nextStep(guideTexts),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class AnimatedArrowHint extends StatefulWidget {
  const AnimatedArrowHint({super.key});

  @override
  State<AnimatedArrowHint> createState() => _AnimatedArrowHintState();
}

class _AnimatedArrowHintState extends State<AnimatedArrowHint>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _animation.value),
        child: Icon(Icons.arrow_drop_up,
            size: 40, color: TColors.yellowAppDark.withOpacity(0.8)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/*
class GuideDialog extends StatelessWidget {
  final bottomBarController = BottomBarController.instance;
  final guideController = GuideController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!guideController.showGuide.value) return const SizedBox();

      final index = bottomBarController.selectedIndex.value;
      final guideTexts = guideController.pageGuides[index] ?? [];
      final media = MediaQuery.of(context);
      final iconOffset = (media.size.width / 3 * index) + 30;

      return Stack(
        children: [
          // Flèche animée
          Positioned(
            bottom: 1,
            left: iconOffset,
            child: AnimatedArrowHint(index: index,),
          ),

          // Container de guide
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: GuideBubble(guideTexts: guideTexts, index: index, guideController: guideController),
          ),
        ],
      );
    });
  }
}

class GuideBubble extends StatelessWidget {
  final List<String> guideTexts;
  final int index;
  final GuideController guideController;

  GuideBubble({required this.guideTexts, required this.index, required this.guideController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  TextButton(
                    onPressed: guideController.markGuideAsSeen,
                    child: Icon(Icons.close, color: Colors.black, size: 30)
                  ),
                ],
              ),
              CarouselSlider(
                items: guideTexts
                    .map((text) => Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ))
                    .toList(),
                options: CarouselOptions(
                  height: 80,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (i, _) => guideController.currentStep.value = i,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      guideTexts.length,
                          (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == guideController.currentStep.value
                              ? TColors.yellowAppDark
                              : TColors.white,
                        ),
                      ),
                    ),
                  ),
                  CustomButtonContainer(
                      height: 60.v,
                      width: Get.width * 0.3,
                      text: "التالي",
                      color1: TColors.greenAccept,
                      color2: TColors.greenAccept,
                      borderRadius: 10,
                      colorText: TColors.white,
                      fontSize: 20.adaptSize,
                      onPressed: () {
                        if (guideController.currentStep.value <
                            guideTexts.length - 1) {
                          guideController.nextStep(guideTexts.length);
                        } else {
                          guideController.markGuideAsSeen();
                        }
                      }
                  ),
                ],
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    });
  }
}

class AnimatedArrowHint extends StatefulWidget {
  final int index;
  const AnimatedArrowHint({super.key, required this.index});

  @override
  State<AnimatedArrowHint> createState() => _AnimatedArrowHintState();
}

class _AnimatedArrowHintState extends State<AnimatedArrowHint>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0, end: -15).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(1, _animation.value),
          child: Icon(Icons.arrow_drop_up, size: 40, color: Colors.blue),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
*/
