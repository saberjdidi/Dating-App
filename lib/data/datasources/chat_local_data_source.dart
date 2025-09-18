import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/user_chat_model.dart';

class ChatLocalDataSource {
  static List<UserChatModel> getChats() {
    return [
      UserChatModel(
        id: "1",
        fullName: "اویس",
        isConnect: true,
        lastSeen: DateTime.now().subtract(Duration(minutes: 5)),
        lastMessage: "مرحباً كيف حالك؟۔۔۔۔۔۔",
        file: ImageConstant.userProfile
      ),
      UserChatModel(
        id: "2",
        fullName: "یعقوب",
        isConnect: false,
        lastSeen: DateTime.now().subtract(Duration(hours: 3)),
        lastMessage: "مرحباً كيف حالك؟",
        isRead: false,
          file: ImageConstant.profile8
      ),
      UserChatModel(
        id: "3",
        fullName: "عبدالرحمن",
        isConnect: true,
        lastSeen: DateTime.now().subtract(Duration(days: 1)),
        lastMessage: "مرحبا بك",
        isArchived: true,
        file: ImageConstant.profile2
      ),
    ];
  }
}
