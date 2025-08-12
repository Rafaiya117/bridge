import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/features/pages/chat_details_page.dart';

class WalkingChatPage extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {
      'name': 'Athalia Putri',
      'status': 'Last seen yesterday',
      'image': 'https://i.imgur.com/1N0ksD3.jpg', // Replace with your assets if needed
    },
    {
      'name': 'Rafi Bhai',
      'status': 'Aight, noted',
      'image': 'https://i.imgur.com/U1N2OGh.jpg',
      'date': '17/6',
      'unread': 1,
    },
    {
      'name': 'Midala Huera',
      'status': 'Last seen 3 hours ago',
      'image': 'https://i.imgur.com/JnT4lYQ.jpg',
    },
    {
      'name': 'Nafisa Gitari',
      'status': 'Online',
      'image': 'https://i.imgur.com/v5VToC2.jpg',
      'online': true,
    },
    {
      'name': 'Raki Devon',
      'status': 'Online',
      'initials': 'RD',
      'color': Colors.lightGreen,
      'online': true,
    },
    {
      'name': 'Salsabila Akira',
      'status': 'Last seen 30 minutes ago',
      'initials': 'SA',
      'color': Colors.lightGreen,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 32, // Now this will take effect
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text('Walking', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              context.go('/chatlist');
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  onTap: () {
                   context.go('/chat_details');
                  },
                  leading: user.containsKey('image')
                      ? Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user['image']),
                        radius: 24,
                      ),
                      if (user['online'] == true)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 4,
                            ),
                          ),
                        ),
                    ],
                  )
                      : CircleAvatar(
                    radius: 24,
                    backgroundColor: user['color'] ?? Colors.grey,
                    child: Text(
                      user['initials'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(user['name']),
                  subtitle: Text(user['status']),
                  trailing: user.containsKey('unread')
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(user['date']),
                      const SizedBox(height: 4),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.green,
                        child: Text(
                          '${user['unread']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}