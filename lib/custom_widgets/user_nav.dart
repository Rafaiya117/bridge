import 'package:flutter/material.dart';

class UserNote {
  final String note;
  final String imageUrl;
  UserNote(this.note, this.imageUrl);
}

class ActiveUsers extends StatefulWidget {
  final List<UserNote> userNotes;
  final Color backgroundColor;

  const ActiveUsers({
    Key? key,
    required this.userNotes,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<ActiveUsers> createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: widget.userNotes.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpeechBubble(
              color: Colors.green,
              maxWidth: 220,
              child: Row(
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                        border: InputBorder.none,
                        hintText: 'What in your mind',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      onSubmitted: (value) {
                        // You can handle submission here
                        print('User input: $value');
                        _controller.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ) : SizedBox(
        height: 150, // Enough to fit speech bubble + spacing + avatar
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.userNotes.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final userNote = widget.userNotes[index];
            return SizedBox(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 80),
                    child: SpeechBubble(
                      color: Colors.green,
                      child: Text(
                        userNote.note,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(userNote.imageUrl),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// SpeechBubble widget unchanged except maxWidth support (same as previous)
class SpeechBubble extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? maxWidth;

  const SpeechBubble({
    Key? key,
    required this.child,
    this.color = Colors.green,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubbleTailPainter(color),
      child: Container(
        constraints: maxWidth != null
            ? BoxConstraints(maxWidth: maxWidth!) // limits width only
            : const BoxConstraints(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  final Color color;

  _BubbleTailPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    final tailWidth = 12.0;
    final tailHeight = 8.0;
    path.moveTo(size.width / 2 - tailWidth / 2, size.height);
    path.lineTo(size.width / 2, size.height + tailHeight);
    path.lineTo(size.width / 2 + tailWidth / 2, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
