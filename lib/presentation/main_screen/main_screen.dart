
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/widgets/home/animated_gradient_progress.dart';
import 'package:dating_app_bilhalal/widgets/home/pays_widget.dart';
import 'package:dating_app_bilhalal/widgets/home/user_card_widget.dart';
import 'package:dating_app_bilhalal/widgets/shimmer/card_swiper_shimmer.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MainScreen extends StatelessWidget {
  //class MainScreen extends GetView<MainController> {
   MainScreen({super.key});

  final controller = Get.put(MainController());
   var isLight = PrefUtils.getTheme() == "light";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Dating App")),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isDataProcessing.value) {
              return CardSwiperShimmer();
            }

            // ✅ Vérifie si user est null avant d'y accéder
            if (controller.usersList.isEmpty) {
              return Center(child: Text("لم يتم العثور على أي مستخدم",
                style: TextStyle(color:  isLight ? TColors.black : TColors.white,
                    fontSize: 18.adaptSize, fontWeight: FontWeight.w500),));
            }

            return CardSwiper(
              controller: controller.swiperController,
              cardsCount: controller.usersList.length,
              numberOfCardsDisplayed: 1,
              isLoop: true,
              padding: EdgeInsets.zero,
              duration: Duration(milliseconds: 1),
              allowedSwipeDirection: const AllowedSwipeDirection.only(
                up: true,
                down: true,
                left: false,
                right: false,
              ),
              onSwipe: (previousIndex, currentIndex, direction) {
                if (direction == CardSwiperDirection.top) {
                  // 🔼 Swipe vers le haut → précédent
                  final targetIndex =
                      (previousIndex! - 1 + controller.cardsCount) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false; // Bloque le swipe horizontal
                } else if (direction == CardSwiperDirection.bottom) {
                  // 🔽 Swipe vers le bas → suivant
                  final targetIndex = (previousIndex! + 1) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false;
                }

                // 🚫 Bloquer les swipes gauche/droite
                if (direction == CardSwiperDirection.left ||
                    direction == CardSwiperDirection.right) {
                  return false; // Annule le swipe horizontal
                }
                // Si tu veux encore gérer les swipes gauche/droite :
               /* if (direction == CardSwiperDirection.left) {
                  final targetIndex =
                      (previousIndex! - 1 + controller.cardsCount) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false;
                } else if (direction == CardSwiperDirection.right) {
                  final targetIndex = (previousIndex! + 1) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false;
                } */

                return false;
              },
              //maxAngle: 30,
              cardBuilder: (context, index, percentX, percentY) {
                final user = controller.usersList[index];
                return UserCardWidget(
                  user: user,
                  onMessageTap: () async {
                    debugPrint("message ${user.username}");
                  },
                  onFavoriteTap: () async {

                  },
                  /*  onTapFilter: () async {
                    await dialogSearch(context);
                  }, */
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
