import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CommonVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;

  const CommonVideoPlayer({
    required this.videoUrl,
    required this.videoTitle,
    Key? key,
  }) : super(key: key);

  @override
  _CommonVideoPlayerState createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final player = AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(_controller),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F111D),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              ControlButtons(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class ControlButtons extends StatelessWidget {
  final VideoPlayerController controller;

  const ControlButtons({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
          icon: Icon(
            controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
