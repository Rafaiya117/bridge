import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<Map<String, dynamic>> messages = [
    {
      'type': 'image',
      'url': 'https://media.istockphoto.com/id/860120232/photo/joy-of-being-cuddled.jpg?s=612x612&w=0&k=20&c=1_f0I1O3nTslDU2470bDSqnUjYUEOoTdHz3HXvgApso=',
      'caption': 'Look at how chocho sleeps in my arms!',
      'time': '16:46',
    },
    {
      'type': 'text',
      'text': 'Can I come over?',
      'time': '16:46',
      'isSender': true,
    },
    {
      'type': 'video',
      'url': 'https://www.youtube.com/shorts/YVGVVvG4Ol0?feature=share',
      'time': '17:00',
      'isSender': false,
    },
  ];

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _audioRecorder!.openRecorder();
  }

  Future<void> _recordVoice() async {
    if (_isRecording) {
      final path = await _audioRecorder!.stopRecorder();
      setState(() {
        messages.add({
          'type': 'voice',
          'url': path,
          'time': 'Now',
          'isSender': true,
        });
        _isRecording = false;
      });
    } else {
      await _audioRecorder!.startRecorder(
        toFile: 'voice_${DateTime.now().millisecondsSinceEpoch}.aac',
      );
      setState(() => _isRecording = true);
    }
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messages.add({
        'type': 'text',
        'text': _controller.text.trim(),
        'time': 'Now',
        'isSender': true,
      });
      _controller.clear();
    });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        messages.add({
          'type': 'image',
          'url': pickedFile.path,
          'caption': '',
          'time': 'Now',
        });
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        messages.add({
          'type': 'video',
          'url': pickedFile.path,
          'time': 'Now',
          'isSender': true,
        });
      });
    }
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    switch (msg['type']) {
      case 'text':
        return ChatTextBubble(
          text: msg['text'],
          time: msg['time'],
          isSender: msg['isSender'] ?? false,
        );
      case 'image':
        return ChatImageBubble(
          imageUrl: msg['url'],
          caption: msg['caption'] ?? '',
          time: msg['time'],
        );
      case 'video':
        return ChatVideoBubble(videoUrl: msg['url'], time: msg['time']);
      case 'voice':
        return ChatVoiceBubble(audioUrl: msg['url'], time: msg['time']);
      default:
        return const SizedBox();
    }
  }

  @override
  void dispose() {
    _audioRecorder?.closeRecorder();
    _audioRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
  padding: const EdgeInsets.only(left: 12,bottom: 10, top: 10),
  child: Container(
    height: 30,
    width: 36,
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(6),
    ),
    child: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
      padding: const EdgeInsets.all(8), 
      constraints: const BoxConstraints(), 
      onPressed: () => context.go('/walkinggroupchat'),
    ),
  ),
),
        title: Row(
          children: const [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://i.imgur.com/v5VToC2.jpg'),
            ),
            SizedBox(width: 8),
            Text(
              'Athalia Putri',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(messages[index]);
              },
            ),
          ),
          ChatInputBar(
            controller: _controller,
            onSend: _sendMessage,
            onPickImage: _pickImage,
            onPickVideo: _pickVideo,
            onRecordVoice: _recordVoice,
          ),
        ],
      ),
    );
  }
}

class ChatVoiceBubble extends StatelessWidget {
  final String audioUrl;
  final String time;

  const ChatVoiceBubble({
    super.key,
    required this.audioUrl,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.play_arrow, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              'Voice Message',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: Text(
            time,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

// VIDEO BUBBLE
class ChatVideoBubble extends StatefulWidget {
  final String videoUrl;
  final String time;
  const ChatVideoBubble({
    super.key,
    required this.videoUrl,
    required this.time,
  });

  @override
  State<ChatVideoBubble> createState() => _ChatVideoBubbleState();
}

class _ChatVideoBubbleState extends State<ChatVideoBubble> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl.startsWith('http')) {
      _videoController = VideoPlayerController.network(widget.videoUrl);
    } else {
      _videoController = VideoPlayerController.file(File(widget.videoUrl));
    }
    _videoController.initialize().then((_) {
      setState(() {});
    });
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _videoController.value.isInitialized
            ? SizedBox(
                width: 240,
                child: Chewie(controller: _chewieController!),
              )
            : const SizedBox(
                width: 240,
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: Text(
            widget.time,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

// MESSAGE INPUT
class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onPickImage;
  final VoidCallback onPickVideo;
  final VoidCallback onRecordVoice;
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onPickImage,
    required this.onPickVideo,
    required this.onRecordVoice,
  });

  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.image, color: Colors.green),
                title: const Text('Pick Image'),
                onTap: () {
                  Navigator.pop(context);
                  onPickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam, color: Colors.green),
                title: const Text('Pick Video'),
                onTap: () {
                  Navigator.pop(context);
                  onPickVideo();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 50, top: 8),
      child: Row(
        children: [
          // "+" button to open picker options
          IconButton(
            icon: const Icon(Icons.add, color: Colors.green),
            onPressed: () => _showPickerOptions(context),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type a message...',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.green),
            onPressed: onRecordVoice,
          ),
        const SizedBox(width: 4),
          CircleAvatar(
            backgroundColor: const Color(0xFF4CAF50),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: onSend,
            ),
          ),
          
        ],
      ),
    );
  }
}
// TEXT BUBBLE
class ChatTextBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isSender;

  const ChatTextBubble({
    super.key,
    required this.text,
    required this.time,
    this.isSender = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSender ? const Color(0xFFDCF8C6) : const Color(0xFFEDEDED);
    final align = isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isSender
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 4),
          constraints: const BoxConstraints(maxWidth: 280),
          decoration: BoxDecoration(color: bgColor, borderRadius: radius),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            time,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

// IMAGE BUBBLE
class ChatImageBubble extends StatelessWidget {
  final String imageUrl;
  final String caption;
  final String time;

  const ChatImageBubble({
    super.key,
    required this.imageUrl,
    required this.caption,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = imageUrl.startsWith('http');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: isNetwork
              ? Image.network(imageUrl, width: 240)
              : Image.file(File(imageUrl), width: 240),
        ),
        const SizedBox(height: 4),
        Text(caption),
        Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 12),
          child: Text(
            time,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
