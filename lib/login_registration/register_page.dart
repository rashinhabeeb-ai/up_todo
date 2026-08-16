import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo/login_registration/login_screen.dart';
import 'package:up_todo/login_registration/register_page.dart';
import 'package:up_todo/intro/start_screen.dart';

import '../add_task/bottom_navigation.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final bool _isPasswordVisible = false;

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Manual checking
    // if (email.isEmpty) {
    //   _showErrorSnackBar('Please enter your Username');
    //   return;
    // }
    //
    // if (password.isEmpty) {
    //   _showErrorSnackBar('Please enter your password');
    //   return;
    // }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavigationPage()),
      (route) => false,
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    late double h = MediaQuery.of(context).size.height;
    late double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Icon(CupertinoIcons.back),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.01),
                Text(
                  'Register',
                  style: GoogleFonts.lato(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: h * 0.03),
                Text(
                  'Username',
                  style: GoogleFonts.lato(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: h * 0.01),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff1D1D1D),
                    labelText: ' Enter your Username',
                    labelStyle: GoogleFonts.lato(color: Color(0xff535353)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Color(0xff535353)),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.03),
                Text(
                  'Password',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: h * 0.01),

                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff1D1D1D),
                    labelText: '* * * * * * * * * *',
                    labelStyle: GoogleFonts.lato(
                      color: Color(0xff535353),
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Color(0xff535353)),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your password';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: h * 0.03),
                Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: h * 0.01),

                TextFormField(
                  controller: _passwordConfirmController,
                  obscureText: !_isPasswordVisible,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff1D1D1D),
                    labelText: '* * * * * * * * * *',
                    labelStyle: GoogleFonts.lato(
                      color: Color(0xff535353),
                      fontSize: 20,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Color(0xff535353)),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your password';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: h * 0.07),

                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8687E7).withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.05),
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('OR', style: TextStyle(color: Colors.grey)),
                    ),

                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                SizedBox(height: h * 0.05),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: Color(0xff8875FF)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/gOOGle.png'),
                      ),
                      Text(
                        'Login with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.02),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide(color: Color(0xff8875FF)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/apple.png'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Login with Apple',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.04),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Color(0xFFFFFFFFDE)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
