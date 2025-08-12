import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/topnav.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors from the image
    const greenColor = Color(0xFF3C9B0D);
    const lightGreen = Color(0xFFB8DC8A);

    // Sample goal items
    final goals = [
      GoalItem(title: 'Morning Meditation', date: '27 Feb 2025', time: '09:00 PM', completed: true),
      GoalItem(title: 'Read Book', date: '27 Feb 2025', time: '09:00 PM', completed: false),
      GoalItem(title: 'Morning Meditation', date: '27 Feb 2025', time: '09:00 PM', completed: true),
      GoalItem(title: 'Read Book', date: '27 Feb 2025', time: '09:00 PM', completed: false),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        //toolbarHeight: 100,
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
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              // Top row with icons and Create a Goal button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/images/coming.png',
                                            height: 120,
                                            width: 120,
                                          ),
                                          const SizedBox(height: 16),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: const Text(
                                              "We're Building Something\nAwesome for You!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Close Icon (top-right)
                                    Positioned(
                                      top: -5,
                                      right: -5,
                                      child: IconButton(
                                        icon: const Icon(Icons.close, color: Colors.green),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Icon(Icons.podcasts_outlined, size: 28),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          context.go('/walkinggroupchat');
                        },
                        child: const Icon(Icons.message_outlined, size: 28),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/set_goal_page');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      'Create a Goal',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Image with circular progress
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/goal.jpg',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: 0.5,
                      strokeWidth: 14,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(greenColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Completed and Incomplete goals info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                          color: greenColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('Completed Goals (2)'),
                    ],
                  ),
                  const SizedBox(width: 11),
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('Incomplete Goals (02)'),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Header with "Be Prepared" and "Today" dropdown style
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Be Prepared',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Today',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Goal list items
              Expanded(
                child: ListView.separated(
                  itemCount: goals.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Circle indicator
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: greenColor, width: 2),
                              color: goal.completed ? greenColor : Colors.white,
                            ),
                            child: goal.completed
                                ? Center(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          // Text info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  goal.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(goal.date),
                                Text('Time: ${goal.time}'),
                              ],
                            ),
                          ),
                          // More dots icon
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(Icons.more_horiz, size: 28),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoalItem {
  final String title;
  final String date;
  final String time;
  final bool completed;

  GoalItem({
    required this.title,
    required this.date,
    required this.time,
    required this.completed,
  });
}