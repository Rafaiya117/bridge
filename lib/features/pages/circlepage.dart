import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tha_bridge/custom_widgets/custom_feed_widgets/post_widget.dart';
import 'package:tha_bridge/provider/post_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, dynamic> userData = {
    "coverPhoto":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTurWalvIuSyZl3mYafnrsZ_IcuqKbX4c2lWw&s",
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

  final _nameController = TextEditingController(text: "Suka");
  final _usernameController = TextEditingController(text: "Life coach");
  final _bioController = TextEditingController(text: "");

  DateTime selectedDate = DateTime(2022, 9, 19);

  bool _notificationsEnabled = true;
  bool _liveLocationEnabled = false;

  File? _pickedCoverImage;
  File? _pickedProfileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isCoverPhoto) async {
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile != null) {
      setState(() {
        if (isCoverPhoto) {
          _pickedCoverImage = File(imageFile.path);
        } else {
          _pickedProfileImage = File(imageFile.path);
        }
      });
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: GestureDetector(
            onTap: () {
              context.go('/feed');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                SizedBox(width: 6),
                const Text(
                  'Table',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: _pickedCoverImage != null
                    ? Image.file(
                        _pickedCoverImage!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        userData["coverPhoto"],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: _circleIcon(
                  Icons.edit,
                  Colors.green,
                  () => _pickImage(true),
                ),
              ),
              Positioned(
                bottom: -40,
                left: MediaQuery.of(context).size.width / 2 - 40,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _pickedProfileImage != null
                          ? FileImage(_pickedProfileImage!) as ImageProvider
                          : NetworkImage(userData["profilePhoto"]),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _circleIcon(
                        Icons.edit,
                        Colors.green,
                        () => _pickImage(false),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Center(
            child: Column(
              children: [
                Text(
                  userData["name"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "User Role: ${userData["role"]}",
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Walk request",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: walkRequests.map((req) {
                      return Padding(
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
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Walk with",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
          SizedBox(
            height: 600,
            child: TabBarView(
              controller: _tabController,
              children: [
                // ✅ Tab 1: My Post
                ListView.builder(
                  itemCount: postProvider.posts.length * 2 - 1,
                  itemBuilder: (context, index) {
                    final itemIndex = index ~/ 2;
                    if (index.isEven) {
                      final post = postProvider.posts[itemIndex];
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: PostWidget(
                          context: context,
                          id: post.id,
                          username: post.username,
                          timeAgo: post.timeAgo,
                          text: post.text,
                          imageUrls: post.imageUrls,
                          tag: post.tag,
                          likeCount: post.likeCount,
                          isLiked: post.isLiked,
                          toggleLike: () {},
                        ),
                      );
                    } else {
                      return const Divider();
                    }
                  },
                ),

                // ✅ Tab 2: About
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildEditableField(
                        label: "Name",
                        controller: _nameController,
                      ),
                      _buildEditableField(
                        label: "Username",
                        controller: _usernameController,
                      ),
                      _buildEditableField(
                        label: "Bio",
                        controller: _bioController,
                        isBold: true,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
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

                // ✅ Tab 3: Settings
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.arrow_back, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                "General Settings",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
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
                          ListTile(
  title: const Text(
    "Delete all Data",
    style: TextStyle(color: Colors.white),
  ),
  trailing: const Icon(Icons.delete, color: Colors.red),
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text(
          "Are you sure you want to delete all your data? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              // TODO: Add your data deletion logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("All data deleted successfully."),
                ),
              );
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  },
),

                          const SizedBox(height: 16),
                          ListTile(
                            title: const Text("Logout",
                                style: TextStyle(color: Colors.red)),
                            trailing:
                                const Icon(Icons.logout, color: Colors.red),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirm Logout'),
                                  content: const Text(
                                      'Are you sure you want to log out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                       context.go('/login');
                                      },
                                      child: const Text('Logout',
                                          style:TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  Widget _circleIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: color,
        child: Icon(icon, size: 14, color: Colors.white),
      ),
    );
  }

  Widget _statCard(String title, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
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

  Widget _buildToggleTile(String title) {
    bool value = title == "Notifications"
        ? _notificationsEnabled
        : _liveLocationEnabled;

    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      value: value,
      onChanged: (bool newValue) {
        setState(() {
          if (title == "Notifications") {
            _notificationsEnabled = newValue;
          } else {
            _liveLocationEnabled = newValue;
          }
        });
      },
      activeColor: Colors.white,
    );
  }

  Widget _buildSettingsTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: onTap,
    );
  }
}
