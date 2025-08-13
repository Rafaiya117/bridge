import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteBubble extends StatelessWidget {
  final String text;

  const NoteBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          minWidth: 60.w,
          minHeight: 36.h,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final Color color;

  BubblePainter({this.color = const Color(0xFF1AA260)});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const radius = 6.0;

    final rrect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height - 10,
      Radius.circular(radius),
    );
    canvas.drawRRect(rrect, paint);

    final path = Path();
    const tailWidth = 14.0;
    final centerX = size.width / 2;

    path.moveTo(centerX - tailWidth / 2, size.height - 10);
    path.lineTo(centerX, size.height);
    path.lineTo(centerX + tailWidth / 2, size.height - 10);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
