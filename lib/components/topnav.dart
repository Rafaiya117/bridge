import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBar extends StatelessWidget {
  final IconData firstIcon;
  final IconData secondIcon;
  final Color firstIconColor;
  final Color secondIconColor;
  final String profileImageUrl;
  final double iconSpacing;

  const TopBar({
    Key? key,
    required this.firstIcon,
    required this.secondIcon,
    this.firstIconColor = Colors.red,
    this.secondIconColor = Colors.black,
    this.profileImageUrl = 'https://randomuser.me/api/portraits/men/32.jpg',
    this.iconSpacing = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 40.h,
        ),
        Row(
          children: [
            Icon(firstIcon, color: firstIconColor),
            SizedBox(width: iconSpacing.w),
            Icon(secondIcon, color: secondIconColor),
            SizedBox(width: iconSpacing.w),
            ClipOval(
              child: Image.network(
                profileImageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
