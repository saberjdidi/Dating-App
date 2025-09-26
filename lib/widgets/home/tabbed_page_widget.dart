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
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(tabs.length, (index) {
        bool isActive = controller.selectedIndex.value == index;
        return GestureDetector(
          onTap: () {
            controller.selectedIndex.value = index;
            onTabChanged(index);
          },
          ///Ligne design of Text
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tabs[index].title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? activeColor : inactiveColor,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              // Ligne seulement si actif
              if (isActive)
                Container(
                  height: 2,
                  width: tabs[index].title.length  > 10
                      ? 80
                      : 40,
                  color: activeColor,
                ),
            ],
          ),
          ///Rounded design of Text
         /* child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: isSmallPhone ? 3 : 16),
            decoration: BoxDecoration(
              color: isActive ? TColors.yellowAppLight.withOpacity(0.1) : TColors.greyDating.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tabs[index].title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? activeColor : inactiveColor,
              ),
              maxLines: 2,
            ),
          ), */
        );
      }),
    ));
  }
}
