import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'note_bubble.dart';

class NoteSection extends StatelessWidget {
  final List<Map<String, String>> notes;

  const NoteSection({super.key, required this.notes});

  @override
 Widget build(BuildContext context) {
  return SizedBox(
    height: 100.h,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: notes.length,
      separatorBuilder: (_, __) => const SizedBox(width: 23),
      itemBuilder: (context, index) {
        final note = notes[index];
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

