import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../add_task/add_task.dart';
import '../add_task/category.dart';
import '../add_task/priority.dart';

class Task {
  final String title;
  final String description;
  final DateTime? date;
  final Category? category;
  final int? priority;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.date,
    this.category,
    this.priority,
    this.isCompleted = false,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];
  String _searchQuery = "";

  void _addNewTask(
      String title,
      String description,
      DateTime? date,
      Category? category,
      int? priority,
      ) {
    if (title.trim().isEmpty) return;
    setState(() {
      _tasks.add(
        Task(
          title: title,
          description: description,
          date: date,
          category: category,
          priority : priority,
        ),
      );
    });
  }

  String _formatTaskDate(DateTime? date) {
    if (date == null) return "";
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(date.year, date.month, date.day);

    String dateStr;
    if (taskDate == today) {
      dateStr = "Today";
    } else if (taskDate == today.add( Duration(days: 1))) {
      dateStr = "Tomorrow";
    } else {
      dateStr = DateFormat('dd MMM').format(date);
    }

    final timeStr = DateFormat('HH:mm').format(date);
    return "$dateStr At $timeStr";
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    // Filter tasks based on search
    final filteredTasks = _tasks.where((task) {
      return task.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    final pendingTasks = filteredTasks.where((t) => !t.isCompleted).toList();
    final completedTasks = filteredTasks.where((t) => t.isCompleted).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(Icons.sort, color: Colors.white),
        title: Text(
          'Index',
          style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmsxGwCKdVps9Wy59EB2ZNEpG9sjqzXtLA81-AFjkfKcfCvxDWbo5gAGz5&s=10',
              ),
            ),
          )
        ],
      ),
      body: _tasks.isEmpty
          ? Column(
        children: [
          SizedBox(height: h * 0.15),
          Center(
            child: Image.asset("assets/images/Checklist-rafiki 1.png"),
          ),
          Text(
            'What do you want to do today?',
            style: GoogleFonts.lato(
              fontSize: w * 0.05,
              color: Colors.white,
            ),
          ),
          SizedBox(height: h * 0.015),
          Text(
            'Tap + to add your tasks',
            style: GoogleFonts.lato(
              fontSize: w * 0.04,
              color: Colors.white70,
            ),
          )
        ],
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search Field
            TextFormField(
              onChanged: (val) => setState(() => _searchQuery = val),
              style: GoogleFonts.lato(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for your task...',
                hintStyle: GoogleFonts.lato(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                fillColor: const Color(0xff1D1D1D),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xff979797)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Pending Tasks Section
            if (pendingTasks.isNotEmpty) ...[
              _buildDropdownHeader("Today"),
               SizedBox(height: 10),
              ...pendingTasks.map((task) => _buildTaskTile(task)),
            ],

            /// Completed Tasks Section
            if (completedTasks.isNotEmpty) ...[
               SizedBox(height: 12),
              _buildDropdownHeader("Completed"),
               SizedBox(height: 10),
              ...completedTasks.map((task) => _buildTaskTile(task)),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xff8687E7),
        shape:  CircleBorder(),
        onPressed: () {
          AddTask.show(
            context,
            onTaskCreated: (title, description, date, category, priorty) {
              _addNewTask(title, description, date,category , priorty);
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  /// Section Header with Caret Dropdown
  Widget _buildDropdownHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF4C4C4C),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  /// Individual Task Card
  Widget _buildTaskTile(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF363636),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          /// Custom Circular Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                task.isCompleted = !task.isCompleted;
              });
            },
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isCompleted ? const Color(0xff8687E7) : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted ? const Color(0xff8687E7) : Colors.white70,
                  width: 1.5,
                ),
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),

          /// Task Title & Date String
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                if (task.date != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _formatTaskDate(task.date),
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ],
            ),
          ),

          /// Category Chip
          if (task.category != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF809CFF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.school_outlined, size: 13, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    'Category',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],

          /// Priority Badge
          if (task.priority != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white38),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.outlined_flag, size: 13, color: Colors.white),
                  const SizedBox(width: 2),
                  Text(
                    '1',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}