import 'package:flutter/material.dart';
import 'package:scroll_time_picker/scroll_time_picker.dart';

class TimePickerDialogWidget extends StatefulWidget {

  final DateTime? initialTime;

  const TimePickerDialogWidget({super.key, this.initialTime});

  static Future<DateTime?> show(
      BuildContext context, {
        DateTime? initialTime,
      }) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) => TimePickerDialogWidget(initialTime: initialTime),
    );
  }

  @override
  State<TimePickerDialogWidget> createState() => _TimePickerDialogWidgetState();
}

class _TimePickerDialogWidgetState extends State<TimePickerDialogWidget> {
  late DateTime _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF363636),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      titlePadding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      actionsPadding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      title: const Column(
        children: [
          Text(
            'Choose Time',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Divider(color: Colors.white24, height: 1),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200,
        child: ScrollTimePicker(
          selectedTime: _selectedTime,
          is12hFormat: true,
          options:  TimePickerOptions(
            backgroundColor: Color(0xFF363636),
          ),
          // style:  TimePickerStyle(
          //   textStyle: TextStyle(
          //     color: Colors.white,
          //     fontSize: 18,
          //     fontWeight: FontWeight.w500,
          //   ),
          //   activeTextStyle: TextStyle(
          //     color: Color(0xFF8687E7),
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          onDateTimeChanged: (DateTime value) {
            setState(() {
              _selectedTime = value;
            });
          },
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF8687E7),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _selectedTime),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8687E7),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}