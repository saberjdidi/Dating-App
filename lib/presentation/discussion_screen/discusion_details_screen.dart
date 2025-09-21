import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/models/message_model.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/controller/discussion_details_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/chat/message_bubble.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class DiscussionDetailsScreen extends GetView<DiscussionDetailsController> {
  const DiscussionDetailsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: TColors.white,
      appBar: TAppBar(
        leadingWidth: 160.adaptSize,
        toolbarHeight: 80.adaptSize,
        leading: Row(
          children: [
            CircularContainer(
              width: 50.adaptSize,
              height: 50.adaptSize,
              radius: 50.adaptSize,
              backgroundColor: TColors.greyDating.withOpacity(0.6),
              child: IconButton(
                icon: Icon(Icons.more_vert, color: TColors.black.withOpacity(0.7), size: 30.adaptSize,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(width: 5.adaptSize,),
            CircularContainer(
              width: 50.adaptSize,
              height: 50.adaptSize,
              radius: 50.adaptSize,
              backgroundColor: TColors.greyDating.withOpacity(0.6),
              child: IconButton(
                icon: Icon(Icons.call, color: TColors.black.withOpacity(0.7), size: 30.adaptSize,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(width: 5.adaptSize,),
            CircularContainer(
              width: 50.adaptSize,
              height: 50.adaptSize,
              radius: 50.adaptSize,
              backgroundColor: TColors.greyDating.withOpacity(0.6),
              child: IconButton(
                icon: Icon(Icons.video_call_outlined, color: TColors.black.withOpacity(0.7), size: 30.adaptSize,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        title: Center(
          // SingleChildScrollView (child: scrollDirection: Axis.horizontal,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: null,
            title: Text(
              controller.userChatModel.senderFullName!,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: TColors.black,
                fontSize: 22.fSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(
              children: [
                SubTitleWidget(subtitle: "متصل"),
                if (controller.userChatModel.isConnect) ...[
                  SizedBox(width: 3.adaptSize),
                  CircleAvatar(radius: 6, backgroundColor: Colors.green)
                ]
              ],
            ),
            trailing: CustomImageView(
              imagePath: controller.userChatModel.senderProfile,
              width: 50.adaptSize,
              height: 50.adaptSize,
              radius: BorderRadius.circular(50.adaptSize),
              onTap: () async {
                Get.toNamed(Routes.userChatPofileScreen,
                    //arguments: {"UserModel" : user}
                );
              },
            ),
          ),
        ),
        //Other method
       /* title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(controller.userChatModel.senderFullName!,
                   overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: TColors.black,
                    fontSize: 22.fSize,
                    fontWeight: FontWeight.bold,
                    //decoration: TextDecoration.underline,
                    decorationColor: TColors.black,
                  ),
                ),
                Row(
                  children: [

                    SubTitleWidget(subtitle: "متصل"),
                    if (controller.userChatModel.isConnect) SizedBox(width: 3.adaptSize,),
                    if (controller.userChatModel.isConnect) CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.green,
                    )
                  ],
                )
              ],
            ),
            SizedBox(width: 10.hw,),
            Expanded( //verify Expanded
              child: CustomImageView(
                imagePath: controller.userChatModel.senderProfile,
                width: 50.adaptSize,
                height: 50.adaptSize,
                radius: BorderRadius.circular(50.adaptSize),
              ),
            )
          ],
        ), */

        actions: [
          CircularContainer(
            width: 50.adaptSize,
            height: 50.adaptSize,
            radius: 50.adaptSize,
            backgroundColor: TColors.greyDating.withOpacity(0.6),
            child: IconButton(
              icon: Icon(Icons.arrow_forward_outlined, color: TColors.black.withOpacity(0.7), size: 30.adaptSize,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Obx(() => ListView.builder(
        reverse: true,
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final message = controller.messages.reversed.toList()[index];
          return MessageBubble(message: message, profileUser: controller.userChatModel.senderProfile, myImageProfile: ImageConstant.profile8);
        },
      )),
     bottomNavigationBar: buildMessageInput(context),
    );
  }

  Widget buildMessageInput(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10.adaptSize),
        child: Row(
          children: [
        IconButton(icon: Icon(Icons.add, color: TColors.buttonSecondary, size: 30.adaptSize), onPressed: () {
          controller.showAttachmentOptions(context);
        }),
        IconButton(icon: Icon(Icons.keyboard_voice_outlined, color: TColors.buttonSecondary, size: 30.adaptSize), onPressed: () {}),
            Expanded(
              child: CustomTextFormField(
                controller: controller.messageController,
                hintText: "اكتب رسالة",
                textInputType: TextInputType.text,
                prefixConstraints: BoxConstraints(maxHeight: 60.v),
                contentPadding: EdgeInsets.only(top: 15.v, right: 15.hw, left: 15.hw, bottom: 15.v),
                validator: (value) => Validator.validateEmptyText('${'Message'.tr}', value),
                borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.adaptSize),
                    borderSide: BorderSide(color: TColors.greyDating, width: 0.8)
                  //borderSide: BorderSide.none,
                ),
              ),
            ),
        /*    Expanded(
              child: TextField(
                controller: controller.messageController,
                decoration: InputDecoration(
                  hintText: "اكتب رسالة",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ), */
            CustomImageView(
              imagePath: ImageConstant.imgSend,
              width: 50.adaptSize,
              height: 50.adaptSize,
              radius: BorderRadius.circular(50.adaptSize),
              onTap: () async {
               await controller.sendMessage();
               /* if (controller.messageController.text.isNotEmpty) {
                  controller.sendMessage(MessageModel(
                    messageId: DateTime.now().toString(),
                    senderUid: "user1",
                    receiverUid: "user2",
                    senderName: "Alice",
                    receiverName: "Bob",
                    senderProfile: "assets/images/alice.jpg",
                    receiverProfile: "assets/images/bob.jpg",
                    text: controller.messageController.text,
                    createdAt: DateTime.now(),
                  ));
                  controller.messageController.clear();
                }  */
              },
            ),
           /* CircularContainer(
              width: 60.adaptSize,
              height: 60.adaptSize,
              radius: 60.adaptSize,
              backgroundColor: TColors.yellowAppDark,
              child: IconButton(
                icon: Icon(Iconsax.send_1, color: TColors.black, size: 35.adaptSize,),
                onPressed: (){

                },
              ),
            ), */
          ],
        ),
      ),
    );
  }
}


