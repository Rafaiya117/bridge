import 'package:flutter/material.dart';
import 'dart:math';

import 'package:go_router/go_router.dart';

class CustomTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final DateTime selectedDate;

  const CustomTimePickerDialog({
    Key? key,
    required this.initialTime,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _CustomTimePickerDialogState createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
  late int selectedHour;
  late int selectedMinute;
  DayPeriod period = DayPeriod.am;

  bool selectingHour = true;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hourOfPeriod == 0 ? 12 : widget.initialTime.hourOfPeriod;
    selectedMinute = widget.initialTime.minute;
    period = widget.initialTime.period;
  }

  void _selectHour(int hour) {
    setState(() {
      selectedHour = hour;
      selectingHour = false;
    });
  }

  void _selectMinute(int minute) {
    setState(() {
      selectedMinute = minute;
    });
  }

  void _togglePeriod() {
    setState(() {
      period = period == DayPeriod.am ? DayPeriod.pm : DayPeriod.am;
    });
  }

  TimeOfDay getSelectedTime() {
    int hour24 = (period == DayPeriod.pm && selectedHour != 12) ? selectedHour + 12 : selectedHour;
    if (period == DayPeriod.am && selectedHour == 12) hour24 = 0;
    return TimeOfDay(hour: hour24, minute: selectedMinute);
  }

  Widget _buildDial() {
    final double radius = 100;
    List<int> numbers = [];

    if (selectingHour) {
      numbers = [12,1,2,3,4,5,6,7,8,9,10,11];
    } else {
      numbers = List.generate(12, (i) => i * 5);
    }

    return Container(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE6F2EA), // light greenish gray background
            ),
          ),

          // Numbers around the dial
          ...List.generate(numbers.length, (index) {
            final number = numbers[index];
            final angle = (index * 30 - 60) * pi / 180;

            final x = radius + radius * 0.7 * cos(angle);
            final y = radius + radius * 0.7 * sin(angle);

            bool isSelected = false;
            if (selectingHour) {
              isSelected = number == selectedHour;
            } else {
              isSelected = number == selectedMinute;
            }

            String displayText = selectingHour ? '$number' : number.toString().padLeft(2, '0');

            return Positioned(
              left: x - 15,
              top: y - 15,
              child: GestureDetector(
                onTap: () {
                  if (selectingHour) {
                    _selectHour(number);
                  } else {
                    _selectMinute(number);
                  }
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF008000) : Colors.transparent,
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    displayText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            );
          }),

          // Handle line position (points to selected number)
          Positioned(
            left: radius + radius * 0.4 * cos(((selectingHour ? selectedHour * 30 : (selectedMinute / 5) * 30) - 90) * pi / 180) - 3,
            top: radius + radius * 0.4 * sin(((selectingHour ? selectedHour * 30 : (selectedMinute / 5) * 30) - 90) * pi / 180) - 3,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Color(0xFF008000),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
              ),
            ),
          ),

          // Center knob
          Positioned(
            left: radius - 10,
            top: radius - 10,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xFF008000),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final day = widget.selectedDate.day;
    final year = widget.selectedDate.year;
    final month = widget.selectedDate.month;
    final monthName = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ][month - 1];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Icon(Icons.close, color: Color(0xFF008000)),
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),

            SizedBox(height: 4),

            // Date text
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$year\n$day, $monthName',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Prompt row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Would You Like Set An Alarm ?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Icon(Icons.access_time, size: 24, color: Colors.black),
              ],
            ),

            SizedBox(height: 8),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "put your time",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),

            SizedBox(height: 10),

            // Large time display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() => selectingHour = true),
                  child: Text(
                    selectedHour.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 36,
                      color: selectingHour ? Color(0xFF008000) : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: () => setState(() => selectingHour = false),
                  child: Text(
                    selectedMinute.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 36,
                      color: !selectingHour ? Color(0xFF008000) : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: _togglePeriod,
                  child: Text(
                    period == DayPeriod.am ? "AM" : "PM",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF008000),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 16),

            _buildDial(),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF008000)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: Text("Cancel", style: TextStyle(color: Color(0xFF008000))),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(getSelectedTime());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF008000),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: Text("Done", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}