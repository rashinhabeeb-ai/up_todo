import 'package:flutter/material.dart';
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
    Future.delayed(Duration(
        seconds: 4
    )).then((value) => Navigator.pushNamed(context, '/obBoard'),);
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
