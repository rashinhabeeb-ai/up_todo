import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro/onboading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState (){
    super.initState();
    _checkLoginStatus();

  //   Future.delayed(Duration(
  //       seconds: 4
  //   )).then((value) => Navigator.pushNamed(context, '/obBoard'),);
  }

  Future<void> _checkLoginStatus () async {
    await Future.delayed(Duration(seconds: 2));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (!mounted) return;

    if (isLoggedIn){
      Navigator.pushNamed(context, '/bottomNavi');
    }
    else{
      Navigator.pushNamed(context, '/login');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/Group 156.png"),

      ),

    );
  }
}
