import 'package:flutter/material.dart';
import 'package:tha_bridge/custom_widgets/custom_videoplayer.dart';
import 'package:video_player/video_player.dart';

class VideoFeedPage extends StatefulWidget {
  @override
  _VideoFeedPageState createState() => _VideoFeedPageState();
}

class _VideoFeedPageState extends State<VideoFeedPage> {
  List<String> videoUrls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
  ];

  List<VideoPlayerController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (var url in videoUrls) {
      // ignore: deprecated_member_use
      final controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
        });
      controllers.add(controller);
    }

    // Auto-play the first video
    if (controllers.isNotEmpty) controllers[0].play();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return VideoPage(
            controller: controllers[index],
            isPlaying: controllers[index].value.isPlaying,
            onTogglePlay: () {
              setState(() {
                final controller = controllers[index];
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              });
            },
          );
        },
        onPageChanged: (index) {
          for (int i = 0; i < controllers.length; i++) {
            if (i == index) {
              controllers[i].play();
            } else {
              controllers[i].pause();
            }
          }
        },
      ),
    );
  }
}