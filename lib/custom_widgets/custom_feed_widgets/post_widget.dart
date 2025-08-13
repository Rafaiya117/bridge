import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PostWidget extends StatelessWidget {
  final BuildContext context;
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(timeAgo, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              if (tag != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAFBF1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF1AA260)),
                  ),
                  child: Text(
                    tag!,
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
            text,
            style: const TextStyle(fontSize: 14.5, height: 1.4),
          ),
          if (imageUrls != null && imageUrls!.isNotEmpty) ...[
            const SizedBox(height: 10),
            SizedBox(
              height: 155,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls!.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final url = imageUrls![index];
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
              const Icon(Icons.favorite, color: Colors.green, size: 18),
              const SizedBox(width: 4),
              Text(
                "$likeCount People like this post",
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(
                icon: isLiked ? Icons.favorite : Icons.favorite_border,
                label: 'Love',
                onTap: toggleLike,
                color: isLiked ? Colors.green : Colors.black,
              ),
              _buildActionButton(
                icon: Icons.comment_outlined,
                label: 'Comment',
                onTap: () {
                  this.context.go('/comments');
                },
              ),
              _buildActionButton(
                icon: Icons.repeat,
                label: 'Repost',
                onTap: () {
                  this.context.go('/repost');
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
