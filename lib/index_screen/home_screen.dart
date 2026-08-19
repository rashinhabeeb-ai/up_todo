import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/add_task/edit_task.dart';
import 'package:up_todo/profile/profile_page.dart';
import '../task_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _searchQuery = "";

  String _formatTaskDate(DateTime? date) {
    if (date == null) return "";

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final taskDate = DateTime(date.year, date.month, date.day);

    final timeStr = DateFormat('HH:mm').format(date);
    String dateStr;

    if (taskDate == today) {
      dateStr = "Today";
    } else if (taskDate == tomorrow) {
      dateStr = "Tomorrow";
    } else {
      dateStr = DateFormat('MMM dd, yyyy').format(date);
    }
    return "$dateStr At $timeStr";
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final tasks = context.watch<TaskProvider>().tasks;

    /// Filter tasks based on search
    final filteredTasks = tasks.where((task) {
      return task.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    /// Separate pending and completed tasks
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmsxGwCKdVps9Wy59EB2ZNEpG9sjqzXtLA81-AFjkfKcfCvxDWbo5gAGz5&s=10',
                ),
              ),
            ),
          ),
        ],
      ),
      body: tasks.isEmpty
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
          ),
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
              const SizedBox(height: 10),
              ...pendingTasks.map((task) => _buildTaskTile(task)),
            ],

            /// Completed Tasks Section
            if (completedTasks.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildDropdownHeader("Completed"),
              const SizedBox(height: 10),
              ...completedTasks.map((task) => _buildTaskTile(task)),
            ],
          ],
        ),
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
              context.read<TaskProvider>().toggleTask(task);
            },
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isCompleted
                    ? const Color(0xff8687E7)
                    : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted
                      ? const Color(0xff8687E7)
                      : Colors.white70,
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTask(task: task,),
                      ),
                    );
                  },
                  child: Text(
                    task.title,
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
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
                color:  Color(0xFF809CFF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(task.category!.icon, size: 13, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    task.category!.name,
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
                    '${task.priority}',
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