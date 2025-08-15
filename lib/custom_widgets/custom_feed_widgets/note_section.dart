import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'note_bubble.dart';

class NoteSection extends StatelessWidget {
  final List<Map<String, String>> notes;
  final VoidCallback onAddNote;

  const NoteSection({
    super.key,
    required this.notes,
    required this.onAddNote,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: notes.length + 1, // +1 for "Add Note"
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            // Add Note bubble
            return Column(
              children: [
                GestureDetector(
                  onTap: onAddNote,
                  child: NoteBubble(text: '+ Add Note'),
                ),
                const SizedBox(height: 6),
                const CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150',
                  ),
                ),
              ],
            );
          }

          final note = notes[index - 1];
          return Column(
            children: [
              NoteBubble(text: note['text']!),
              const SizedBox(height: 6),
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(note['image']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
