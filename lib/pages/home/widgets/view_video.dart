import 'dart:io';

import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

class VideoView extends StatefulWidget {
  const VideoView({
    super.key,
    required this.video,
    required this.onVideoSelected,
  });

  final File video;
  final void Function(File video) onVideoSelected;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final VideoPlayerController _videoController;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      }).catchError((error) {
        print('Error initializing video player: $error');
        // Có thể hiện một thông báo hoặc xử lý lỗi khác
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_videoController.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: Stack(
        children: [
          // Transform(
          //   alignment: Alignment.center,
          //   transform: Matrix4.rotationZ(
          //       1.5708), // 90 độ // Điều chỉnh góc xoay tại đây
          //   child: VideoPlayer(_videoController),
          // ),
          VideoPlayer(_videoController),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                if (isPlaying) {
                  _videoController.pause();
                } else {
                  _videoController.play();
                }
                isPlaying = !isPlaying;
                setState(() {});
              },
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                widget.onVideoSelected(widget.video);
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
