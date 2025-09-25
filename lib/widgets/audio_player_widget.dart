import 'dart:io';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/controller/discussion_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

///Using Stateful
class AudioPlayerWidget extends StatefulWidget {
  final File file;
  const AudioPlayerWidget({Key? key, required this.file}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}
class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () async {
            if (isPlaying) {
              await player.pause();
            } else {
              await player.setFilePath(widget.file.path);
              await player.play();
            }
            setState(() => isPlaying = !isPlaying);
          },
        ),
        Text(widget.file.path.split('/').last),
      ],
    );
  }
}



///Using Controller
/*
class AudioPlayerWidget extends StatelessWidget {
  final File file;
  final controller = DiscussionDetailsController.instance;

  AudioPlayerWidget({Key? key, required this.file}) : super(key: key);

  String formatTime(Duration d) {
    final min = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final sec = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pos = controller.currentPosition.value;
      final total = controller.totalDuration.value;

      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                color: Colors.blue,
              ),
              onPressed: () async {
                if (controller.isPlaying.value) {
                  await controller.pauseAudio();
                } else {
                  await controller.playAudio(file.path);
                }
              },
            ),
            Expanded(
              child: Slider(
                value: pos.inSeconds.toDouble(),
                min: 0,
                max: total.inSeconds.toDouble(),
                onChanged: (value) {
                  controller.player.seek(Duration(seconds: value.toInt()));
                },
              ),
            ),
            Text("${formatTime(pos)} / ${formatTime(total)}"),
          ],
        ),
      );
    });
  }
}
*/