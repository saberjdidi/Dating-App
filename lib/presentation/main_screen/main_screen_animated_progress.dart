import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller_animated_progress.dart';
import 'package:dating_app_bilhalal/widgets/home/animated_gradient_progress.dart';
import 'package:dating_app_bilhalal/widgets/home/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MainScreenAnimatedProgress extends GetView<MainControllerAnimatedProgress> {
  MainScreenAnimatedProgress({super.key});

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
              //Auto Swiper with timer - Mise à jour du callback onSwipe
              onSwipe: (previousIndex, currentIndex, direction) {
                // Relance toujours le timer sur geste manuel
                controller.onSwipe();

                if (direction == CardSwiperDirection.left) {
                  // Swipe gauche : Va au précédent (non aléatoire)
                  final targetIndex = (previousIndex! - 1 + controller.cardsCount) % controller.cardsCount;
                  controller.currentIndex.value = targetIndex;
                  controller.swiperController.moveTo(targetIndex);
                  return false; // Annule le swipe gauche pour éviter le next par défaut
                } else {
                  // Swipe droite (ou autre) : Autorise le next séquentiel
                  // Met à jour l'index après l'animation (microtask pour sync)
                  Future.microtask(() {
                    controller.currentIndex.value = currentIndex ?? 0;
                  });
                  return true;
                }
              },
              //Auto Swiper with timer
              /* onSwipe: (previousIndex, currentIndex, direction) {
                // ✅ Lorsqu’on swipe manuellement, on relance le timer
                controller.onSwipe();
                return true;
              }, */
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
            /*  return GestureDetector(
              // ✅ Stop auto-swipe when user interacts (optionnel)
              onTapDown: (_) => controller.stopAutoSwipe(),
              onTapUp: (_) => controller.startAutoSwipe(),
              child: CardSwiper(
                controller: controller.swiperController,
                cardsCount: controller.users.length,
                numberOfCardsDisplayed: 1,
                isLoop: true,
                padding: EdgeInsets.zero,
                onSwipe: (previousIndex, currentIndex, direction) {
                  // ✅ Lorsqu’on swipe manuellement, on relance le timer
                  if (direction != null) {
                    controller.onSwipe(direction);
                  }
                 // controller.onSwipe();
                  return true;
                },
                //maxAngle: 30,
                cardBuilder: (context, index, percentX, percentY) {
                  final user = controller.users[index];
                  return UserCardWidget(
                    user: user,
                    onMessageTap: () async {
                      //await dialogSearchByCountry(context);
                    },
                    onFavoriteTap: () => debugPrint("Favorite ${user.fullName}"),
                  );
                },
              ),
            ); */
          }),

          // ✅ Barre de progression animée
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Obx(() => AnimatedGradientProgressWidget(
              progress: controller.progress.value,
            )),
          ),
          /* Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Obx(() => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: controller.progress.value,
                minHeight: 6,
                backgroundColor: Colors.white24,
                valueColor:
                AlwaysStoppedAnimation<Color>(TColors.yellowAppDark),
              ),
            )),
          ), */
        ],
      ),
    );
  }
}