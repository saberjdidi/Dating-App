import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  TAppBar({super.key,
    this.title,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.toolbarHeight,
    this.showAction = true
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  double? leadingWidth;
  double? toolbarHeight;
  bool showAction;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    var isArabe = PrefUtils.getLangue() == 'ar';
    var isLight = PrefUtils.getTheme() == "light";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallPhone ? TSizes.xs.adaptSize :  TSizes.sm.adaptSize),
      child: Directionality(
        textDirection: TextDirection.ltr, // ✅ Force toujours LTR
        child: AppBar(
          backgroundColor: isLight ? TColors.white : TColors.dark,
          automaticallyImplyLeading: false,
          leading: leading,
          leadingWidth: leadingWidth,
          toolbarHeight: toolbarHeight,
          centerTitle: true,
          title: title,
         /* title: Directionality( // ✅ Le titre suit la langue
            textDirection: isArabe
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: title,
          ), */
          actions: showAction
         ? (actions == null || actions == [])
              ? [
            IconButton(
                onPressed: (){Navigator.of(context).pop();},
                icon: Icon(Iconsax.arrow_right_1, color: isLight ? TColors.black : TColors.white)
            )
           /* isSmallPhone
                ? CustomImageView(
                  imagePath: ImageConstant.imgBack,
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  width: isTablet ? 60.adaptSize : 55.adaptSize,
                  height: isTablet ? 60.adaptSize : 55.adaptSize,
                  radius: BorderRadius.circular(isTablet ? 60.adaptSize : 55.adaptSize),
                )
                :
                IconButton(
                    onPressed: (){Navigator.of(context).pop();},
                    icon: Icon(Iconsax.arrow_right_1, color: PrefUtils.getTheme() == "light" ? TColors.black : TColors.white)
                ) */
                //CustomImageView(imagePath: ImageConstant.imgBack, onTap: (){Navigator.of(context).pop();})
          ]
              : actions
         : null,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? TDeviceUtils.getAppBarHeight());
}

///AppBar without multi-language
/*
class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  TAppBar({super.key,
    this.title,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.toolbarHeight,
    this.showAction = true
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  double? leadingWidth;
  double? toolbarHeight;
  bool showAction;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallPhone ? TSizes.xs.adaptSize :  TSizes.sm.adaptSize),
      child: AppBar(
        backgroundColor: PrefUtils.getTheme() == "light" ? TColors.white : TColors.dark,
        automaticallyImplyLeading: false,
        leading: leading,
        leadingWidth: leadingWidth,
        toolbarHeight: toolbarHeight,
        centerTitle: true,
        title: title,
        actions: showAction
       ? (actions == null || actions == [])
            ? [
          IconButton(
              onPressed: (){Navigator.of(context).pop();},
              icon: Icon(Iconsax.arrow_right_1, color: PrefUtils.getTheme() == "light" ? TColors.black : TColors.white)
          )
         /* isSmallPhone
              ? CustomImageView(
                imagePath: ImageConstant.imgBack,
                onTap: (){
                  Navigator.of(context).pop();
                },
                width: isTablet ? 60.adaptSize : 55.adaptSize,
                height: isTablet ? 60.adaptSize : 55.adaptSize,
                radius: BorderRadius.circular(isTablet ? 60.adaptSize : 55.adaptSize),
              )
              :
              IconButton(
                  onPressed: (){Navigator.of(context).pop();},
                  icon: Icon(Iconsax.arrow_right_1, color: PrefUtils.getTheme() == "light" ? TColors.black : TColors.white)
              ) */
              //CustomImageView(imagePath: ImageConstant.imgBack, onTap: (){Navigator.of(context).pop();})
        ]
            : actions
       : null,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? TDeviceUtils.getAppBarHeight());
}
 */