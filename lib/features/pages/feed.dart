import 'package:flutter/material.dart';
import 'package:tha_bridge/components/topnav.dart';
import 'package:tha_bridge/custom_widgets/custome_social_post.dart';
import 'package:tha_bridge/custom_widgets/user_nav.dart';
import 'package:tha_bridge/model/PostModel.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  TextEditingController searchController = TextEditingController();
  List<Post> mockPosts = [
    Post(
      userName: "Sumit Vondo",
      postTime: "1 hour ago",
      postText:
      "In today’s fast-paced world, mental health is more important than ever—yet finding accessible, meaningful support remains a challenge...",
      imageUrl: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQaYYxhaz3JMcWBsF6NQ3072oHDnWom4LwAdeK2SKT2qx3USSMg", // Replace with your actual asset
    ),
    Post(
      userName: "Jane Doe",
      postTime: "2 hours ago",
      postText: "Nature walks always help me refresh and reset. 🌿",
      imageUrl: null, // No image for this post
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopNavbarWrapper(
        customTopNavbar: CustomTopNavbar(
          logo: Image.asset('assets/images/logo.png', height: 40),
          customItem: IconButton(
            icon: const Icon(Icons.lightbulb_sharp),
            onPressed: () => print('Settings pressed'),
          ),
          onNotificationPressed: () => print('Notification pressed'),
          userProfilePic: Image.network(
            'https://randomuser.me/api/portraits/men/32.jpg',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          topNavBarColor: Colors.transparent,
          bottomNavBarColor: Colors.transparent,
          searchController: searchController,
          onPlusPressed: () => print('Plus pressed'),
          floatingButtonColor: Colors.green,
          floatingButtonShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          floatingButtonText: "Create Post",
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Static Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ActiveUsers(
                userNotes: [
                  UserNote('What in your mind', 'https://randomuser.me/api/portraits/men/1.jpg'),
                  UserNote('Book bag giveway', 'https://randomuser.me/api/portraits/men/2.jpg'),
                  UserNote('free counseling live', 'https://randomuser.me/api/portraits/women/3.jpg'),
                  UserNote('Life Therapy at 6PM', 'https://randomuser.me/api/portraits/men/4.jpg'),
                  UserNote('park, cleanup volu', 'https://randomuser.me/api/portraits/men/5.jpg'),
                ],
              ),
            ),
           // const SizedBox(height: 2),

            // Scrollable Posts Section
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: mockPosts.length,
                itemBuilder: (context, index) {
                  final post = mockPosts[index];
                  return SocialPostWidget(
                    userName: post.userName,
                    postTime: post.postTime,
                    postText: post.postText,
                    imageUrl: post.imageUrl,
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
