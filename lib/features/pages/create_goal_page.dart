import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tha_bridge/custom_widgets/custom_time_picker.dart';

class SetGoalPage extends StatefulWidget {
  @override
  _SetGoalPageState createState() => _SetGoalPageState();
}

class _SetGoalPageState extends State<SetGoalPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final TextEditingController taskController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  Future<void> _selectTime(BuildContext context, {required bool isReminder}) async {
    final initialTime = TimeOfDay.now();
    final selectedDate = _selectedDay ?? DateTime.now();

    final TimeOfDay? pickedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) => CustomTimePickerDialog(
        initialTime: initialTime,
        selectedDate: selectedDate,
      ),
    );

    if (pickedTime != null) {
      final formatted = pickedTime.format(context);
      setState(() {
        if (isReminder) {
          reminderController.text = formatted;
        } else {
          timeController.text = formatted;
        }
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.green),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(color: Colors.black87),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(fontWeight: FontWeight.w500),
                    weekendStyle: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    hintText: "Task Title",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTime(context, isReminder: false),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: timeController,
                            decoration: InputDecoration(
                              hintText: "Time",
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.access_time, size: 18),
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTime(context, isReminder: true),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: reminderController,
                            decoration: InputDecoration(
                              hintText: "Reminder",
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.alarm, size: 18),
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                TextField(
                  controller: notesController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Accountability Notes",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      "Close Friend",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.person_add_alt_1, color: Colors.green),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Make A Goal",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
