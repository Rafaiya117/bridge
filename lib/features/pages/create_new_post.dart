import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tha_bridge/components/topnav.dart';

class CreateNewPost extends StatefulWidget {
  const CreateNewPost({super.key});

  @override
  State<CreateNewPost> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Align(
              alignment: Alignment.centerLeft,
              child:IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
      body:  Container(
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:Row(
                children: [
                  ClipOval(
                    child:Image.network(
                      "https://randomuser.me/api/portraits/women/44.jpg",
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    ) ,
                  ),
                  SizedBox(width:10.w),
                  Text(
                    "Sumita",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
