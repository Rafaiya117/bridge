import 'package:flutter/material.dart';
import 'package:tha_bridge/custom_widgets/comment_bubble.dart';
import 'package:tha_bridge/custom_widgets/custome_social_post.dart';
import 'package:tha_bridge/model/PostModel.dart';


class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late Post post;
  final TextEditingController replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    post = Post(
      userName: 'John Doe',
      postTime: 'Just now',
      postText: 'This is a dummy post used for development/testing.',
      imageUrl: null,
      comments: [
        Comment(userName: 'Alice', text: 'This project idea sounds amazing! Combining social media with mental health support is something we truly need right now'),
        Comment(userName: 'Bob', text: 'Thanks for sharing!'),
      ],
    );
  }

  void _addComment(String text) {
    setState(() {
      post.comments?.add(Comment(userName: 'You', text: text));
      replyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SocialPostWidget(
                userName: post.userName,
                postTime: post.postTime,
                postText: post.postText,
                imageUrl: post.imageUrl,
                post: post,
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 12.0, top: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Comments:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: post.comments?.length ?? 0,
                itemBuilder: (context, index) {
                  final comment = post.comments![index];
                  return CommentBubble(
                    userName: comment.userName,
                    userAvatarUrl: 'https://randomuser.me/api/portraits/men/$index.jpg',
                    timeAgo: '1 hour ago',
                    commentText: comment.text,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              child: Center(
                child: Container(
                  width: 400,
                  child: TextFormField(
                    controller: replyController,
                    decoration: InputDecoration(
                      hintText: 'Write your thought',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: const Color(0xFF72BE20),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF009038), width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF009038), width: 2),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFF009038)),
                        onPressed: () {
                          final text = replyController.text.trim();
                          if (text.isNotEmpty) {
                            _addComment(text);
                          }
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
