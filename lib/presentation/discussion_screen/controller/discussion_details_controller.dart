import 'dart:io';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/datasources/message_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/attachment_model.dart';
import 'package:dating_app_bilhalal/data/models/chat_model.dart';
import 'package:dating_app_bilhalal/data/models/message_model.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiscussionDetailsController extends GetxController {
  static DiscussionDetailsController get instance => Get.find();

  ChatModel userChatModel  = Get.arguments['ChatDiscussion'] ?? ChatModel.empty();
  final TextEditingController messageController = TextEditingController();
  var messages = <MessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void loadMessages() {
    messages.assignAll(MessageLocalDataSource.getMessages());
  }



  sendMessage() async {
    if (messageController.text.isEmpty && pickedAttachment.value == null) return;

    messages.add(
      MessageModel(
        messageId: DateTime.now().toString(),
        senderUid: "user1",
        receiverUid: "user2",
        senderName: "Alice",
        receiverName: "Bob",
        senderProfile: "assets/images/alice.jpg",
        receiverProfile: "assets/images/bob.jpg",
        text: messageController.text.isNotEmpty ? messageController.text : "",
        attachment: pickedAttachment.value,
       /* attachment: pickedAttachment.value != null
            ? AttachmentModel(type: MessageType.image, file: pickedAttachment.value)
            : null,*/
        createdAt: DateTime.now(),
      ),
    );

    // Reset
    messageController.clear();
    pickedAttachment.value = null;
  }
  /* void sendMessage(MessageModel message) {
    messages.add(message);
  } */

  showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return GridView.count(
          crossAxisCount: 3, // Number of columns
          padding: const EdgeInsets.all(16.0), // Padding around the grid
          crossAxisSpacing: 10.0, // Spacing between items horizontally
          mainAxisSpacing: 10.0, // Spacing between items vertically
          children: <Widget>[
            // Your static grid items go here
            Column(
              children: [
                CircularContainer(
                  width: 60.adaptSize,
                  height: 60.adaptSize,
                  radius: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.7),
                  child: IconButton(
                    icon: Icon(Iconsax.gallery, color: TColors.black.withOpacity(0.9), size: 35.adaptSize,),
                    onPressed: () async {
                      Navigator.pop(context);
                     await pickMediaFromGalley();
                     //await pickFromGallery();
                    },
                  ),
                ),
                SubTitleWidget(subtitle: "Gallery")
              ],
            ),
            Column(
              children: [
                CircularContainer(
                  width: 60.adaptSize,
                  height: 60.adaptSize,
                  radius: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.7),
                  child: IconButton(
                    icon: Icon(Iconsax.camera, color: TColors.black.withOpacity(0.9), size: 35.adaptSize,),
                    onPressed: (){
                      Navigator.pop(context);
                      pickMediaFromCamera();
                    },
                  ),
                ),
                SubTitleWidget(subtitle: "Camera")
              ],
            ),
            Column(
              children: [
                CircularContainer(
                  width: 60.adaptSize,
                  height: 60.adaptSize,
                  radius: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.7),
                  child: IconButton(
                    icon: Icon(Iconsax.location, color: TColors.black.withOpacity(0.9), size: 35.adaptSize,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                SubTitleWidget(subtitle: "Location")
              ],
            ),
            Column(
              children: [
                CircularContainer(
                  width: 60.adaptSize,
                  height: 60.adaptSize,
                  radius: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.7),
                  child: IconButton(
                    icon: Icon(Iconsax.document, color: TColors.black.withOpacity(0.9), size: 35.adaptSize,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                SubTitleWidget(subtitle: "Document")
              ],
            ),
            Column(
              children: [
                CircularContainer(
                  width: 60.adaptSize,
                  height: 60.adaptSize,
                  radius: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.7),
                  child: IconButton(
                    icon: Icon(Icons.person_pin_outlined, color: TColors.black.withOpacity(0.9), size: 35.adaptSize,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                SubTitleWidget(subtitle: "Contact")
              ],
            )

          ],
        );
      },
    );
  }

  ///Upoad Media
  var pickedAttachment = Rx<AttachmentModel?>(null);
 /* var pickedAttachment = Rx<File?>(null);
  Future<void> pickFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedAttachment.value = File(pickedFile.path);
    }
  }
  Future<void> pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedAttachment.value = File(pickedFile.path);
    }
  } */

  Future<void> pickMediaFromGalley() async {
    final pickedFile = await ImagePicker().pickMedia(); // peut être image ou vidéo

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final isVideo = pickedFile.path.toLowerCase().endsWith('.mp4') ||
          pickedFile.path.toLowerCase().endsWith('.mov') ||
          pickedFile.path.toLowerCase().endsWith('.avi');

      pickedAttachment.value = AttachmentModel(
        type: isVideo ? MessageType.video : MessageType.image,
        file: file,
      );
    }
  }

  Future<void> pickMediaFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera); // peut être image ou vidéo

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final isVideo = pickedFile.path.toLowerCase().endsWith('.mp4') ||
          pickedFile.path.toLowerCase().endsWith('.mov') ||
          pickedFile.path.toLowerCase().endsWith('.avi');

      pickedAttachment.value = AttachmentModel(
        type: MessageType.camera,
        file: file,
      );
    }
  }

}