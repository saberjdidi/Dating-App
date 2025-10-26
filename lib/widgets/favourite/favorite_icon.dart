import 'package:dating_app_bilhalal/presentation/favorite_screen/controller/favorite_controller.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/controller/favourite_icon_controller.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteIconController());
    //final controller = Get.put(FavoriteController());

    // Charger le statut favori une seule fois par user
    controller.loadFavoriteStatus(userId);

    return Obx(() {
      final isFav = controller.isFavourite(userId);
      return GestureDetector(
        onTap: () => controller.toggleFavorite(userId),
        child: CustomImageView(
          imagePath: ImageConstant.iconLove,
          color: isFav ? TColors.redApp : TColors.white,
          height: 38.adaptSize,
          width: 38.adaptSize,
        ),
      );
    });
  }
}

/*
class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    final controller = Get.put(FavoriteController());
    return Obx(() => CustomImageView(
      imagePath: ImageConstant.iconLove,
      color: controller.isFavorite(userId) ? TColors.redApp : TColors.white,
      height: isTablet ? 55.adaptSize : 38.adaptSize,
      width: isTablet ? 55.adaptSize : 38.adaptSize,
      onTap: () => controller.toggleFavoriteProperty(userId),
    ));
  }
}
*/