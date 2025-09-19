import 'package:dating_app_bilhalal/data/models/chat_model.dart';
import 'package:dating_app_bilhalal/widgets/home/chat_item.dart';
import 'package:flutter/material.dart';

class ChatListView extends StatelessWidget {
  final List<ChatModel> chats;
  final Function(ChatModel) onItemTap;

  const ChatListView({super.key, required this.chats, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatItem(
          chat: chats[index],
          onTap: () => onItemTap(chats[index]),
        );
      },
    );
  }
}
