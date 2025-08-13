// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tha_bridge/model/PostModel.dart';

// class PostWidget extends StatefulWidget {
//   final Post post;
//   const PostWidget({required this.post, Key? key}) : super(key: key);

//   @override
//   State<PostWidget> createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   bool isLiked = false;
//   int likeCount = 1200;


//   void toggleLike() {
//     setState(() {
//       isLiked = !isLiked;
//       likeCount += isLiked ? 1 : -1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final images = widget.post.imageUrls ?? [];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               radius: 24,
//               backgroundImage: NetworkImage(
//                 widget.post.userimage ?? 'https://randomuser.me/api/portraits/men/33.jpg',
//               ),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.post.userName,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   widget.post.postTime,
//                   style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Text(
//           widget.post.postText,
//           style: const TextStyle(
//             fontSize: 13,
//             height: 1.5,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         if (images.isNotEmpty) ...[
//           const SizedBox(height: 10),
//           if (images.length == 1)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.network(
//                 images[0],
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 180,
//               ),
//             )
//           else
//             SizedBox(
//               height: 180,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: images.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 12),
//                 itemBuilder: (context, index) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.network(
//                       images[index],
//                       width: 300,
//                       height: 180,
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 },
//               ),
//             ),
//         ],
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             Icon(Icons.favorite, color: Colors.green, size: 20),
//             const SizedBox(width: 10),
//             Text(
//               "${(likeCount / 1000).toStringAsFixed(0)}k People like this post",
//               style: const TextStyle(color: Colors.green),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             Expanded(
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: GestureDetector(
//                   onTap: toggleLike,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.favorite_border,
//                         color: isLiked ? Colors.green : Colors.black,
//                       ),
//                       const SizedBox(width: 6),
//                       const Text(
//                         "Love",
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: GestureDetector(
//                   onTap: () {
//                     context.go('/comment_page');
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Icon(Icons.comment),
//                       SizedBox(width: 6),
//                       Text(
//                         "Comments",
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Icon(Icons.repeat),
//                       SizedBox(width: 6),
//                       Text(
//                         "Repost",
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
