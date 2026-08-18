import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  bool isTodaySelected = true; // Toggle between Today and Completed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:  Colors.black,
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
            height: 200,
            color:  Color(0xFF363636),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: HorizontalWeekCalendar(
              minDate: DateTime(2022, 1, 1),
              maxDate: DateTime(2030, 12, 31),
              initialDate: selectedDate,
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
              showTopNavbar: true,
              monthFormat: "MMMM\n   yyyy",
              showNavigationButtons: true,
              weekStartFrom: WeekStartFrom.Sunday,
              borderRadius: BorderRadius.circular(6),
              activeBackgroundColor:  Color(0xFF8687E7),
              activeTextColor: Colors.white,

              inactiveBackgroundColor:  Color(0xFF272727),
              inactiveTextColor: Colors.white,
              // disabledTextColor: Colors.red,
              monthColor: Colors.white,
              scrollPhysics: BouncingScrollPhysics(),

            ),
          ),
           SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:  Color(0xff4C4C4C),
                borderRadius: BorderRadius.circular(8),
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
                   SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isTodaySelected = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !isTodaySelected
                              ?  Color(0xFF8687E7)
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
          SizedBox(height: 16),

          // 3. Task List
          // Expanded(
          //   child: ListView(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     children: [
          //       _buildTaskTile(
          //         title: 'Do Math Homework',
          //         time: 'Today At 16:45',
          //         category: 'University',
          //         categoryColor: const Color(0xFF809CFF),
          //         categoryIcon: Icons.school_outlined,
          //         priority: 1,
          //       ),
          //       _buildTaskTile(
          //         title: 'Tack out dogs',
          //         time: 'Today At 18:20',
          //         category: 'Home',
          //         categoryColor: const Color(0xFFFF9680),
          //         categoryIcon: Icons.home,
          //         priority: 2,
          //       ),
          //       _buildTaskTile(
          //         title: 'Business meeting with CEO',
          //         time: 'Today At 08:15',
          //         category: 'Work',
          //         categoryColor: const Color(0xFFFFCC80),
          //         categoryIcon: Icons.work_outline,
          //         priority: 3,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildTaskTile({
    required String title,
    required String time,
    required String category,
    required Color categoryColor,
    required IconData categoryIcon,
    required int priority,
  }) {
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
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white70, width: 2),
            ),
          ),
          const SizedBox(width: 12),
          // Title & Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: GoogleFonts.lato(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Category Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(categoryIcon, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  category,
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
          // Priority Flag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white38),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.outlined_flag,
                    size: 14, color: Colors.white),
                const SizedBox(width: 2),
                Text(
                  '$priority',
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}