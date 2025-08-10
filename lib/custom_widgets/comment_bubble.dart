import 'package:flutter/material.dart';

class Reply {
  final String userAvatarUrl;
  final String replyText;

  Reply({required this.userAvatarUrl, required this.replyText});
}

class CommentBubble extends StatefulWidget {
  final String userName;
  final String userAvatarUrl;
  final String timeAgo;
  final String commentText;

  const CommentBubble({
    super.key,
    required this.userName,
    required this.userAvatarUrl,
    required this.timeAgo,
    required this.commentText,
  });

  @override
  _CommentBubbleState createState() => _CommentBubbleState();
}

class _CommentBubbleState extends State<CommentBubble> {
  bool _isReplying = false;
  final TextEditingController _replyController = TextEditingController();
  final List<Reply> _replies = [];
  final String currentUserAvatar = 'https://i.pravatar.cc/150?img=5';

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(widget.userAvatarUrl),
              ),
              const SizedBox(width: 8),
              // Comment content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Comment bubble with max width
                    Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                widget.timeAgo,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Comment text
                          Text(
                            widget.commentText,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Like and comment icons
                    Row(
                      children: [
                        const Icon(Icons.thumb_up_alt_outlined, size: 20),
                        const SizedBox(width: 16),
                        // Comment icon with onTap
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isReplying = !_isReplying;
                            });
                          },
                          child: const Icon(Icons.comment_outlined, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),

          // Reply input field and send button (conditionally shown)
          if (_isReplying)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 8), // Indent reply field
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _replyController,
                      decoration: const InputDecoration(
                        hintText: 'Write a reply...',
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      final replyText = _replyController.text.trim();
                      if (replyText.isNotEmpty) {
                        setState(() {
                          _replies.add(Reply(
                              userAvatarUrl: currentUserAvatar,
                              replyText: replyText));
                          _replyController.clear();
                          _isReplying = false;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Render all replies below as small comment bubbles with avatar
          for (var reply in _replies)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(reply.userAvatarUrl),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        reply.replyText,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
