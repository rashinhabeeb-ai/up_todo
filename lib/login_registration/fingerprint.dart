import 'package:flutter/material.dart';
import 'package:up_todo/login_registration/login_screen.dart';
import 'package:up_todo/intro/start_screen.dart';

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

    late double h = MediaQuery.of(context).size.height;
    late double w = MediaQuery.of(context).size.width;

    final Color mainColor = isError ?  Colors.red : Colors.white;
    final String messageText = isError
        ? "Your fingerprint is not matched.Please try again later!!!"
        : "Please hold your finger at the fingerprint scanner to verify your identity";

    return Container(
      height: h*0.02,
      padding: const EdgeInsets.symmetric(
          horizontal: 4, vertical: 3),
      decoration: const BoxDecoration(
        color: Color(0xFF2E2E32),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),

          // Fingerprint Icon
          Icon(
            Icons.fingerprint,
            size: 80,
            color: mainColor,
          ),

          const SizedBox(height: 24),

          // Message Text
          Text(
            messageText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              color: mainColor.withOpacity(isError ? 1.0 : 0.8),
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 36),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Cancel Button
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/start');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF7C7CFF), // Accent purple color
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Use Password Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C7CFF), // Filled purple button
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
    );
  }
}