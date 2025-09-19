import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/datasources/message_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/chat_model.dart';
import 'package:dating_app_bilhalal/data/models/message_model.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';

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

  void sendMessage(MessageModel message) {
    messages.add(message);
  }

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
                    onPressed: (){
                      Navigator.pop(context);
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

}