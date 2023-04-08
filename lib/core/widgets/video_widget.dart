import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VedioWidget extends StatefulWidget {
  const VedioWidget({super.key});

  @override
  State<VedioWidget> createState() => _VedioWidgetState();
}

class _VedioWidgetState extends State<VedioWidget> {
  late VideoPlayerController _controller;
  bool initialize = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://static.vecteezy.com/system/resources/previews/001/624/889/mp4/polishing-wax-on-car-free-video.mp4',
    )..initialize().then((_) {
        Future.delayed(Duration.zero, () {
          setState(() {
            initialize = true;
          });
        });
      });
  }

  @override
  Widget build(BuildContext context) => initialize
      ? ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: !_controller.value.isPlaying ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      : Container();
}
