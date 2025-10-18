import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewWidget extends StatefulWidget {
  final File? file;
  final String? url;

  const VideoPreviewWidget({Key? key, this.file, this.url}) : super(key: key);

  @override
  _VideoPreviewWidgetState createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    if (widget.file != null) {
      _controller = VideoPlayerController.file(widget.file!);
    } else if (widget.url != null && widget.url!.isNotEmpty) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!));
    }

    if (_controller != null) {
      await _controller!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _controller!,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        aspectRatio: _controller!.value.aspectRatio,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Chewie(controller: _chewieController!),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}


/*
class VideoPreviewWidget extends StatefulWidget {
  final File? file;
  const VideoPreviewWidget({Key? key, this.file}) : super(key: key);

  @override
  _VideoPreviewWidgetState createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.file != null) {
      _controller = VideoPlayerController.file(widget.file!)
        ..initialize().then((_) {
          _chewieController = ChewieController(
            videoPlayerController: _controller!,
            autoPlay: false,
            looping: false,
            allowFullScreen: true,
            allowMuting: true,
            aspectRatio: _controller!.value.aspectRatio, // 🔹 Important pour le resize
            //deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp]
          );
          setState(() {});
        });
      _chewieController = ChewieController(videoPlayerController: _controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return FittedBox(
      fit: BoxFit.cover, // 🔹 Permet de remplir sans dépasser
      child: SizedBox(
        width: _controller!.value.size.width,
        height: _controller!.value.size.height,
        child: Chewie(controller: _chewieController!),
      ),
    );
    //return Chewie(controller: _chewieController!);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
 */