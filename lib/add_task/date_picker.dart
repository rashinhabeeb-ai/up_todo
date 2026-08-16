import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'time_picker.dart';

class CalendarDialog extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime>? onDateSelected;

  const CalendarDialog({
    super.key,
    required this.initialDate,
    this.onDateSelected,
  });

  static Future<DateTime?> show(BuildContext context, {DateTime? initialDate}) {
    return showDialog<DateTime>(
      context: context,
      useRootNavigator: true,
      builder: (context) => CalendarDialog(
        initialDate: initialDate ?? DateTime.now(),
      ),
    );
  }

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late DateTime _selectedDay;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff363636),
      contentPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 350,
            width: 320,
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 40,
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              focusedDay: _selectedDay,
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: Colors.white70),
                outsideTextStyle: TextStyle(color: Colors.grey),
                todayDecoration: BoxDecoration(
                  color: Color(0xff8687E7),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xff8687E7),
                  shape: BoxShape.circle,
                ),
              ),
              firstDay: DateTime.utc(2010, 8, 6),
              lastDay: DateTime.utc(2030, 3, 14),
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                widget.onDateSelected?.call(selectedDay);
              },
            ),
          ),
           SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Cancel Button
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),

                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF7C7CFF),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// Choose Time
              ElevatedButton(
                onPressed: () async {
                  final now = DateTime.now();

                  final initialTime = DateTime(
                    _selectedDay.year,
                    _selectedDay.month,
                    _selectedDay.day,
                    now.hour,
                    now.minute,
                  );


                  final DateTime? pickedTime = await TimePickerDialogWidget.show(
                    context,
                    initialTime: initialTime,
                  );

                  if (pickedTime != null && context.mounted) {
                    final finalDateTime = DateTime(
                      _selectedDay.year,
                      _selectedDay.month,
                      _selectedDay.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    Navigator.pop(context, finalDateTime);

                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C7CFF),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: const Text(
                  'Choose Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}