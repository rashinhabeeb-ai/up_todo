import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo/login_registration/login_screen.dart';
import 'package:up_todo/login_registration/register_page.dart';

import '../login_registration/fingerprint.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _formKey = GlobalKey<FormState>();


  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging In...'),
          duration: Duration(seconds: 2),),

      );
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => StartScreen(),),
            (route) => false,);
    }
  }
  void _showFingerprintAuth(BuildContext context) {
    FingerprintBottomSheet.show(
      context,
      hasError: false, // Set to true to test the error state UI
      onCancel: () {
        Navigator.pop(context); // Properly close the bottom sheet
        // Add additional navigation/logic here if needed
      },
      onUsePassword: () {
        Navigator.pop(context); // Close bottom sheet before navigating
        // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    late double h = MediaQuery.of(context).size.height;
    late double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Welcome to UpTodo',
                  style:  GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.08,
                  ),),
                  SizedBox(height: h*0.02,),
                  Text(
                    'Please login to your account or create\n new account to continue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white60,
                      fontSize: w * 0.035,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*0.5,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => _showFingerprintAuth(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8875FF),
                          padding: const EdgeInsets.symmetric(vertical: 15, ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                              color:Color(0xff8875FF)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h*0.03,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder:
                       (context) => RegisterPage(), ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                              color:Color(0xff8875FF)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 2
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class FingerprintBottomSheet extends StatefulWidget {
  final bool hasError;
  final VoidCallback onCancel;
  final VoidCallback onUsePassword;

  const FingerprintBottomSheet({
    super.key,
    this.hasError = false,
    required this.onCancel,
    required this.onUsePassword,
  });

  static Future<void> show(
      BuildContext context, {
        bool hasError = false,
        required VoidCallback onCancel,
        required VoidCallback onUsePassword,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => FingerprintBottomSheet(
        hasError: hasError,
        onCancel: onCancel,
        onUsePassword: onUsePassword,
      ),
    );
  }

  @override
  State<FingerprintBottomSheet> createState() => _FingerprintBottomSheetState();
}

class _FingerprintBottomSheetState extends State<FingerprintBottomSheet> {
  late bool isError;

  @override
  void initState() {
    super.initState();
    isError = widget.hasError;
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = isError ? Colors.red : Colors.white;
    final String messageText = isError
        ? "Your fingerprint is not matched. Please try again later!!!"
        : "Please hold your finger at the fingerprint scanner to verify your identity";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF2E2E32),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Hug content dynamically
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Fingerprint Icon
            Icon(
              Icons.fingerprint,
              size: 80,
              color: mainColor,
            ),

            const SizedBox(height: 20),

            // Message Text
            Text(
              messageText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: mainColor.withOpacity(isError ? 1.0 : 0.8),
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel Button
                TextButton(
                  onPressed: widget.onCancel,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF7C7CFF),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Use Password Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder:(context) => LoginPage(), ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C7CFF),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Use Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}