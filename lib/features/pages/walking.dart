import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalkingPage extends StatelessWidget {
  final List<Map<String, String>> people = [
    {
      'name': 'Jone',
      'image': 'https://randomuser.me/api/portraits/men/1.jpg'
    },
    {
      'name': 'Makama',
      'image': 'https://randomuser.me/api/portraits/men/2.jpg'
    },
    {
      'name': 'Ankama',
      'image': 'https://randomuser.me/api/portraits/women/1.jpg'
    },
    {
      'name': 'mark',
      'image': 'https://randomuser.me/api/portraits/men/3.jpg'
    },
    {
      'name': 'Maxilif',
      'image': 'https://randomuser.me/api/portraits/women/2.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar
            GestureDetector(
              onTap: () {
                context.go('/profile');
              },
              child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF007E33),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Walking',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ),

            // Person Label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Person',
                style: TextStyle(
                  color: Color(0xFF007E33),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF007E33),
                  decorationThickness: 2,
                ),
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFBFF0B3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // List of people
            Expanded(
              child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(people[index]['image']!),
                        ),
                        title: Text(
                          people[index]['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xFF007E33),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/own_profile'); 
                            },
                            child: Text(
                              'Walking',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )

                        ),
                      ),
                      // Divider after each ListTile
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}