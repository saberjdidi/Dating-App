import 'dart:io';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/datasources/message_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/attachment_model.dart';
import 'package:dating_app_bilhalal/data/models/chat_model.dart';
import 'package:dating_app_bilhalal/data/models/message_model.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DiscussionDetailsController extends GetxController {
  static DiscussionDetailsController get instance => Get.find();

  ChatModel userChatModel  = Get.arguments['ChatDiscussion'] ?? ChatModel.empty();
  final TextEditingController messageController = TextEditingController();
  var messages = <MessageModel>[].obs;

  var pickedAttachment = Rx<AttachmentModel?>(null);

  ///Record Audio Start
  final record = AudioRecorder();
  var isRecording = false.obs;
  String? currentRecordingPath; //var currentRecordingPath = RxString('');


  Future<void> startRecording() async {
    try {
      // Vérifier permission (Record fournit hasPermission)
      final hasPermission = await record.hasPermission();
      if (!hasPermission) {
        Get.snackbar('Permission', 'Microphone permission is required');
        return;
      }

      // Crée un chemin de fichier temporaire unique
      final dir = await getTemporaryDirectory();
      final fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      final path = p.join(dir.path, fileName);

      // Démarrer avec RecordConfig (nouvelle API)
      await record.start(
        RecordConfig(
          encoder: AudioEncoder.aacLc, // format courant
          bitRate: 128000,             // en bits/s
          sampleRate: 44100,           // Hz
        ),
        path: path, // chemin requis (nommé)
      );

      currentRecordingPath = path;
      isRecording.value = true;
    } catch (e, st) {
      debugPrint('startRecording error: $e\n$st');
      Get.snackbar('Error', 'Unable to start recording');
    }
  }

  /// Arrêter l'enregistrement et créer l'AttachmentModel puis l'envoyer
  Future<void> stopRecordingAndSend() async {
    try {
      // stop retourne le path si l'enregistrement s'est bien terminé
      final resultPath = await record.stop();
      isRecording.value = false;

      if (resultPath != null && resultPath.isNotEmpty) {
        // Constituer l'attachment et l'ajouter comme message
        final file = File(resultPath);
        pickedAttachment.value = AttachmentModel(
          type: MessageType.audio,
          file: file,
          name: p.basename(resultPath),
        );

        // Exemple d'envoi : ajoute en local à ta liste messages
        messages.add(
          MessageModel(
            messageId: DateTime.now().toIso8601String(),
            senderUid: 'user1',
            receiverUid: 'user2',
            senderName: 'Alice',
            receiverName: 'Bob',
            senderProfile: 'assets/images/alice.jpg',
            receiverProfile: 'assets/images/bob.jpg',
            text: null,
            attachment: pickedAttachment.value,
            createdAt: DateTime.now(),
          ),
        );

        // réinitialiser le pickedAttachment si tu veux l'effacer après envoi
        pickedAttachment.value = null;
      } else {
        Get.snackbar('Recording', 'No audio captured');
      }
    } catch (e, st) {
      debugPrint('stopRecording error: $e\n$st');
      Get.snackbar('Error', 'Unable to stop recording');
    }
  }

  Future<void> cancelRecording() async {
    try {
      await record.stop();
      isRecording.value = false;
      if (currentRecordingPath != null) {
        final f = File(currentRecordingPath!);
        if (await f.exists()) await f.delete();
      }
      currentRecordingPath = null;
    } catch (_) {}
  }

// Lecture de l'audio
  /*
  final player = AudioPlayer();
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  Future<void> playAudio(String path) async {
    await player.setFilePath(path);
    totalDuration.value = player.duration ?? Duration.zero;

    player.positionStream.listen((pos) {
      currentPosition.value = pos;
    });

    player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    await player.play();
  }

  // Pause
  Future<void> pauseAudio() async {
    await player.pause();
  }

  // Stop
  Future<void> stopAudio() async {
    await player.stop();
    currentPosition.value = Duration.zero;
  }
  */

  @override
  void onClose() {
    //player.dispose();
    record.dispose();
    super.onClose();
  }
  ///Record Audio End

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
                      pickDocument();
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

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final fileName = result.files.single.name;

      pickedAttachment.value = AttachmentModel(
        type: MessageType.document,
        file: file,
        name: fileName
      ); // Ton Rx<File?>
    }
  }

}

