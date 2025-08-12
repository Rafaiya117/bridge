import 'package:flutter/material.dart';

void main() {
  runApp(WalkApp());
}

class WalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WalkPage(),
    );
  }
}

class WalkPage extends StatefulWidget {
  @override
  _WalkPageState createState() => _WalkPageState();
}

class _WalkPageState extends State<WalkPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabTitles = ['Person', 'Community'];

  final List<Map<String, String>> users = [
    {"name": "Jone", "image": "https://randomuser.me/api/portraits/men/1.jpg"},
    {"name": "Makama", "image": "https://randomuser.me/api/portraits/men/2.jpg"},
    {"name": "Ankama", "image": "https://randomuser.me/api/portraits/women/1.jpg"},
    {"name": "mark", "image": "https://randomuser.me/api/portraits/men/3.jpg"},
    {"name": "Maxilif", "image": "https://randomuser.me/api/portraits/men/4.jpg"},
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabTitles.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildUserTile(String name, String imageUrl) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Walking',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {}, // Add your back action here
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Walk",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),

            // Tabs
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black54,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              tabs: tabTitles.map((title) => Tab(text: title)).toList(),
            ),

            // Content for each tab
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Person Tab
                  Column(
                    children: [
                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black54),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // List of people
                      Expanded(
                        child: ListView.separated(
                          itemCount: users.length,
                          separatorBuilder: (_, __) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return buildUserTile(user["name"]!, user["image"]!);
                          },
                        ),
                      ),
                    ],
                  ),

                  // Community Tab (only search bar, blank below)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black54),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Blank area below search bar
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
