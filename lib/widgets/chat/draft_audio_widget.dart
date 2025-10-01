import 'dart:io';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/attachment_model.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/controller/message_controller.dart';
import 'package:dating_app_bilhalal/widgets/chat/audio_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DraftAudioWidget extends StatelessWidget {
  final AttachmentModel attachment;
  final MessageController controller = MessageController.instance;

  DraftAudioWidget({Key? key, required this.attachment}) : super(key: key);

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final file = attachment.file;
    return Row(
      children: [
        // simple preview player (small)
        if (file != null) Expanded(child: AudioPlayerWidget(file: file)),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(attachment.name ?? 'audio.m4a'),
            SizedBox(height: 4),
            Text(_format(attachment.duration ?? Duration.zero), style: TextStyle(fontSize: 12, color: Colors.grey)),
            Row(
              children: [
                IconButton(
                  icon: Icon(Iconsax.send1, color: TColors.yellowAppDark),
                  onPressed: () async {
                    await controller.sendDraftAudio();
                    //controller.draftAttachment.close();
                    //controller.draftAttachment.value == null;
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await controller.deleteDraftAudio();
                  },
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
