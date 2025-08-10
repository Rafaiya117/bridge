import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/footer.dart';
import 'package:tha_bridge/components/topnav.dart';
import 'package:tha_bridge/custom_widgets/custom_note.dart';
import 'package:tha_bridge/custom_widgets/custome_searchbar.dart';
import 'package:tha_bridge/custom_widgets/post_widget.dart';
import 'package:tha_bridge/model/PostModel.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int selectedIndex = 0;
  int likeCount = 190000;
  bool isLiked = false;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
      print(likeCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 250,
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
            SizedBox(height: 10.h),
            // Constrain ActiveUsers height to avoid overflow
            SizedBox(
              child: ActiveUsers(
                userNotes: [
                  UserNote('What in your mind', 'https://randomuser.me/api/portraits/men/1.jpg'),
                  UserNote('Book bag giveway', 'https://randomuser.me/api/portraits/men/2.jpg'),
                  UserNote('free counseling live', 'https://randomuser.me/api/portraits/women/3.jpg'),
                  UserNote('Life Therapy at 6PM', 'https://randomuser.me/api/portraits/men/4.jpg'),
                  UserNote('park, cleanup volu', 'https://randomuser.me/api/portraits/men/5.jpg'),
                  UserNote('Gym Day', 'https://randomuser.me/api/portraits/men/6.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: mockPosts.expand((post) {
              return [
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
                  child: PostWidget(post: post),
                ),
                const Divider(thickness: 1),
              ];
            }).toList(),
          ),
        )
      ),
      bottomNavigationBar: ReusableBottomNavBar(
        icons: [
          Icons.play_circle,
          Icons.list_outlined,
          Icons.checklist_rtl_sharp,
          Icons.person_search_sharp,
          Icons.note_add,
        ],
        selectedIndex: selectedIndex,
        onItemTapped: [
              () {
            setState(() => selectedIndex = 0);
            //context.push('/login');
                print("object");
          },
              () {
            setState(() => selectedIndex = 1);
            //Navigator.pushNamed(context, '/list');
          },
              () {
            setState(() => selectedIndex = 2);
           // Navigator.pushNamed(context, '/checklist');
          },
              () {
            setState(() => selectedIndex = 3);
            //Navigator.pushNamed(context, '/search');
          },
              () {
            setState(() => selectedIndex = 4);
            //Navigator.pushNamed(context, '/note');
          },
        ],
        iconSize: 30,
        iconColor: Colors.white,
        selectedColor: Colors.teal[900]!,
      ),
    );
  }
}

