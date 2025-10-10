import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:dating_app_bilhalal/data/models/chat_model.dart';
import 'package:dating_app_bilhalal/widgets/chat/chat_item.dart';
import 'package:dating_app_bilhalal/widgets/home/favorite_card_widget.dart';
import 'package:flutter/material.dart';

import 'user_card_widget.dart';

class FavoriteListView extends StatelessWidget {
  final List<UserModel> items;
  final Function(UserModel) onItemTap;

  const FavoriteListView({super.key, required this.items, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final user = items[index];
        return FavoriteCardWidget(
          user: user,
          onMessageTap: () async {
            //await dialogSearchByCountry(context);
          },
          onFavoriteTap: () => debugPrint("Favorite ${user.fullName}"),
        );
      },
    );
  }
}
