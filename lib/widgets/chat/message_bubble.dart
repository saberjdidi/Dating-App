import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/message_model.dart';
import 'package:dating_app_bilhalal/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final String? profileUser;
  final String? myImageProfile;
  const MessageBubble({super.key, required this.message, this.profileUser, this.myImageProfile});

  @override
  Widget build(BuildContext context) {
    final isSender = message.senderUid == "user1";

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.v),
        child: Column(
          crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: isSender
                    ? BorderRadius.only(
                    topLeft: Radius.circular(20.adaptSize),
                    topRight: Radius.circular(20.adaptSize),
                    bottomRight: Radius.circular(5.adaptSize),
                    bottomLeft: Radius.circular(20.adaptSize))
                    : BorderRadius.only(
                    topLeft: Radius.circular(20.adaptSize),
                    topRight: Radius.circular(20.adaptSize),
                    bottomRight: Radius.circular(20.adaptSize),
                    bottomLeft: Radius.circular(5.adaptSize)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isSender
                      ? [
                    TColors.yellowAppDark,
                    TColors.yellowAppLight.withOpacity(0.6),
                  ]
                      : [
                    TColors.greyDating,
                    TColors.greyDating,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.attachment != null)
                    CustomImageView(
                      imagePath: message.attachment!.path,
                      height: 150,
                    ),
                  if (message.text != null)
                    Text(
                      message.text!,
                      style: TextStyle(fontSize: 16),
                    ),
                  Text(
                    "${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 3.0, left: 3.0, top: 0),
              child: CustomImageView(
                imagePath: isSender ? myImageProfile : profileUser,
                width: 30,
                height: 30,
                radius: BorderRadius.circular(30),
              ),
             /* child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(isSender
                    ? message.senderProfile
                    : message.receiverProfile),
              ) */
            ),
          ],
        ),
      ),
    );
  }
}
 