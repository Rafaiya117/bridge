import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  List<VideoPlayerController> _controllers = [];
  List<String> _videoUrls = [];
  int _currentIndex = 0;

  List<VideoPlayerController> get controllers => _controllers;
  int get currentIndex => _currentIndex;

  Future<void> initVideos() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/videos.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    _videoUrls = List<String>.from(jsonList);

    // Initialize controller for each video URL
    _controllers = List.generate(
      _videoUrls.length,
      // ignore: deprecated_member_use
      (index) => VideoPlayerController.network(_videoUrls[index]),
    );

    // Initialize the first video controller
    await _controllers[0].initialize();
    _controllers[0].setLooping(true);
    _controllers[0].play();

    notifyListeners();
  }

  void togglePlayPause(int index) {
    final controller = _controllers[index];
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    notifyListeners();
  }

  void changeVideo(int index) async {
    for (int i = 0; i < _controllers.length; i++) {
      final controller = _controllers[i];

      if (i == index) {
        if (!controller.value.isInitialized) {
          await controller.initialize();
          controller.setLooping(true);
        }
        controller.play();
      } else {
        controller.pause();
      }
    }

    // Optional: Preload the next video in the background
    if (index + 1 < _controllers.length) {
      final nextController = _controllers[index + 1];
      if (!nextController.value.isInitialized) {
        await nextController.initialize();
        nextController.setLooping(true);
      }
    }

    _currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
