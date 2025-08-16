import 'package:flutter/material.dart';
import 'package:tha_bridge/components/topnav.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isPlaying;
  final VoidCallback onTogglePlay;

  const VideoPage({
    required this.controller,
    required this.isPlaying,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.value.isPlaying) {
          // Pause immediately on tap anywhere while playing
          onTogglePlay();
        }
      },

      // Added drag to seek functionality here:
      onHorizontalDragUpdate: (details) async {
        if (!controller.value.isInitialized) return;

        final duration = controller.value.duration;
        if (duration == null) return;

        final position = controller.value.position;
        // Adjust this sensitivity as needed; 10 pixels = 1 second seek
        final seekDeltaSeconds = details.delta.dx / 10;

        Duration newPosition =
            position + Duration(seconds: seekDeltaSeconds.round());

        // Clamp the new position between 0 and video duration
        if (newPosition < Duration.zero) newPosition = Duration.zero;
        if (newPosition > duration) newPosition = duration;

        await controller.seekTo(newPosition);
      },

      child: Stack(
        children: [
          // 🔴 Background Video
          controller.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),

          // ✅ Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: TopBar(
                firstIcon: Icons.phone,
                secondIcon: Icons.notifications,
                firstIconColor: Colors.red,
                secondIconColor: Colors.black,
                profileImageUrl:
                    'https://randomuser.me/api/portraits/women/44.jpg',
              ),
            ),
          ),

          // ✅ Floating Button
          Positioned(
            top: 110,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color(0xFF009038),
              child: const Icon(Icons.add, color: Colors.white),
              mini: true,
              shape: const CircleBorder(),
            ),
          ),

          // ✅ Play Button with delayed start
          ValueListenableBuilder<VideoPlayerValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              if (!value.isPlaying) {
                return Center(
                  child: GestureDetector(
                    onTap: () async {
                      // Play icon stays visible briefly before playback starts
                      await Future.delayed(Duration(milliseconds: 150));
                      onTogglePlay();
                    },
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 70,
                      color: Colors.greenAccent,
                    ),
                  ),
                );
              }
              return SizedBox.shrink(); // Hide button when playing
            },
          ),

          // ✅ Bottom Info Card
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // ignore: deprecated_member_use
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Makama",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Row(
                          children: [
                            Text("Walk", style: TextStyle(color: Colors.white)),
                            Icon(Icons.arrow_drop_down, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "This project idea sounds amazing!\nCombining social media with mental\nhealth support is something we truly\nneed right now",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
