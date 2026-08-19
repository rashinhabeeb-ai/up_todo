import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/task_provider.dart';
import 'package:intl/intl.dart';

class WeekCalendarScreen extends StatefulWidget {
  const WeekCalendarScreen({super.key});

  @override
  State<WeekCalendarScreen> createState() => _WeekCalendarScreenState();
}

class _WeekCalendarScreenState extends State<WeekCalendarScreen> {
  DateTime selectedDate = DateTime.now();
  bool isTodaySelected = true;

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;

    // Filter tasks based on selected date and completion status
    final selectedTasks = tasks.where((task) {
      if (task.date == null) return false;

      // Normalize dates to ignore time components (HH:mm:ss)
      final taskDate = DateTime(task.date!.year, task.date!.month, task.date!.day);
      final calendarDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

      final isSameDate = taskDate == calendarDate;

      if (isTodaySelected) {
        return isSameDate && !task.isCompleted;
      }
      return isSameDate && task.isCompleted;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Calendar',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          /// Horizontal Week Calendar Section
          Container(
            height: 180,
            color: const Color(0xFF363636),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: HorizontalWeekCalendar(
              minDate: DateTime.now().subtract(const Duration(days: 365)),
              maxDate: DateTime(2030, 12, 31),
              initialDate: selectedDate,
              weekStartFrom: WeekStartFrom.Sunday,
              activeBackgroundColor: const Color(0xFF8687E7),
              activeTextColor: Colors.white,
              inactiveBackgroundColor: const Color(0xFF272727),
              inactiveTextColor: Colors.white,
              disabledBackgroundColor: Colors.transparent,
              disabledTextColor: const Color(0xFF2E2E45),
              activeNavigatorColor: const Color(0xFF9090A8),
              inactiveNavigatorColor: const Color(0xff2E2E45),
              borderRadius: BorderRadius.circular(6),
              scrollPhysics: const BouncingScrollPhysics(),
              onDateChange: (date) {
                setState(() => selectedDate = date);
              },
              monthFormat: "MMMM\n   yyyy",
              showNavigationButtons: true,
              monthColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          /// Tab Switcher (Today / Completed)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xff4C4C4C),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isTodaySelected = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isTodaySelected
                              ? const Color(0xFF8687E7)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: !isTodaySelected
                              ? Border.all(color: Colors.white54)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'Today',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isTodaySelected = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !isTodaySelected
                              ? const Color(0xFF8687E7)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: isTodaySelected
                              ? Border.all(color: Colors.white54)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'Completed',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          /// Task List View
          Expanded(
            child: selectedTasks.isEmpty
                ? Center(
              child: Text(
                isTodaySelected
                    ? 'No tasks for this day'
                    : 'No completed tasks',
                style: GoogleFonts.lato(color: Colors.white54),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: selectedTasks.length,
              itemBuilder: (context, index) {
                final task = selectedTasks[index];
                return _buildTaskTile(task: task);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskTile({required Task task}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF363636),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // Radio / Completion Checkbox
          GestureDetector(
            onTap: () {
              context.read<TaskProvider>().toggleTask(task);
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isCompleted
                    ? const Color(0xff8687E7)
                    : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted ? const Color(0xff8687E7) : Colors.white,
                ),
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          // Title & Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (task.date != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm').format(task.date!),
                    style: GoogleFonts.lato(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Category Tag
          if (task.category != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xff809CFF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(task.category!.icon, size: 14, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    task.category!.name,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
          // Priority Flag
          if (task.priority != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white38),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.outlined_flag, size: 14, color: Colors.white),
                  const SizedBox(width: 2),
                  Text(
                    '${task.priority}',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}