import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tha_bridge/components/topnav.dart';
import 'package:tha_bridge/custom_widgets/custom_feed_widgets/note_section.dart';
import 'package:tha_bridge/custom_widgets/custom_feed_widgets/post_widget.dart';
import 'package:tha_bridge/custom_widgets/custome_searchbar.dart';
import 'package:tha_bridge/provider/note_provider.dart';
import 'package:tha_bridge/provider/post_provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;
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
            NoteSection(notes: notes),
            //SizedBox(height: 10.h),
    ...List.generate(postProvider.posts.length * 2 - 1, (index) {
      final itemIndex = index ~/ 2;
      if (index.isEven) {
        final post = postProvider.posts[itemIndex];
        return PostWidget(
          context: context,
          id: post.id,
          username: post.username,
          timeAgo: post.timeAgo,
          text: post.text,
          imageUrls: post.imageUrls,
          tag: post.tag,
          likeCount: post.likeCount,
          isLiked: post.isLiked,
          toggleLike: () {},
        );
      } else {
        return const Divider();
      }
    }),
  ],
),

    );
  }
}
