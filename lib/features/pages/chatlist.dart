import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left:12,top:10,bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => context.go('/chatlist'),
            ),
          ),
        ),
        title: const Text(
          'Venting',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: 'Placeholder',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF3F3F3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ChatItem(
                  avatarUrl: 'https://via.placeholder.com/150', // Replace with real avatar
                  name: 'Athalia Putri',
                  message: 'Good morning, did you sleep well?',
                  time: 'Today',
                  unreadCount: 1,
                ),
                ChatItem(
                  initials: 'RD',
                  name: 'Raki Devon',
                  message: 'How is it going?',
                  time: '17/8',
                ),
                ChatItem(
                  avatarUrl: 'https://via.placeholder.com/150',
                  name: 'Erlan Sadewa',
                  message: 'Alright, noted',
                  time: '17/8',
                  unreadCount: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String? avatarUrl;
  final String? initials;
  final String name;
  final String message;
  final String time;
  final int unreadCount;

  const ChatItem({
    super.key,
    this.avatarUrl,
    this.initials,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: avatarUrl != null
          ? CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(avatarUrl!),
      )
          : CircleAvatar(
        radius: 24,
        backgroundColor: Colors.green,
        child: Text(
          initials ?? '',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF6A6AE3),
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
