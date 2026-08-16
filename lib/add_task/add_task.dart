import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo/add_task/priority.dart';
import 'calendar.dart';
import 'category.dart';
import 'choose_time.dart';

class AddTask extends StatefulWidget {
  final Function(
      String title,
      String description,
      DateTime? date,
      Category? category,
      int? priorirty,
      )? onTaskCreated;

   AddTask({
    super.key,
    this.onTaskCreated,
  });

  static Future<void> show(
      BuildContext context, {
        Function(
            String title,
            String description,
            DateTime? date,
            Category? category,
            int? priority
  )? onTaskCreated,
      }) {


    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:  Color(0xff363636),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(10)),
      ),
      builder: (context) => AddTask(onTaskCreated: onTaskCreated),
    );
  }

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final TextEditingController _taskController =TextEditingController();
  late final TextEditingController _descriptionController = TextEditingController();
  DateTime? selectedDate;
  Priority? selectedPriority;
  Category? selectedCategory;



  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }


  TimeOfDay? _selectedTime;

  Future<void> _openTimePicker() async {
    final now = DateTime.now();
    final initialDateTime = _selectedTime != null? 
        DateTime(now.year,now.month, now.day, _selectedTime!.hour, _selectedTime!.minute)
        :now; 
    final DateTime? result = await TimePickerDialogWidget.show(
      context,
      initialTime: initialDateTime,
    );

    if (result != null) {
      setState(() {
        _selectedTime = TimeOfDay.fromDateTime(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Task',
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 14),

          /// Title Input
          TextField(
            controller: _taskController,
            autofocus: true,
            style: GoogleFonts.lato(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: GoogleFonts.lato(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff979797)),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff979797)),
                borderRadius: BorderRadius.circular(4),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
           SizedBox(height: 12),

          Text(
            'Description',
            style: GoogleFonts.lato(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
           SizedBox(height: 6),


  /// Description
     TextField(
            controller: _descriptionController,
            style: GoogleFonts.lato(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Description',
              hintStyle: GoogleFonts.lato(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff979797)),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff979797)),
                borderRadius: BorderRadius.circular(4),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
           SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints:  BoxConstraints(),
                    icon:  Icon(Icons.timer_outlined, color: Colors.white),
                    onPressed: () async {
                      final pickedDate = await CalendarDialog.show(
                        context,
                        initialDate: selectedDate,
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                   SizedBox(width: 16),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints:  BoxConstraints(),
                    icon:  Icon(Icons.sell_outlined, color: Colors.white),
                    onPressed: () async {
                      final pickedCategory = await CategoryDialog.show(
                        context,
                        initialCategory: selectedCategory,
                      );
                      if (pickedCategory != null) {
                        setState(() {
                          selectedPriority = pickedCategory as Priority?;
                        });
                      }
                    },
                  ),
                   SizedBox(width: 16),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints:  BoxConstraints(),
                    icon:  Icon(Icons.flag_outlined, color: Colors.white),
                    onPressed: () async {
                      final pickedPriority = await PriorityDialog.show(
                        context,
                        initialDate: selectedDate,
                      );
                      if (pickedPriority != null) {
                        setState(() {
                          selectedPriority = pickedPriority as Priority?;
                        });
                      }
                    },
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints:  BoxConstraints(),
                icon:  Icon(
                  Icons.send_outlined,
                  color: Color(0xff8687E7),
                ),
                onPressed: () {
                  if (_taskController.text.trim().isNotEmpty) {
                    widget.onTaskCreated?.call(
                      _taskController.text,
                      _descriptionController.text,
                      selectedDate,
                      selectedCategory,
                      selectedPriority as int?
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}