import 'package:flutter/material.dart';

class ReusableBottomNavBar extends StatelessWidget {
  final List<IconData> icons;
  final double iconSize;
  final Color iconColor;
  final Color selectedColor;
  final int selectedIndex;
  final List<VoidCallback> onItemTapped;

  const ReusableBottomNavBar({
    Key? key,
    required this.icons,
    required this.onItemTapped,
    this.iconSize = 30.0,
    this.iconColor = Colors.white,
    this.selectedColor = const Color(0xFF72BE20),
    this.selectedIndex = 0,
  })  : assert(icons.length == onItemTapped.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Container(
        height: 80,
        color: Color(0xFF72BE20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(icons.length, (index) {
            final isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: onItemTapped[index],
              child: SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🔼 Indicator bar on top
                    if (isSelected)
                      Container(
                        height: 5,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFF009038),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      )
                    else
                      SizedBox(height: 5),

                    const SizedBox(height: 6), // Spacing between indicator and icon

                    // Icon itself
                    Icon(
                      icons[index],
                      size: iconSize,
                      color: isSelected ? selectedColor : iconColor,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
