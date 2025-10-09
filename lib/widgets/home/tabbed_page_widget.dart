import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/gradient_tabbed_text.dart';
import 'package:dating_app_bilhalal/widgets/gradient_text.dart';
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
    var _appTheme = PrefUtils.getTheme();

    return Obx(() =>
        //SingleChildScrollView(scrollDirection: Axis.horizontal,
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(tabs.length, (index) {
        bool isActive = controller.selectedIndex.value == index;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              controller.selectedIndex.value = index;
              onTabChanged(index);
            },
            ///Ligne design of Text
            child: IntrinsicWidth( //using with Text
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GradientTabbedText(
                    text: tabs[index].title,
                    fontSize: isTablet ? 24.adaptSize : isSmallPhone ? 18.adaptSize : 19.adaptSize,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    gradient: LinearGradient(
                      colors: isActive ? [TColors.yellowAppDark, Color(0xFFF4AB03)]
                          : _appTheme =='light' ? [TColors.black, TColors.black] : [TColors.white, TColors.white], // green gradient
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    maxLines: 2,
                  ),
               /* Text(
                    tabs[index].title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isActive ? activeColor : inactiveColor,
                    ),
                    maxLines: 2,
                  ), */
                  //const SizedBox(height: 4),
                  // Ligne seulement si actif
                  if (isActive)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(top: 3),
                      height: 2,
                      width: isActive ? 60 : 0, // largeur animée
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            TColors.yellowAppDark,
                            Color(0xFFF4AB03),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    )
                   /* Container(
                      margin: const EdgeInsets.only(top: 3),
                      height: 2,
                      width: tabs[index].title.length > 10 ? 80 : 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            TColors.yellowAppDark,
                            Color(0xFFF4AB03),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ), */
                 /* if (isActive)
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      height: 2,
                      //width: tabs[index].title.length  > 10 ? 80 : 40,
                      color: activeColor,
                    ), */
                ],
              ),
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
          ),
        );
      }),
    ));
  }
}
