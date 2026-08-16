import 'package:flutter/material.dart';
import 'package:up_todo/calandar/calandar.dart';
import 'package:up_todo/index_screen/home_screen.dart';
import 'package:up_todo/profile/profile_page.dart';
import '../focus/focus_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int selectIndex = 0;

  final GlobalKey<HomeScreenState> _homeKey = GlobalKey<HomeScreenState>();

  late final List<Widget> pages;

  @override
  void initState(){
    super.initState();
  pages = [
    HomeScreen(key: _homeKey,),
    CalendarScreen(),
    FocusPage(),
    ProfilePage(),
  ];}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: selectIndex,
          children: pages
        ),
        backgroundColor: Colors.white,

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (value) {
            setState(() {
              selectIndex = value;
            });
          },
          currentIndex: selectIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined),
              label: 'Focus',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _addNewTask(String title, String description, DateTime? date) {

  }
}