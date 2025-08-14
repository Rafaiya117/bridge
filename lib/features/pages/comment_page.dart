import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tha_bridge/custom_widgets/comment_bubble.dart';
import 'package:tha_bridge/custom_widgets/custom_feed_widgets/post_widget.dart';
import 'package:tha_bridge/model/PostModel.dart';
import 'package:tha_bridge/provider/post_provider.dart';


class CommentPage extends StatefulWidget {
  final String postId;
  const CommentPage({super.key, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late PostModel post;
  final TextEditingController replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PostProvider>(context, listen: false);
    post = provider.posts.firstWhere((p) => p.id == widget.postId);
  }

  void _addComment(String text) {
    if (text.isEmpty) return;
    final provider = Provider.of<PostProvider>(context, listen: false);
    provider.addCommentToPost(
      post,
      Comment(userName: 'You', text: text),
    );
    replyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    post = Provider.of<PostProvider>(context).posts.firstWhere((p) => p.id == widget.postId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/feed'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: PostWidget(
                id: post.id,
                context: context,
                username: post.username,
                timeAgo: post.timeAgo,
                text: post.text,
                imageUrls: post.imageUrls,
                tag: post.tag,
                likeCount: post.likeCount,
                isLiked: post.isLiked,
                toggleLike: () {},
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
              child: Consumer<PostProvider>(
                builder: (context, provider, child) {
                  final postFromProvider = provider.posts.firstWhere(
                    (p) => p.id == widget.postId,
                    orElse: () => PostModel(
                      id: '',
                      username: '',
                      timeAgo: '',
                      text: '',
                      imageUrls: [],
                      tag: null,
                      likeCount: 0,
                      isLiked: false,
                      comments: [],
                    ),
                  );

                  return ListView.builder(
                    itemCount: postFromProvider.comments.length,
                    itemBuilder: (context, index) {
                      final comment = postFromProvider.comments[index];
                      return CommentBubble(
                        userName: comment.userName,
                        userAvatarUrl:'https://randomuser.me/api/portraits/men/$index.jpg',
                        timeAgo: '1 hour ago',
                        commentText: comment.text,
                      );
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              child: Center(
                child: SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: replyController,
                    decoration: InputDecoration(
                      hintText: 'Write your thought',
                      // ignore: deprecated_member_use
                      hintStyle:TextStyle(color: Colors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: const Color(0xFF72BE20),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF009038), width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF009038), width: 2),
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
