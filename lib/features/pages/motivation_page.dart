import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tha_bridge/custom_widgets/custom_videoplayer.dart';
import 'package:tha_bridge/provider/video_provider.dart';
import 'package:video_player/video_player.dart';

class VideoFeedPage extends StatelessWidget {
  const VideoFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (context, provider, _) {
        final controllers = provider.controllers;

        // Show loading screen while videos are initializing
        if (controllers.isEmpty) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controllers.length,
            itemBuilder: (context, index) {
              return VideoPage(
                controller: controllers[index],
                isPlaying: controllers[index].value.isPlaying,
                onTogglePlay: () {
                  provider.togglePlayPause(index);
                },
              );
            },
            onPageChanged: (index) {
              provider.changeVideo(index);
            },
          ),
        );
      },
    );
  }
}