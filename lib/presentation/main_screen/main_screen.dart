
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/widgets/home/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Dating App")),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return CardSwiper(
          cardsCount: controller.users.length,
          numberOfCardsDisplayed: 1,
          isLoop: true,
          padding: EdgeInsets.zero,
          //maxAngle: 30,
          cardBuilder: (context, index, percentX, percentY) {
            final user = controller.users[index];
            return UserCardWidget(
              user: user,
              onMessageTap: () => debugPrint("Message ${user.fullName}"),
              onFavoriteTap: () => debugPrint("Favorite ${user.fullName}"),
            );
          },
        );
      }),
    );
  }
}
