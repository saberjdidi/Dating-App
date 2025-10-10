import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/validators/validation.dart';
import 'package:dating_app_bilhalal/data/models/message_model.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/controller/message_controller.dart';
import 'package:dating_app_bilhalal/presentation/settings_screen/controller/settings_controller.dart';
import 'package:dating_app_bilhalal/presentation/settings_screen/settings_screen.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/chat/draft_audio_widget.dart';
import 'package:dating_app_bilhalal/widgets/chat/message_bubble.dart';
import 'package:dating_app_bilhalal/widgets/circle_icon_button.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/custom_divider.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class MessageScreen extends GetView<MessageController> {
  MessageScreen({super.key});

  final settingsController = Get.put(SettingsController());
  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      child: Scaffold(
        //backgroundColor: TColors.white,
        resizeToAvoidBottomInset: true, // important pour éviter que le clavier cache le champ
        appBar: TAppBar(
          leadingWidth: 160.adaptSize,
          toolbarHeight: isTablet ? 100.adaptSize : 80.adaptSize,
          leading: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  child: Icon(Icons.more_vert,
                    color: _appTheme =='light' ? TColors.black.withOpacity(0.7) : TColors.greyDating.withOpacity(0.6),
                    size: 30.hw,),
                  onTap: (){
                    buildDialogSettings(context);
                  /*  Get.dialog(
                      Dialog(
                        insetPadding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        child: SizedBox(
                          height: 420, // fixe la hauteur de ton popup
                          width: double.infinity,
                          child: SettingsScreen(),
                        ),
                      ),
                      barrierDismissible: true, // Ferme si l'utilisateur clique à l'extérieur
                    ); */
                    //Get.toNamed(Routes.settingsScreen);
                    //Navigator.pop(context);
                  },
                ),
                SizedBox(width: 1.hw,),
                CustomImageView(
                  imagePath: ImageConstant.iconCam,
                  //color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                  height: 45.hw,
                  width: 45.hw,
                  fit: BoxFit.cover,
                  onTap: (){
                    if (!settingsController.isCallVideo.value) {
                      Get.snackbar("Appel interdit", "L'utilisateur n'autorise pas les appels vidéo");
                      return;
                    }
                    Get.toNamed(Routes.callVideoScreen);
                    //Navigator.pop(context);
                  },
                ),
                SizedBox(width: 2.hw,),
                CustomImageView(
                  imagePath: ImageConstant.iconCall,
                  //color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                  height: 45.hw,
                  width: 45.hw,
                  fit: BoxFit.cover,
                  onTap: (){
                    if (!settingsController.isCallVoice.value) {
                      Get.snackbar("Appel interdit", "L'utilisateur n'autorise pas les appels vocaux");
                      return;
                    } else {
                      Get.toNamed(Routes.callScreen);
                    }
                  },
                ),
               /*
                CircleIconButton(
                  size: isSmallPhone ? 50.hw : 40.hw,
                  effectiveSize: isSmallPhone ? 50.hw : 40.hw,
                  minTapSize: isSmallPhone ? 50.hw : 40.hw,
                  backgroundColor: TColors.greyDating.withOpacity(0.6),
                  child: IconButton(
                    icon: Icon(Icons.videocam_rounded, color: TColors.black.withOpacity(0.7), size: 25.hw,),
                    onPressed: (){
                      if (!settingsController.isCallVideo.value) {
                        Get.snackbar("Appel interdit", "L'utilisateur n'autorise pas les appels vidéo");
                        return;
                      }
                      Get.toNamed(Routes.callVideoScreen);
                      //Navigator.pop(context);
                    },
                  ),
                ),
               CircleIconButton(
                  size: isSmallPhone ? 50.hw : 40.hw,
                  effectiveSize: isSmallPhone ? 50.hw : 40.hw,
                  minTapSize: isSmallPhone ? 50.hw : 40.hw,
                  backgroundColor: TColors.greyDating.withOpacity(0.6),
                  child: IconButton(
                    icon: Icon(Icons.call, color: TColors.black.withOpacity(0.7), size: 25.hw,),
                    onPressed: (){
                      if (!settingsController.isCallVoice.value) {
                        Get.snackbar("Appel interdit", "L'utilisateur n'autorise pas les appels vocaux");
                        return;
                      } else {
                        Get.toNamed(Routes.callScreen);
                      }
                    },
                  ),
                ), */
              ],
            ),
          ),
          title: Center(
            // SingleChildScrollView (child: scrollDirection: Axis.horizontal,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: null,
              title: Text(
                controller.userChatModel.senderFullName!,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: _appTheme =='light' ? TColors.black : TColors.white,
                  fontSize: 22.fSize,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Row(
                children: [
                  SubTitleWidget(subtitle: "متصل", color: _appTheme =='light' ? TColors.gray700 : TColors.white),
                  if (controller.userChatModel.isConnect) ...[
                    SizedBox(width: 3.adaptSize),
                    CircleAvatar(radius: 6, backgroundColor: Colors.green)
                  ]
                ],
              ),
              trailing: CustomImageView(
                imagePath: controller.userChatModel.senderProfile,
                width: isSmallPhone ? 60.adaptSize :  50.adaptSize,
                height: isSmallPhone ? 60.adaptSize : 50.adaptSize,
                radius: BorderRadius.circular(isSmallPhone ? 60.adaptSize : 50.adaptSize),
                onTap: () async {
                  Get.toNamed(Routes.chatUserProfileScreen,
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

         /* actions: [
            CircleIconButton(
              size: 50.adaptSize,
              backgroundColor: TColors.greyDating.withOpacity(0.6),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_outlined, color: TColors.black.withOpacity(0.7), size: 30.adaptSize,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            )
          ], */
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
        //Si tu veux détecter si le clavier est ouvert pour faire des animations ou réduire la taille des autres widgets,
        // installe => flutter_keyboard_visibility
        /*
        bottomNavigationBar: KeyboardVisibilityBuilder(
         builder: (context, isKeyboardVisible) {
           return Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               if (!isKeyboardVisible)
                 SomeWidgetAboveInput(), // ne s'affiche que si clavier fermé
               buildMessageInput(context),
             ],
           );
         },
       )
         */
      ),
    );
  }

  Widget buildMessageInput(BuildContext context) {
    //final controller = MessageController.instance;
    const double cancelThreshold = -80.0; // pixels to the left
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 8.adaptSize,
          right: 8.adaptSize,
          bottom: MediaQuery.of(context).viewInsets.bottom + 8, // ajoute espace quand clavier ouvert
          top: 8.adaptSize,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Si draft existe, afficher DraftAudioWidget
            Obx(() {
              final draft = controller.pickedAttachment.value;
              if (draft != null && draft.type == MessageType.audio && draft.file != null) {
                return DraftAudioWidget(attachment: draft);
              }
              return SizedBox.shrink();
            }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.12,
                  child: CircleIconButton(
                    size: 60.adaptSize,
                    minTapSize: 60.adaptSize,
                    effectiveSize: 60.adaptSize,
                    backgroundColor: _appTheme =='light' ? TColors.greyDating : TColors.blackGrey,
                    child: IconButton(
                        icon: Icon(Icons.add, color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white, size: 30.adaptSize,),
                        onPressed: () {
                      controller.showAttachmentOptions(context);
                    }),
                  ),
                ),
      
                // Bouton toggle (un clic start/stop)
      
                // Long press mic (record)
              /*
                GestureDetector(
                  onLongPressStart: (_) async {
                    await controller.startRecording();
                  },
                  onLongPressMoveUpdate: (details) {
                    // details.offsetFromOrigin.dx : negative quand l'utilisateur glisse vers la gauche
                    if (details.offsetFromOrigin.dx < cancelThreshold) {
                      controller.isCancelRecording.value = true;
                    } else {
                      controller.isCancelRecording.value = false;
                    }
                  },
                  onLongPressEnd: (_) async {
                    final canceled = controller.isCancelRecording.value;
                    await controller.stopRecordingAndPrepare(canceled: canceled);
                  },
                  child: Obx(() {
                    final rec = controller.isRecording.value;
                    return CircleAvatar(
                      radius: 15,
                      backgroundColor: rec ? Colors.red : Colors.grey.shade300,
                      child: Icon(rec ? Icons.mic : Icons.keyboard_voice_outlined, color: Colors.white),
                    );
                  }),
                ),
                */
      
                SizedBox(width: screenWidth * 0.02),
      
                TRoundedContainer(
                  showBorder: true,
                  borderColor: _appTheme =='light' ? TColors.greyDating : TColors.white,
                 backgroundColor: _appTheme =='light' ? TColors.greyDating : TColors.dark,
                 radius: 35.adaptSize,
                 padding: EdgeInsets.symmetric(horizontal: 2.hw),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     SizedBox(
                       width: screenWidth * 0.1,
                       child: Obx(() {
                         return IconButton(
                           icon: Icon(controller.isRecording.value ? Icons.stop : Icons.keyboard_voice_outlined,
                               color: controller.isRecording.value ? Colors.red : TColors.blackGrey),
                           onPressed: () async => await controller.toggleRecording(),
                         );
                       }),
                     ),
                     SizedBox(
                       width: screenWidth * 0.55,
                       child: Obx(() => Directionality(
                         textDirection: controller.isRTL.value ? TextDirection.rtl : TextDirection.ltr,
                         //textDirection: TextDirection.rtl,
                         child: TextField(
                           controller: controller.messageController,
                           onChanged: (value) => controller.isRTL.value = TDeviceUtils.isArabic(value),
                           /* onChanged: (value) {
                             // Déclenche la reconstruction pour changer la direction
                             controller.update();
                           }, */
                           style: TextStyle(color: _appTheme =='light' ? TColors.black : TColors.white),
                           cursorColor: _appTheme =='light' ? TColors.black : TColors.white,
                           decoration: InputDecoration(
                             hintText: "اكتب رسالة",
                             border: InputBorder.none,
                             hintStyle: TextStyle(color: _appTheme =='light' ? TColors.black : TColors.white)
                           ),
                         ),
                       )),
                     )
                   ],
                 ),
                ),
      
               /* Expanded(
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
                ), */
                SizedBox(width: screenWidth * 0.02),
      
                SizedBox(
                  width: screenWidth * 0.12,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgSend,
                    //width: 50.adaptSize,
                    //height: 50.adaptSize,
                    //radius: BorderRadius.circular(50.adaptSize),
                    onTap: () async {
                      await controller.sendMessage();
                    },
                  ),
                ),
              ],
            ),
      
            // Small recording overlay while recording
            Obx(() {
              if (!controller.isRecording.value) return SizedBox.shrink();
              return Container(
                margin: EdgeInsets.only(top: 6),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mic, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      _format(controller.recordingDuration.value),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Obx(() => Text('Enregistrement',
                      //controller.isCancelRecording.value ? 'Release to cancel' : 'Slide left to cancel',
                      style: TextStyle(color: controller.isCancelRecording.value ? Colors.redAccent : Colors.white70),
                    )),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

/*
  Widget buildMessageInput(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10.adaptSize),
        child: Row(
          children: [
        IconButton(icon: Icon(Icons.add, color: TColors.buttonSecondary, size: 30.adaptSize), onPressed: () {
          controller.showAttachmentOptions(context);
        }),
            Obx(() {
              final recording = controller.isRecording.value;
              return IconButton(
                icon: Icon(
                  recording ? Icons.stop_circle : Icons.keyboard_voice_outlined,
                  color: recording ? Colors.red : TColors.buttonSecondary,
                  size: 30.adaptSize,
                ),
                onPressed: () async {
                  if (recording) {
                    await controller.stopRecordingAndSend();
                  } else {
                    await controller.startRecording();
                  }
                },
              );
            }),
       /* IconButton(
            icon: Icon(Icons.keyboard_voice_outlined, color: TColors.buttonSecondary, size: 30.adaptSize),
            onPressed: () {

            }), */
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
  */

buildDialogSettings(BuildContext context){
  final settingsController = Get.put(SettingsController());
  Get.dialog(
    Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: _appTheme =='light' ? Colors.white : TColors.darkerGrey,

      child: SizedBox(
        height: 420, // fixe la hauteur de ton popup
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(18.hw),
          child: SingleChildScrollView(
            child: Obx(() => Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitleWidget(
                          subtitle: 'مكالمات الفيديو',
                          color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                          fontWeightDelta: 2,
                          fontSizeDelta: 1),
                      Switch(
                        value: settingsController.isCallVideo.value,
                        onChanged: settingsController.toggleCallVideo,
                        activeColor: TColors.yellowAppDark,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.v),
                    child: CustomDividerWidget(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitleWidget(
                          subtitle: 'المكالمات الصوتية',
                          color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                          fontWeightDelta: 2,
                          fontSizeDelta: 1),
                      Switch(
                        value: settingsController.isCallVoice.value,
                        onChanged: settingsController.toggleCallVoice,
                        activeColor: TColors.yellowAppDark,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.v),
                    child: CustomDividerWidget(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitleWidget(
                          subtitle: 'حالة الاتصال بالإنترنت',
                          color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                          fontWeightDelta: 2,
                          fontSizeDelta: 1
                      ),
                      Switch(
                        value: settingsController.isInternetConnection.value,
                        onChanged: (value){
                          settingsController.isInternetConnection.value = value;
                          debugPrint("internet connection : ${settingsController.isInternetConnection.value}");
                        },
                        activeColor: TColors.yellowAppDark,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.v),
                    child: CustomDividerWidget(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Iconsax.user_remove, color: _appTheme =='light' ? TColors.gray700 : TColors.white,),
                      SizedBox(width: 10.hw),
                      SubTitleWidget(
                          subtitle: 'حظر المستخدم',
                          color: _appTheme =='light' ? TColors.gray700 : TColors.white,
                          fontWeightDelta: 2,
                          fontSizeDelta: 1
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    ),
    barrierDismissible: true, // Ferme si l'utilisateur clique à l'extérieur
  );
}
}


