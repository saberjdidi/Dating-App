import 'dart:async';
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
  late final AudioPlayer _player;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<PlayerState>? _stateSub;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setFilePath(widget.file.path);
      _duration = _player.duration ?? Duration.zero;

      _posSub = _player.positionStream.listen((p) {
        setState(() => _position = p);
      });

      _stateSub = _player.playerStateStream.listen((state) {
        setState(() => _isPlaying = state.playing);
        // When completed, reset position
        if (state.processingState == ProcessingState.completed) {
          _player.seek(Duration.zero);
          _player.pause();
        }
      });
    } catch (e) {
      debugPrint('AudioPlayer init error: $e');
    }
  }

  @override
  void dispose() {
    _posSub?.cancel();
    _stateSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  String _formatTime(Duration d) {
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle_fill, size: 30),
          onPressed: () async {
            if (_isPlaying) await _player.pause();
            else await _player.play();
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Slider(
                min: 0,
                max: _duration.inMilliseconds.toDouble() > 0 ? _duration.inMilliseconds.toDouble() : 1,
                value: _position.inMilliseconds.toDouble().clamp(0, _duration.inMilliseconds.toDouble() > 0 ? _duration.inMilliseconds.toDouble() : 1),
                onChanged: (value) {
                  _player.seek(Duration(milliseconds: value.toInt()));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatTime(_position), style: TextStyle(fontSize: 12)),
                  Text(_formatTime(_duration), style: TextStyle(fontSize: 12)),
                ],
              )
            ],
          ),
        ),
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