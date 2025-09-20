import 'package:dating_app_bilhalal/core/app_export.dart';
import '../models/message_model.dart';
import '../models/attachment_model.dart';

class MessageLocalDataSource {
  static List<MessageModel> getMessages() {
    return [
      MessageModel(
        messageId: "1",
        senderUid: "user1",
        receiverUid: "user2",
        senderName: "Alice",
        receiverName: "Bob",
        senderProfile: ImageConstant.profile8,
        receiverProfile: ImageConstant.profile6,
        text: "Salut Bob!",
        createdAt: DateTime.now().subtract(Duration(minutes: 5)),
      ),
      MessageModel(
        messageId: "2",
        senderUid: "user2",
        receiverUid: "user1",
        senderName: "Bob",
        receiverName: "Alice",
        senderProfile: ImageConstant.profile6,
        receiverProfile: ImageConstant.profile8,
        text: "Salut Alice, ça va?",
        createdAt: DateTime.now().subtract(Duration(minutes: 3)),
      ),
      MessageModel(
        messageId: "3",
        senderUid: "user1",
        receiverUid: "user2",
        senderName: "Alice",
        receiverName: "Bob",
        senderProfile: ImageConstant.profile8,
        receiverProfile: ImageConstant.profile1,
        attachment: AttachmentModel(
          type: MessageType.image,
          url: ImageConstant.imgOnBoarding1,
        ),
        createdAt: DateTime.now().subtract(Duration(minutes: 1)),
      ),
      MessageModel(
        messageId: "2",
        senderUid: "user2",
        receiverUid: "user1",
        senderName: "Bob",
        receiverName: "Alice",
        senderProfile: ImageConstant.profile6,
        receiverProfile: ImageConstant.profile8,
        text: "زرت هذا المسجد الجميل يوم الجمعة الماضي. الهندسة المعمارية مذهلة!",
        attachment: AttachmentModel(
          type: MessageType.image,
          url: ImageConstant.imgMosque,
        ),
        createdAt: DateTime.now().subtract(Duration(minutes: 3)),
      ),
    ];
  }
}
