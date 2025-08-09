import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/model/PostModel.dart';

class SocialPostWidget extends StatefulWidget {
  final String userName;
  final String postTime;
  final String postText;
  final String? imageUrl;
  final Post? post;
  const SocialPostWidget({
    super.key,
    required this.userName,
    required this.postTime,
    required this.postText,
    this.imageUrl,
    this.post
  });
  @override
  State<SocialPostWidget> createState() => _SocialPostWidgetState();
}

class _SocialPostWidgetState extends State<SocialPostWidget> {
  int likeCount = 190000;
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Row
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(widget.postTime,
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Post Text
          Text(
            widget.postText,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 12),
          // Post Image (optional)
          if (widget.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
              ),
            ),
          const SizedBox(height: 12),
          // Like count row
          GestureDetector(
            onTap: toggleLike,
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.green : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  '${(likeCount / 1000).toStringAsFixed(0)}k People like this post',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),

          //const Divider(height: 32,),
          SizedBox(height: 5.h,),
          // Reactions row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReactionButton(
                icon: Icons.favorite_border,
                text: "Love",
                onTap: toggleLike,
                active: isLiked,
              ),
              ReactionButton(
                icon: Icons.comment,
                text: "Comment",
                onTap: () => context.go('/comment_page',extra: widget.post),
              ),
              ReactionButton(
                icon: Icons.repeat,
                text: "Repost",
                onTap: () => print('Repost tapped'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReactionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool active;

  const ReactionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: active ? Colors.green : Colors.black87,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: active ? Colors.green : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
