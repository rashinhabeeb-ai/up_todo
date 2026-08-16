import 'package:flutter/material.dart';
import 'package:up_todo/add_task/bottom_navigation.dart';
import 'package:up_todo/calandar/calandar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData.dark(

      ),
      debugShowCheckedModeBanner: false,
      home:BottomNavigationPage()
    );
  }
}