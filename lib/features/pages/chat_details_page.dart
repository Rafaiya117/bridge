import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      'type': 'image',
      'url':
      'https://images.unsplash.com/photo-1600250397359-f84f0b5cc944',
      'caption': 'Look at how chocho sleeps in my arms!',
      'time': '16:46'
    },
    {
      'type': 'text',
      'text': 'Can I come over?',
      'time': '16:46',
      'isSender': true
    },
    {
      'type': 'video',
      'url':
      'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
      'time': '17:00',
      'isSender': false
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messages.add({
        'type': 'text',
        'text': _controller.text.trim(),
        'time': 'Now',
        'isSender': true
      });
      _controller.clear();
    });
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
          caption: msg['caption'],
          time: msg['time'],
        );
      case 'video':
        return ChatVideoBubble(
          videoUrl: msg['url'],
          time: msg['time'],
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
          ),
        ],
      ),
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
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
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
            child: Center(child: CircularProgressIndicator())),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: Text(widget.time,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ),
      ],
    );
  }
}

// MESSAGE INPUT
class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 16, top: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
          CircleAvatar(
            backgroundColor: const Color(0xFF4CAF50),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: onSend,
            ),
          )
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
    final bgColor = isSender ? const Color(0xFFEDEDED) : Colors.white;
    final align =
    isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
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
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
          ),
          child: Text(text, style: const TextStyle(color: Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(time,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(imageUrl, width: 240),
        ),
        const SizedBox(height: 4),
        Text(caption),
        Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 12),
          child: Text(time,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ),
      ],
    );
  }
}
