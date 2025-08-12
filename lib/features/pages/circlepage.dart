import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, dynamic> userData = {
    "coverPhoto": "https://via.placeholder.com/400x150",
    "profilePhoto": "https://via.placeholder.com/150",
    "name": "Suka",
    "role": "Life coach",
    "walking": "08K",
    "walked": "120",
  };

  final List<Map<String, String>> walkRequests = [
    {"name": "Pappu", "image": "https://via.placeholder.com/60"},
    {"name": "Shafi", "image": "https://via.placeholder.com/60"},
    {"name": "Tari", "image": "https://via.placeholder.com/60"},
  ];

  final List<Map<String, dynamic>> posts = [
    {
      "name": "Sumit",
      "role": "Life coach",
      "text":
      "In today’s fast-paced world, mental health is more important than ever...",
      "image": null
    },
    {
      "name": "Sumit vondo",
      "role": "Life coach",
      "text":
      "In today’s fast-paced world, mental health is more important than ever...",
      "image": null
    },
    {
      "name": "Sumit vondo",
      "role": "Life coach",
      "text":
      "In today’s fast-paced world, mental health is more important than ever...",
      "image": "https://via.placeholder.com/300x150"
    },
  ];

  final TextEditingController _nameController = TextEditingController(text: "Suka");
  final TextEditingController _usernameController = TextEditingController(text: "Life coach");
  final TextEditingController _bioController = TextEditingController();
  DateTime selectedDate = DateTime(2022, 9, 19);

  bool _notificationsEnabled = true;
  bool _liveLocationEnabled = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Cover photo with profile image
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.network(
                userData["coverPhoto"],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: _circleIcon(Icons.arrow_back, Colors.green, () {
                  Navigator.pop(context);
                }),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: _circleIcon(Icons.edit, Colors.green, () {}),
              ),
              Positioned(
                bottom: -40,
                left: MediaQuery.of(context).size.width / 2 - 40,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userData["profilePhoto"]),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _circleIcon(Icons.edit, Colors.green, () {}),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 50),

          // Name & Role
          Center(
            child: Column(
              children: [
                Text(
                  userData["name"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "User Role: ${userData["role"]}",
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Walking stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/walking');
                },
                child: _statCard("Walking", userData["walking"]),
              ),
              GestureDetector(
                onTap: () {
                  context.go('/walk');
                },
                child: _statCard("Walked", userData["walked"]),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Walk requests
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Walk request",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: walkRequests
                        .map((req) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(req["image"]!),
                          ),
                          const SizedBox(height: 4),
                          Text(req["name"]!),
                          const SizedBox(height: 4),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                minimumSize: const Size(60, 28),
                                padding: EdgeInsets.zero),
                            onPressed: () {},
                            child: const Text("Walk with",
                                style: TextStyle(fontSize: 10)),
                          )
                        ],
                      ),
                    ))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Tabs
          TabBar(
            controller: _tabController,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.green,
            tabs: const [
              Tab(text: "My Post"),
              Tab(text: "About"),
              Tab(text: "Settings"),
            ],
          ),

          // Tab content
          SizedBox(
            height: 600, // enough to hold list
            child: TabBarView(
              controller: _tabController,
              children: [
                // My Posts Tab
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return _postCard(post);
                  },
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildEditableField(label: "Name", initialValue: "Suka"),
                      _buildEditableField(label: "Username", initialValue: "Life coach"),
                      _buildEditableField(label: "Bio", initialValue: "", maxLines: 2),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Birth Day: ${_formatDate(selectedDate)}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //const Center(child: Text("About Content")),
                //const Center(child: Text("Settings Content")),
                // Settings Tab – with rounded card container
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Back Button and Title
                          Row(
                            children: const [
                              Icon(Icons.arrow_back, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                "General Settings",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Toggle Items
                          _buildToggleTile("Notifications"),
                          _buildToggleTile("Active your live location"),

                          const SizedBox(height: 12),
                          _buildSettingsTile("Change Password", () {
                            context.go('/change_password');
                          }),
                          _buildSettingsTile("Help & Support", () {
                            context.go('/help_&_support');
                          }),
                          _buildSettingsTile("Privacy Policy", () {
                            context.go('/privacy_policy');
                          }),
                          _buildSettingsTile("Terms & Conditions", () {
                            context.go('/term_conditions');
                          }),
                          const SizedBox(height: 12),
                          // Delete Data
                          ListTile(
                            title: const Text("Delete all Data",
                                style: TextStyle(color: Colors.white)),
                            trailing: const Icon(Icons.delete, color: Colors.red),
                            onTap: () {
                              // Add your delete logic here
                            },
                          ),

                          const SizedBox(height: 16),

                          // Logout
                          ListTile(
                            title: const Text("Logout",
                                style: TextStyle(color: Colors.red)),
                            trailing: const Icon(Icons.logout, color: Colors.red),
                            onTap: () {
                              // Add your logout logic here
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: color,
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _postCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 20),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post["name"],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(post["role"], style: const TextStyle(fontSize: 12)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(post["text"]),
            if (post["image"] != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(post["image"]),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.favorite_border, size: 18),
                SizedBox(width: 4),
                Text("Love"),
                SizedBox(width: 20),
                Icon(Icons.comment, size: 18),
                SizedBox(width: 4),
                Text("Comment"),
                SizedBox(width: 20),
                Icon(Icons.repeat, size: 18),
                SizedBox(width: 4),
                Text("Repost"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String initialValue,
    int maxLines = 1,
  }) {
    final controller = (label == "Name")
        ? _nameController
        : (label == "Username")
        ? _usernameController
        : _bioController;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        subtitle: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: const InputDecoration(border: InputBorder.none),
        ),
        trailing: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildToggleTile(String title) {
    bool value = (title == "Notifications") ? _notificationsEnabled : _liveLocationEnabled;

    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Switch(
        value: value,
        activeColor: Colors.black,
        onChanged: (newValue) {
          setState(() {
            if (title == "Notifications") {
              _notificationsEnabled = newValue;
            } else {
              _liveLocationEnabled = newValue;
            }
          });
        },
      ),
    );
  }

  Widget _buildSettingsTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      onTap: onTap,
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} / ${date.month.toString().padLeft(2, '0')} / ${date.year}";
  }
}
