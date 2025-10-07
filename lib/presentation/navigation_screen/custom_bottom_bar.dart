import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:dating_app_bilhalal/presentation/settings_screen/controller/theme_controller.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends GetView<BottomBarController> { //StatelessWidget
  CustomBottomBar({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  var _appTheme = PrefUtils.getTheme();
  //RxInt selectedIndex = 0.obs;
/*
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.searchImg,
      activeIcon: ImageConstant.searchImg,
      title: "بحث".tr,
      type: BottomBarEnum.search,
    ),
    BottomMenuModel(
      icon: ImageConstant.discussionImg,
      activeIcon: ImageConstant.discussionImg,
      title: "محادثة".tr,
      type: BottomBarEnum.discussion,
    ),
    BottomMenuModel(
      icon: ImageConstant.mainImg,
      activeIcon: ImageConstant.mainImg,
      title: "الکل".tr,
      type: BottomBarEnum.main,
    ),
    BottomMenuModel(
      icon: ImageConstant.likeImg,
      activeIcon: ImageConstant.likeImg,
      title: "المفضلة".tr,
      type: BottomBarEnum.favoris,
    ),
    BottomMenuModel(
      icon: ImageConstant.profileSettingsImg,
      activeIcon: ImageConstant.profileSettingsImg,
      title: "إعدادات".tr,
      type: BottomBarEnum.Profile,
    )
  ]; */

  Function(BottomBarEnum)? onChanged;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    final mainController = Get.put(MainController());

    return Obx(() {
      bool isDark = ThemeController.instance.isDark.value;
      var selectedCountry = controller.selectedCountryTitle.value;
      //debugPrint('selectedCountry bottom navigation: $selectedCountry');

      return Container(
          height: 90.v,
          decoration: BoxDecoration(
            color: isDark ? TColors.dark : TColors.white,
            //color: theme.colorScheme.onErrorContainer,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.hw),
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              elevation: 0,
              currentIndex: controller.selectedIndex.value,
              type: BottomNavigationBarType.fixed,
              items: List.generate(controller.bottomMenuList.length, (index) {
                bool isMain = controller.bottomMenuList[index].type == BottomBarEnum.main;
                return BottomNavigationBarItem(
                  icon: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: controller.bottomMenuList[index].icon,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                        color: isDark ? TColors.white : TColors.grey300,
                      ),
                      Text(
                        isMain
                            ? controller.selectedCountryTitle.value
                            : controller.bottomMenuList[index].title!,
                        //bottomMenuList[index].title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: isDark ? TColors.white : TColors.greyDating,
                            fontSize:  isTablet ? 20.adaptSize : isSmallPhone ? 15.adaptSize : 16.adaptSize
                        ),
                      )
                    ],
                  ),
                  activeIcon: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: controller.bottomMenuList[index].activeIcon,
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        color: TColors.yellowAppDark,
                        //color: theme.colorScheme.primary,
                      ),
                      Text(
                        isMain
                            ? selectedCountry
                            : controller.bottomMenuList[index].title!,
                        //bottomMenuList[index].title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: TColors.yellowAppDark,
                            fontSize: isTablet ? 20.adaptSize : isSmallPhone ? 15.adaptSize : 16.adaptSize
                        ),
                      )
                    ],
                  ),
                  label: '',
                );
              }),
              onTap: (index) {
                //selectedIndex.value = index;
                controller.changeTabIndex(index);
                onChanged?.call(controller.bottomMenuList[index].type);
              },
            ),
          )
      );
    });
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}