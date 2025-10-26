import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/controller/favorite_controller.dart';
import 'package:dating_app_bilhalal/widgets/favourite/favorite_card_widget.dart';
import 'package:dating_app_bilhalal/widgets/shimmer/favourite_listview_shimmer.dart';
import 'package:flutter/material.dart';


class UserLikeMeListView extends StatelessWidget {
  final FavoriteController controller;

  const UserLikeMeListView({super.key, required this.controller, });

  @override
  Widget build(BuildContext context) {
    var isLight = PrefUtils.getTheme() == "light";

    return Obx(() {
      if (controller.isDataProcessingFavouritesLikeMe.value){
        return FavouriteListViewShimmer();
      }
      if (controller.usersLikeMeList.isEmpty) {
        return Center(child: Text("لم يتم العثور على أي مستخدم",
          style: TextStyle(color:  isLight ? TColors.black : TColors.white,
              fontSize: 18.adaptSize, fontWeight: FontWeight.w500),));
      }

      return RefreshIndicator(
        onRefresh: () async {
          controller.refreshData();
        },
        child: ListView.builder(
          itemCount: controller.usersLikeMeList.length,
          itemBuilder: (context, index) {
            final user = controller.usersLikeMeList[index];
            return FavoriteCardWidget(
              user: user,
              onMessageTap: () async {
                //await dialogSearchByCountry(context);
              },
              onFavoriteTap: () => debugPrint("Favorite ${user.target!.username}"),
            );
          },
        ),
      );
    });
  }
}
