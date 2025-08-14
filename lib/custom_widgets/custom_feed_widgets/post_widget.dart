import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/model/PostModel.dart';

class PostWidget extends StatefulWidget {
  final BuildContext context;
  final String id; // <-- add this
  final String username;
  final String timeAgo;
  final String text;
  final List<String>? imageUrls;
  final String? tag;
  final int likeCount;
  final bool isLiked;
  final VoidCallback toggleLike;

  const PostWidget({
    super.key,
    required this.context,
    required this.id, // <-- add this
    required this.username,
    required this.timeAgo,
    required this.text,
    this.imageUrls,
    this.tag,
    required this.likeCount,
    required this.isLiked,
    required this.toggleLike,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}
class _PostWidgetState extends State<PostWidget> {
  late int _likeCount;
  late bool _isLiked;
  @override
  void initState() {
    super.initState();
    _likeCount = widget.likeCount;
    _isLiked = widget.isLiked;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });

    widget.toggleLike();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-avatar-image-for-profile-png-image_13001877.png',
                ),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.timeAgo, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              if (widget.tag != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAFBF1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF1AA260)),
                  ),
                  child: Text(
                    widget.tag!,
                    style: const TextStyle(
                      color: Color(0xFF1AA260),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.text,
            style: const TextStyle(fontSize: 14.5, height: 1.4),
          ),
          if (widget.imageUrls != null && widget.imageUrls!.isNotEmpty) ...[
            const SizedBox(height: 10),
            SizedBox(
              height: 155,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.imageUrls!.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final url = widget.imageUrls![index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 343.w,
                      height: 155.h,
                      child: Image.network(url, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.favorite, color: _isLiked ? Colors.green : Colors.grey, size: 18),
              const SizedBox(width: 4),
              Text(
                "$_likeCount People like this post",
                style: TextStyle(color: _isLiked ? Colors.green : Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(
                icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                label: 'Love',
                onTap: _toggleLike,
                color: _isLiked ? const Color.fromARGB(255, 241, 23, 23) : Colors.black,
              ),
             _buildActionButton(
              icon: Icons.comment_outlined,
              label: 'Comment',
              onTap: () {
              widget.context.go('/comments/${widget.id}');
            },
           ),

              _buildActionButton(
                icon: Icons.repeat,
                label: 'Repost',
                onTap: () {
                  widget.context.go('/repost');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
