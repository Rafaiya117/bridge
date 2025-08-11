import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/topnav.dart';
import 'package:tha_bridge/custom_widgets/custome_searchbar.dart';



class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int likeCount = 100;
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }
  final List<Map<String, String>> notes = [
    {'text': 'Chilling', 'image': 'https://via.placeholder.com/150'},
    {'text': 'Working', 'image': 'https://via.placeholder.com/150'},
    {'text': 'Available', 'image': 'https://via.placeholder.com/150'},
    {'text': 'In gym', 'image': 'https://via.placeholder.com/150'},
    {'text': 'Call me', 'image': 'https://via.placeholder.com/150'},
    {'text': 'On a break', 'image': 'https://via.placeholder.com/150'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            TopBar(
              firstIcon: Icons.phone,
              secondIcon: Icons.notifications,
              firstIconColor: Colors.red,
              secondIconColor: Colors.black,
              profileImageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
            ),
            SizedBox(height: 10.h),
            SearchAndActionBar(
              buttonText: 'Create a Post',
              onButtonPressed: () {
                context.go('/new_post');
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildNoteSection(),
          const SizedBox(height: 15),
          // Posts
          buildPost(
            username: 'Sumit',
            timeAgo: '1 hour ago',
            text:
            'In today\'s fast-paced world, mental health is more important than ever – yet finding accessible, meaningful support remains a challenge. That\'s why we\'ve created a digital platform that bridges the gap between social connection and mental wellness.',
            likeCount: likeCount,
            isLiked: isLiked,
            toggleLike: toggleLike,
            context: context,
          ),
          const Divider(),
          buildPost(
            username: 'Sumit',
            timeAgo: '1 hour ago',
            text:
            'In today\'s fast-paced world, mental health is more important than ever – yet finding accessible, meaningful support remains a challenge. That\'s why we\'ve created a digital platform that bridges the gap between social connection and mental wellness.',
            likeCount: likeCount,
            isLiked: isLiked,
            toggleLike: toggleLike,
            context: context,
          ),
          const Divider(),
          buildPost(
            username: 'Sumit Vondo',
            timeAgo: '1 hour ago',
            text:
            'In today\'s fast-paced world, mental health is more important than ever – yet finding accessible, meaningful support remains a challenge. That\'s why we\'ve created a digital platform that bridges the gap between social connection and mental wellness.',
            imageUrl: 'https://via.placeholder.com/300x150',
            likeCount: likeCount,
            isLiked: isLiked,
            toggleLike: toggleLike,
            context: context,
          ),
          const Divider(),
          buildPost(
            username: 'Sumit Vondo',
            timeAgo: '1 hour ago',
            tag: 'Work',
            text:
            'In today\'s fast-paced world, mental health is more important than ever – yet finding accessible, meaningful support remains a challenge. That\'s why we\'ve created a digital platform that bridges the gap between social connection and mental wellness.',
            imageUrl: 'https://via.placeholder.com/300x150',
            likeCount: likeCount,
            isLiked: isLiked,
            toggleLike: toggleLike,
            context: context,
          ),
        ],
      ),
    );
  }
  // Horizontal Notes section (like Messenger Notes)
  Widget buildNoteSection() {
    return SizedBox(
      height: 95,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: notes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final note = notes[index];
          return Column(
            children: [
              NoteBubble(text: note['text']!),
              const SizedBox(height: 6),
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(note['image']!),
              ),
            ],
          );
        },
      ),
    );
  }
}


  // Reusable post widget
  Widget buildPost({
    required BuildContext context,
    required String username,
    required String timeAgo,
    required String text,
    String? imageUrl,
    String? tag,
    required int likeCount,
    required bool isLiked,
    required VoidCallback toggleLike,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150', // Replace with actual image
                ),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(timeAgo, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              if (tag != null)
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAFBF1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF1AA260)),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                        color: Color(0xFF1AA260), fontWeight: FontWeight.w500),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Post text
          Text(
            text,
            style: const TextStyle(fontSize: 14.5, height: 1.4),
          ),

          if (imageUrl != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl),
            ),
          ],

          const SizedBox(height: 10),

          // Like count
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

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildActionButton(
                icon: isLiked ? Icons.favorite : Icons.favorite_border,
                label: 'Love',
                onTap: toggleLike,
                color: isLiked ? Colors.green : Colors.black,
              ),
              buildActionButton(
                icon: Icons.comment_outlined,
                label: 'Comment',
                onTap: () {
                  context.go('/comments');
                },
              ),
              buildActionButton(
                icon: Icons.repeat,
                label: 'Repost',
                onTap: () {
                  context.go('/repost');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

Widget buildActionButton({
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


class NoteBubble extends StatelessWidget {
  final String text;

  const NoteBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(minWidth: 60),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final Color color;

  BubblePainter({this.color = const Color(0xFF1AA260)});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final radius = 6.0;

    // Draw rounded rect (bubble body) leaving space at bottom for tail
    final rrect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height - 10, // leave space for tail height
      Radius.circular(radius),
    );
    canvas.drawRRect(rrect, paint);

    // Draw the downward pointing triangle tail centered at bottom
    final path = Path();
    final tailWidth = 14.0;
    final tailHeight = 10.0;
    final centerX = size.width / 2;

    path.moveTo(centerX - tailWidth / 2, size.height - 10);
    path.lineTo(centerX, size.height);
    path.lineTo(centerX + tailWidth / 2, size.height - 10);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
