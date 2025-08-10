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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: widget.userNotes.isEmpty ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpeechBubble(
              color: Color(0xFF72BE20),
              maxWidth: 150,
              maxHeight: 32,
              child: Row(
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        border: InputBorder.none,
                        hintText: 'What in your mind',
                        hintStyle: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      onSubmitted: (value) {
                        print('User input: $value');
                        _controller.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              child: const Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ],
        ),
      ) : SizedBox(
        height: 110,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.userNotes.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final userNote = widget.userNotes[index];
            return SizedBox(
              width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 60),
                    child: SpeechBubble(
                      color: Color(0xFF72BE20),
                      maxWidth: 100,
                      maxHeight: 48,
                      child: Text(
                        userNote.note,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  CircleAvatar(
                    radius: 28,
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


class SpeechBubble extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? maxWidth;
  final double? maxHeight;

  const SpeechBubble({
    Key? key,
    required this.child,
    this.color = Colors.green,
    this.maxWidth,
    this.maxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubbleTailPainter(color),
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? double.infinity,
            maxHeight: maxHeight ?? double.infinity,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), // reduced vertical padding
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
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
