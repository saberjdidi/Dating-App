import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/chat_screen.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/favorite_screen.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/filter_screen.dart';
import 'package:dating_app_bilhalal/presentation/guide/guide_dialog.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/main_screen.dart';
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
    //final bottomCtrl = BottomBarController.instance; // si pas déjà injecté
    // initialise la logique "montrer guide 1 fois"
    //bottomCtrl.initGuideAutoShowIfNeeded();

    return SafeArea(
        top: false,
        child: Scaffold(
            key: _scaffoldNavigationKey,
            //backgroundColor:PrefUtils.getTheme() =='light' ? TColors.lightContainer : appTheme.primaryColor,
            body: Stack(
              children: [
                Navigator(
                    key: Get.nestedKey(1),
                    initialRoute: Routes.mainScreen,
                    onGenerateRoute: (routeSetting) => GetPageRoute(
                        page: () => getCurrentPage(routeSetting.name!),
                        transition: Transition.noTransition)
                ),
                //Affiche le guide de lapplication
                //GuideDialog(),
              ],
            ),
            bottomNavigationBar: _buildBottomBar()
        ));
  }
  /// Section Widget
  Widget _buildBottomBar() {
    return CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Get.offAllNamed(controller.getCurrentRoute(type), id: 1);
          //Get.toNamed(getCurrentRoute(type), id: 1);
        });
  }
  ///Handling route based on bottom click actions
/*  String getCurrentRoute(BottomBarEnum type) {
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
  } */
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