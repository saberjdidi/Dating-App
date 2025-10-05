import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';



class AppGuideDialog extends StatelessWidget {
  final BottomBarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.showGuide.value) return const SizedBox.shrink();

      final guide = controller.pageGuides[controller.selectedIndex.value]!;
      final message =
      guide.messages[controller.currentMessageIndex.value];

      return Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    guide.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.nextGuideMessage,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    child: const Text("التالي"),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

/*
class AppGuideDialog extends StatelessWidget {
  final controller = Get.find<BottomBarController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.showGuide.value) return const SizedBox.shrink();

      final text = controller.guideTexts[controller.currentGuideStep.value];
      return Positioned.fill(
        child: GestureDetector(
          onTap: controller.nextGuideStep,
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
 */


