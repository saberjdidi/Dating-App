import 'attachment_model.dart';

class MessageModel {
  final String messageId;
  final String senderUid;
  final String receiverUid;
  final String senderName;
  final String receiverName;
  final String senderProfile;
  final String receiverProfile;
  final String? text;
  final AttachmentModel? attachment;
  final DateTime createdAt;
  final bool isSeen;

  MessageModel({
    required this.messageId,
    required this.senderUid,
    required this.receiverUid,
    required this.senderName,
    required this.receiverName,
    required this.senderProfile,
    required this.receiverProfile,
    this.text,
    this.attachment,
    required this.createdAt,
    this.isSeen = false,
  });
}
