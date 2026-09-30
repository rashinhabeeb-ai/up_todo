import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/add_task/bottom_navigation.dart';
import 'package:up_todo/provider/category_provider.dart';
import 'package:up_todo/provider/focus_provider.dart';
import 'package:up_todo/intro/onboading.dart';
import 'package:up_todo/intro/start_screen.dart';
import 'package:up_todo/login_registration/login_screen.dart';
import 'package:up_todo/login_registration/register_page.dart';
import 'package:up_todo/profile/profile_page.dart';
import 'package:up_todo/profile/settings.dart';
import 'package:up_todo/splash_screen.dart';
import 'package:up_todo/provider/task_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FocusProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],

      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        routes: {
          '/': (context) => SplashScreen(),
          '/obBoard': (context) => OnboadingScreen(),
          '/start': (context) => StartScreen(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/bottomNavi': (context) => BottomNavigationPage(),
          '/profile': (context) => ProfilePage(),
          '/settings': (context) => SettingsPage(),
        },
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        // home: SplashScreen()
      ),
    );
  }
}
