import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/add_task/priority.dart';

import '../task_provider.dart';
import 'category.dart';
import 'date_picker.dart';

class EditTask extends StatefulWidget {
final Task task;

  const EditTask({
    super.key,
    required this.task,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
 late int _selectedPriority ;
  late DateTime _selectedDateTime;
  late Category _selectedCategory;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.task.priority?? 1;
    _selectedDateTime = widget.task.date ?? DateTime.now();

    _selectedCategory = widget.task.category ??
        Category(
          name: '',
          icon: Icons.school_outlined,
          color: const Color(0xFF809CFF),
          iconColor: const Color(0xff0055A3),
        );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String dateStr;
    if (targetDate == today) {
      dateStr = 'Today';
    } else if (targetDate == tomorrow) {
      dateStr = 'Tomorrow';
    } else {
      dateStr = DateFormat('MMM dd').format(dateTime);
    }

    final timeStr = DateFormat('HH:mm').format(dateTime);
    return '$dateStr At $timeStr';
  }

  Future<void> _pickedDateTime() async {
    final DateTime? pickedDateTime = await CalendarDialog.show(
      context,
      initialDate: _selectedDateTime,
    );

    if (pickedDateTime != null) {
      setState(() {
        _selectedDateTime = pickedDateTime;
      });
    }
  }

  Future<void> _pickCategory() async {
    final Category? picked = await CategoryDialog.show(
      context,
      initialCategory: _selectedCategory,
    );

    if (picked != null) {
      setState(() {
        _selectedCategory = picked;
      });
    }
  }

Future<void> _showDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?',),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false) ,
                child: Text('Cancel')),
            TextButton(onPressed:() => Navigator.pop(context, true),
                child: Text("Delete"))
          ],
        ),);
    if (shouldDelete == true && context.mounted){
      context.read<TaskProvider>().deleteTask(widget.task);
      Navigator.pop(context);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Task Title Header
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Icon(
                            widget.task.isCompleted
                             ? Icons.check_circle
                             : Icons.radio_button_unchecked,
                             color: Colors.white),
                         SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.task.title,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 21,
                                ),
                              ),
                               SizedBox(height: 10),
                              Text(
                                widget.task.description!,
                                style: GoogleFonts.lato(
                                    color:  Color(0xffAFAFAF)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                   Icon(Icons.mode_edit_outlined, color: Colors.white),
                ],
              ),
            ),
             SizedBox(height: 30),

            /// Task Time Row
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                       Icon(Icons.timer_outlined, color: Colors.white),
                       SizedBox(width: 10),
                      Text('Task Time :',
                          style: GoogleFonts.lato(color: Colors.white)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0x36FFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: _pickedDateTime,
                    child: Text(
                      _formatDateTime(_selectedDateTime),
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 30),

            /// Task Category Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                       Icon(Icons.sell_outlined, color: Colors.white),
                       SizedBox(width: 10),
                      Text(
                        'Task Category : ',
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedCategory.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: _pickCategory,
                    child: Row(
                      children: [
                        Icon(_selectedCategory.icon,
                            color: _selectedCategory.iconColor),
                         SizedBox(width: 5),
                        Text(
                          _selectedCategory.name,
                          style: GoogleFonts.lato(
                              color: _selectedCategory.iconColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 30),

            /// Task Priority Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                       Icon(Icons.flag_outlined, color: Colors.white),
                       SizedBox(width: 10),
                      Text(
                        'Task Priority :',
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x36FFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () async {
                      final int? pickedPriority = await PriorityDialog.show(
                        context,
                        initialDate: _selectedDateTime,
                      );
                      if (pickedPriority != null) {
                        setState(() {
                          _selectedPriority = pickedPriority;
                        });
                      }
                    },
                    child: Text(
                      'Priority: $_selectedPriority',
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 30),

            /// Sub-Task Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                       Icon(Icons.call_split_sharp, color: Colors.white),
                       SizedBox(width: 10),
                      Text(
                        'Sub-Task',
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0x36FFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Add Sub - Task',
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 30),

            /// Delete Task Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => _showDelete(context),
                child: Row(
                  children: [
                     Icon(CupertinoIcons.delete, color: Colors.red),
                     SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Delete Task',
                        style: GoogleFonts.lato(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
