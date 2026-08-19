import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/add_task/priority.dart';
import '../task_provider.dart';
import 'date_picker.dart';
import 'category.dart';

class AddTask extends StatefulWidget {
  final Function(
    String title,
    String description,
    DateTime? date,
    Category? category,
    int? priorirty,
  )?
  onTaskCreated;

  const AddTask({super.key, this.onTaskCreated});

  static Future<void> show(
    BuildContext context, {
    Function(
      String title,
      String description,
      DateTime? date,
      Category? category,
      int? priority,
    )?
    onTaskCreated,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xff363636),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => AddTask(onTaskCreated: onTaskCreated),
    );
  }

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final TextEditingController _taskController = TextEditingController();
  late final TextEditingController _descriptionController =
      TextEditingController();
  DateTime? selectedDate;
  int? selectedPriority;
  Category? selectedCategory;

  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
            keyboardType: TextInputType.text,

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
            style: GoogleFonts.lato(color: Colors.grey[400], fontSize: 12),
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
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.timer_outlined, color: Colors.white),
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
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.sell_outlined, color: Colors.white),
                    onPressed: () async {
                      final pickedCategory = await CategoryDialog.show(
                        context,
                        initialCategory: selectedCategory,
                      );
                      if (pickedCategory != null) {
                        setState(() {
                          selectedCategory = pickedCategory;
                        });
                      }
                    },
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.flag_outlined, color: Colors.white),
                    onPressed: () async {
                      final int? pickedPriority = await PriorityDialog.show(
                        context,
                        initialDate: selectedDate,
                      );
                      if (pickedPriority != null) {
                        setState(() {
                          selectedPriority = pickedPriority;
                        });
                      }
                    },
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.send_outlined, color: Color(0xff8687E7)),
                onPressed: () {
                  final title = _taskController.text.trim();
                  if (title.isEmpty) return;

                  final taskDate = selectedDate ?? DateTime.now();

                  context.read<TaskProvider>().addTask(
                    title: title,
                    description: _descriptionController.text.trim(),
                    date: taskDate,
                    category: selectedCategory,
                    priority: selectedPriority,
                  );

                  _taskController.clear();
                  _descriptionController.clear();

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
