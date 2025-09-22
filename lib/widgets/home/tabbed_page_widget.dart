import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabItem {
  final String title;
  TabItem(this.title);
}

class TabbedPageController extends GetxController {
  var selectedIndex = 0.obs;
}

class TabbedPageWidget extends StatelessWidget {
  final List<TabItem> tabs;
  final Function(int) onTabChanged;
  final Color activeColor;
  final Color inactiveColor;

  final TabbedPageController controller = Get.put(TabbedPageController());

  TabbedPageWidget({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    this.activeColor = TColors.yellowAppDark,
    this.inactiveColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(tabs.length, (index) {
        bool isActive = controller.selectedIndex.value == index;
        return GestureDetector(
          onTap: () {
            controller.selectedIndex.value = index;
            onTabChanged(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              color: isActive ? TColors.yellowAppLight.withOpacity(0.1) : TColors.greyDating.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tabs[index].title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ),
        );
      }),
    ));
  }
}
