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
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  double? leadingWidth;
  double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: leading,
        leadingWidth: leadingWidth,
        toolbarHeight: toolbarHeight,
        centerTitle: true,
        title: title,
        actions: (actions == null || actions == [])
            ? [IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_right_1))]
            : actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? TDeviceUtils.getAppBarHeight());
}
/*
class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({super.key,
    this.title,
    this.actions,
    this.leading,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.rightToLeft = false
  });

  final Widget? title;
  final bool showBackArrow;
  final bool rightToLeft;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final Widget? leading;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: rightToLeft
      ? AppBar(
        automaticallyImplyLeading: false,
        leading: leading,
        centerTitle: true,
        title: title,
        actions: (actions == null || actions == [])
        ? [IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_right_1))]
        : actions,
      )
      : AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left))
          : leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,
      title: title,
      actions: actions,
    ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
*/