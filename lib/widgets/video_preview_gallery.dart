import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewGallery extends StatefulWidget {
  final File? file;
  final String? url;

  const VideoPreviewGallery({Key? key, this.file, this.url}) : super(key: key);

  @override
  _VideoPreviewGalleryState createState() => _VideoPreviewGalleryState();
}

class _VideoPreviewGalleryState extends State<VideoPreviewGallery> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(covariant VideoPreviewGallery oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 👉 Réinitialiser seulement si le fichier ou l'URL ont changé
    if (oldWidget.file?.path != widget.file?.path ||
        oldWidget.url != widget.url) {
      _disposePlayer();
      _initializePlayer();
    }
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
        allowFullScreen: false,  // Disable fullscreen for previews
        allowMuting: false,      // Optional: hide mute if not needed
        showControls: false,     // ✅ Key: Disable controls to prevent flex overflow
        aspectRatio: _controller!.value.aspectRatio,
        // Optional: Use custom overlay for play button (see below)
      );
      if (mounted) setState(() {});
    }
  }

  void _disposePlayer() {
    _controller?.dispose();
    _chewieController?.dispose();
    _controller = null;
    _chewieController = null;
  }

  @override
  void dispose() {
    _disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final aspectRatio = _controller!.value.aspectRatio;
        final preferredWidth = constraints.maxWidth;
        final preferredHeight = preferredWidth / aspectRatio;

        double displayWidth;
        double displayHeight;

        if (preferredHeight <= constraints.maxHeight) {
          displayWidth = preferredWidth;
          displayHeight = preferredHeight;
        } else {
          displayHeight = constraints.maxHeight;
          displayWidth = displayHeight * aspectRatio;
        }

        return GestureDetector(  // ✅ Add tap to play/pause
          onTap: () {
            if (_controller!.value.isPlaying) {
              _controller!.pause();
            } else {
              _controller!.play();
            }
            if (mounted) setState(() {});  // Refresh to show/hide play icon
          },
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(  // ✅ Stack for video + centered play icon overlay
              fit: StackFit.expand,
              children: [
                Center(
                  child: SizedBox(
                    width: displayWidth,
                    height: displayHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Chewie(controller: _chewieController!),
                    ),
                  ),
                ),
                // ✅ Semi-transparent play icon overlay (shows when paused)
                if (!_controller!.value.isPlaying)
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,  // Subtle overlay
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40,  // Adjust for cell size
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

}