import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tha_bridge/custom_widgets/custom_feed_widgets/post_widget.dart';
import 'package:tha_bridge/provider/post_provider.dart';

class OwnProfilePage extends StatefulWidget {
  const OwnProfilePage({super.key});

  @override
  State<OwnProfilePage> createState() => _OwnProfilePageState();
}

class _OwnProfilePageState extends State<OwnProfilePage> {
  String selectedMode = "Walking";
  final List<String> modes = ["Walking", "No Walk"];
  int selectedTab = 0;

  final _nameController = TextEditingController(text: "Suka");
  final _usernameController = TextEditingController(text: "Life coach");
  final _bioController = TextEditingController(text: "");
  DateTime selectedDate = DateTime(2022, 9, 19);

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
              context.go('/profile');
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
                  'Friend',
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    image: const DecorationImage(
                      image: NetworkImage('https://i.imgur.com/0rVeh4A.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  top: 130,
                  left: 20,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // User Info Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Suka',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedMode,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            dropdownColor: Colors.green,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedMode = newValue!;
                              });
                            },
                            items: modes.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Healing begins with connection.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'User Role: Life coach',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Followers & Following
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _statBox('Walking', '08K'),
                  const SizedBox(width: 20),
                  _statBox('Walked', '120'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildTabItem(title: "Post", index: 0),
                  const SizedBox(width: 20),
                  _buildTabItem(title: "About", index: 1),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Tab Content
            if (selectedTab == 0) ...[
              ...List.generate(
                postProvider.posts.isNotEmpty
                    ? postProvider.posts.length * 2 - 1
                    : 0,
                (index) {
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
                        toggleLike: () {
                          // Your toggle like logic here
                        },
                      ),
                    );
                  } else {
                    return const Divider();
                  }
                },
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    bool isBold = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(width: 8),
              Expanded(child: Container(height: 1, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              decoration: isSelected ? TextDecoration.underline : null,
              decorationColor: Colors.green,
              decorationThickness: 2,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
          if (index == 0 && isSelected) ...[
            const SizedBox(width: 6),
            const Icon(Icons.edit, size: 16, color: Colors.green),
          ],
        ],
      ),
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

  Widget _statBox(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}


