
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/widgets/home/animated_gradient_progress.dart';
import 'package:dating_app_bilhalal/widgets/home/pays_widget.dart';
import 'package:dating_app_bilhalal/widgets/home/user_card_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MainScreen extends GetView<MainController> {
//class MainScreen extends StatelessWidget {
   MainScreen({super.key});

  //final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Dating App")),
      body: Stack(
        children: [
          Obx(() {
            if (controller.users.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return CardSwiper(
              controller: controller.swiperController,
              cardsCount: controller.users.length,
              numberOfCardsDisplayed: 1,
              isLoop: true,
              padding: EdgeInsets.zero,
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

                // Si tu veux encore gérer les swipes gauche/droite :
                if (direction == CardSwiperDirection.left) {
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
                }

                return true;
              },
              //maxAngle: 30,
              cardBuilder: (context, index, percentX, percentY) {
                final user = controller.users[index];
                return UserCardWidget(
                  user: user,
                  onMessageTap: () async {
                    debugPrint("message ${user.fullName}");
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
