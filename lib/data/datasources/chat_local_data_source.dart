import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/chat_model.dart';

class ChatLocalDataSource {
  static List<ChatModel> getChats() {
    return [
      ChatModel(
        senderUid: "1",
        senderFullName: "اویس",
        isConnect: true,
          createdAt: DateTime.now().subtract(Duration(minutes: 5)),
          recentTextMessage: "مرحباً كيف حالك؟۔۔۔۔۔۔",
          senderProfile: ImageConstant.userProfile
      ),
      ChatModel(
      senderUid: "2",
        senderFullName: "یعقوب",
        isConnect: false,
          createdAt: DateTime.now().subtract(Duration(hours: 3)),
          recentTextMessage: "مرحباً كيف حالك؟",
        isRead: false,
          senderProfile: ImageConstant.profile8
      ),
      ChatModel(
          senderUid: "3",
          senderFullName: "عبدالرحمن",
        isConnect: true,
          createdAt: DateTime.now().subtract(Duration(days: 1)),
          recentTextMessage: "مرحبا بك",
        isArchived: true,
          senderProfile: ImageConstant.profile2
      ),
    ];
  }
}
