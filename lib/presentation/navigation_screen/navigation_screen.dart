import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/chat_screen.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/favorite_screen.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/filter_screen.dart';
import 'package:dating_app_bilhalal/presentation/guide/animated_arrow_hint.dart';
import 'package:dating_app_bilhalal/presentation/guide/animated_arrow_hint2.dart';
import 'package:dating_app_bilhalal/presentation/guide/app_guide_dialog.dart';
import 'package:dating_app_bilhalal/presentation/guide/app_guide_dialog2.dart';
import 'package:dating_app_bilhalal/presentation/guide/guide_dialog.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/main_screen.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/navigation_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/custom_bottom_bar.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends GetWidget<NavigationController> {

  NavigationScreen({Key? key}) : super(key: key);

  var _appTheme = PrefUtils.getTheme();
  final GlobalKey<ScaffoldState> _scaffoldNavigationKey = GlobalKey<ScaffoldState>();

  @override Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final bottomCtrl = BottomBarController.instance; // si pas déjà injecté
    //final bottomCtrl = Get.put(BottomBarController()); // si pas déjà injecté
    // initialise la logique "montrer guide 1 fois"
    //bottomCtrl.initGuideAutoShowIfNeeded();

    final pages = [
      const Center(child: Text("🏠 Home Page")),
      const Center(child: Text("❤️ Favoris Page")),
       ProfileScreen(),
    ];

    return SafeArea(
        child: Scaffold(
            key: _scaffoldNavigationKey,
            //backgroundColor:PrefUtils.getTheme() =='light' ? TColors.lightContainer : appTheme.primaryColor,
            body: Stack(
              children: [
                Navigator(
                    key: Get.nestedKey(1),
                    initialRoute: Routes.filterScreen,
                    onGenerateRoute: (routeSetting) => GetPageRoute(
                        page: () => getCurrentPage(routeSetting.name!),
                        transition: Transition.noTransition)
                ),
                //Obx(() => pages[bottomCtrl.selectedIndex.value]),
                GuideDialog(),
                // Flèche animée (au dessus de l'icône active) - visible seulement si showArrow true
               /*  Obx(() {
                  return bottomCtrl.showArrow.value
                      ? AnimatedArrowHint(currentIndex: bottomCtrl.selectedIndex.value, itemCount: 5, arrowSize: 44, bottomOffset: 80)
                      : SizedBox.shrink();
                }),
                // dialog guide (unique instance)
                AppGuideDialog(maxWidth: 360, containerHeight: 150, bottomItemCount: 5),
                 */
                /*
                // 👇 Flèche animée au-dessus du bottom bar
                AnimatedArrowHint2(),
                // 👇 Guide interactif
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: AppGuideDialog2()
                ), // 👈 guide superposé
                */
              ],
            ),
            bottomNavigationBar: _buildBottomBar()
        ));
  }
  /// Section Widget
  Widget _buildBottomBar() {
    return CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Get.offAllNamed(getCurrentRoute(type), id: 1);
          //Get.toNamed(getCurrentRoute(type), id: 1);
        });
  }
  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.search:
        return Routes.filterScreen;
      case BottomBarEnum.discussion:
        return Routes.chatScreen;
      case BottomBarEnum.main:
        return Routes.mainScreen;
      case BottomBarEnum.favoris:
        return Routes.favoriteScreen;
      case BottomBarEnum.Profile:
        return Routes.profileScreen;
      default: return "/";
    }
  }
  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case Routes.filterScreen:
        return FilterScreen();
      case Routes.chatScreen:
        return ChatScreen();
      case Routes.mainScreen:
        return MainScreen();
      case Routes.favoriteScreen:
        return FavoriteScreen();
      case Routes.profileScreen:
        return ProfileScreen();
      default: return DefaultWidget();
    }
  }

}