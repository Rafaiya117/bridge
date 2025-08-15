import 'package:flutter/material.dart';
import 'package:tha_bridge/components/topnav.dart';

class GuidancePage extends StatefulWidget {
  const GuidancePage({super.key});

  @override
  State<GuidancePage> createState() => _GuidancePageState();
}

class _GuidancePageState extends State<GuidancePage> {
  bool showTherapist = true; // Toggle between Therapist & Life coach

  @override
  Widget build(BuildContext context) {
    // Colors from the image
    const greenColor = Color(0xffb5da73);
    const darkGreenText = Color(0xff006400);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            TopBar(
              firstIcon: Icons.phone,
              secondIcon: Icons.notifications,
              firstIconColor: Colors.red,
              secondIconColor: Colors.black,
              profileImageUrl:
                  'https://randomuser.me/api/portraits/women/44.jpg',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Connect',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Two hyperlinks instead of single text
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => showTherapist = true),
                    child: Text(
                      'Therapist',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkGreenText,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => setState(() => showTherapist = false),
                    child: Text(
                      'Life coach',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkGreenText,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // User list or image based on selection
              Expanded(
                child: showTherapist
                    ? ListView(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                'https://i.imgur.com/fG3JpXp.png',
                              ),
                            ),
                            title: const Text(
                              'Jone',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 0),
                          const ListTile(
                            leading: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                            ),
                            title: Text(
                              'Makama',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 0),
                          const ListTile(
                            leading: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                            ),
                            title: Text(
                              'Ankama',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 0),
                          const ListTile(
                            leading: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                            ),
                            title: Text(
                              'mark',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 0),
                          const ListTile(
                            leading: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                            ),
                            title: Text(
                              'Maxilif',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Image.asset(
                          'assets/images/lifecoach.png', 
                          width: 200,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}