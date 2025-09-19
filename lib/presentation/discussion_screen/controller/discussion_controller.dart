import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/datasources/chat_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:dating_app_bilhalal/data/models/chat_model.dart';
import 'package:flutter/material.dart';

class DiscussionController extends GetxController {
  static DiscussionController get instance => Get.find();

  var searchText = "".obs;
  final TextEditingController searchController = TextEditingController();
  var selectedTab = 0.obs; // 0: All, 1: Unread, 2: Archive
  var chats = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    chats.value = ChatLocalDataSource.getChats();
  }

  List<ChatModel> get filteredChats {
    var list = chats.where((chat) {
      if (selectedTab.value == 1 && chat.isRead) return false;
      if (selectedTab.value == 2 && !chat.isArchived) return false;
      if (searchText.isNotEmpty &&
          !chat.senderFullName!.toLowerCase().contains(searchText.value.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
    return list;
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }

  void onTabChanged(int index) {
    selectedTab.value = index;
  }

}