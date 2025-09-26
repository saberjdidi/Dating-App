import 'dart:async';
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

  var recordingDuration = Duration.zero.obs;
  Timer? _recordTick;
  Stopwatch? _recordStopwatch;
  var isCancelRecording = false.obs; // set by drag detection

  // Draft attachment (audio ready to send but not sent yet)
  var draftAttachment = Rxn<AttachmentModel>();

  // Optional: a central player you may want to reuse (or use one per widget)
  final AudioPlayer sharedPlayer = AudioPlayer();

  Future<void> toggleRecording() async {
    if (isRecording.value) {
      // Si on enregistre → arrêter
      await stopRecordingAndPrepare();
    } else {
      // Si on n’enregistre pas → démarrer
      await startRecording();
    }
  }

// ---------------- Recording ----------------
  Future<void> startRecording() async {
    // Avant de commencer un nouvel enregistrement, on reset tout
    //await cancelDraftAudio();  // <-- reset complet
    // Réinitialiser l’état pour un nouvel enregistrement
    draftAttachment.value = null;
    currentRecordingPath = null;
    recordingDuration.value = Duration.zero;

    final hasPermission = await record.hasPermission();
    if (!hasPermission) {
      Get.snackbar('Permission', 'Microphone permission required');
      return;
    }

    final dir = await getTemporaryDirectory();
    final fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
    final path = p.join(dir.path, fileName);

    await record.start(
      RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
      path: path,
    );

    currentRecordingPath = path;
    isRecording.value = true;
    recordingDuration.value = Duration.zero;

    // Timer pour la durée // Démarrer chrono
    _recordStopwatch = Stopwatch()..start();
    _recordTick?.cancel();
    _recordTick = Timer.periodic(Duration(milliseconds: 200), (_) {
      recordingDuration.value = _recordStopwatch!.elapsed;
    });
  }
  /*
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
      isCancelRecording.value = false;

      // Stopwatch + periodic tick (update duration in real time)
      _recordStopwatch = Stopwatch()..start();
      _recordTick?.cancel();
      _recordTick = Timer.periodic(Duration(milliseconds: 200), (_) {
        recordingDuration.value = _recordStopwatch!.elapsed;
      });
    } catch (e, st) {
      debugPrint('startRecording error: $e\n$st');
      Get.snackbar('Error', 'Unable to start recording');
      isRecording.value = false;
    }
  }
  */

  /// Arrêter l'enregistrement et créer l'AttachmentModel puis l'envoyer
  // Called when user releases long press
  // if canceled -> delete temp file and reset, else prepare draftAttachment
  Future<void> stopRecordingAndPrepare() async {
    final path = await record.stop();
    _recordStopwatch?.stop();
    _recordTick?.cancel();
    _recordStopwatch = null;
    isRecording.value = false;

    if (path != null) {
      final f = File(path);
      draftAttachment.value = AttachmentModel(
        type: MessageType.audio,
        file: f,
        name: p.basename(path),
        duration: recordingDuration.value,
      );
      recordingDuration.value = Duration.zero;
      //currentRecordingPath = path; // <-- bien garder le dernier path
    }
  }
  /*
  Future<void> stopRecordingAndPrepare({bool canceled = false}) async {
    try {
      final path = await record.stop(); // returns path or null
      _recordTick?.cancel();
      _recordStopwatch?.stop();
      _recordStopwatch = null;
      isRecording.value = false;

      if (canceled || isCancelRecording.value) {
        // delete temp file if exists and reset
        if (path != null) {
          final f = File(path);
          if (await f.exists()) await f.delete();
        }
        currentRecordingPath = null;
        recordingDuration.value = Duration.zero;
        draftAttachment.value = null;
        return;
      }

      if (path != null) {
        final f = File(path);
        final dur = recordingDuration.value;
        draftAttachment.value = AttachmentModel(
          type: MessageType.audio,
          file: f,
          name: p.basename(path),
          duration: dur,
        );
        currentRecordingPath = path;
        // recordingDuration already set by stopwatch
      } else {
        // nothing recorded
        recordingDuration.value = Duration.zero;
        draftAttachment.value = null;
      }
    } catch (e, st) {
      debugPrint('stopRecording error: $e\n$st');
      Get.snackbar('Error', 'Unable to stop recording');
    } finally {
      // ensure timer stopped
      _recordTick?.cancel();
      _recordTick = null;
    }
  }
  */
  Future<void> cancelRecordingCompletely() async {
    try {
      await record.stop();
      if (currentRecordingPath != null) {
        final f = File(currentRecordingPath!);
        if (await f.exists()) await f.delete();
      }
    } catch (_) {}
    currentRecordingPath = null;
    draftAttachment.value = null;
    isRecording.value = false;
    recordingDuration.value = Duration.zero;
    _recordTick?.cancel();
  }

  // Delete a draft audio (before send)
  Future<void> deleteDraftAudio() async {
    final att = draftAttachment.value;
    if (att?.file != null) {
      try {
        final f = att!.file!;
        if (await f.exists()) await f.delete();
      } catch (_) {}
    }
    draftAttachment.value = null;
    recordingDuration.value = Duration.zero;
  }

  // Send recorded audio (draft -> message)
  Future<void> sendDraftAudio() async {
    final att = draftAttachment.value;
    if (att == null) return;
    final msg = MessageModel(
      messageId: DateTime.now().toIso8601String(),
      senderUid: "user1",
      receiverUid: "user2",
      senderName: "Alice",
      receiverName: "Bob",
      senderProfile: "assets/images/alice.jpg",
      receiverProfile: "assets/images/bob.jpg",
      text: null,
      attachment: att,
      createdAt: DateTime.now(),
    );
    messages.add(msg);
    // Réinitialiser l’état pour un nouvel enregistrement
    draftAttachment.value = null;
    currentRecordingPath = null;
    recordingDuration.value = Duration.zero;
   /* Future.delayed(const Duration(milliseconds: 1500), (){
      cancelDraftAudio();
    }); */
  }

  /// Supprimer le draft et le fichier temporaire
  Future<void> cancelDraftAudio() async {
    if (currentRecordingPath != null) {
      final f = File(currentRecordingPath!);
      if (await f.exists()) await f.delete();
    }
    currentRecordingPath = null;
    draftAttachment.value = null;
  }

  // ---------------- Playback helper (optional centralized player) ----------------
  // You can use sharedPlayer or a per-widget player. Here are helper wrappers:
  Future<void> playFile(String path) async {
    try {
      await sharedPlayer.setFilePath(path);
      await sharedPlayer.play();
    } catch (e) {
      debugPrint('playFile error: $e');
    }
  }

  Future<void> pausePlayback() async => await sharedPlayer.pause();
  Future<void> stopPlayback() async => await sharedPlayer.stop();


  @override
  void onClose() {
    _recordTick?.cancel();
    sharedPlayer.dispose();
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

