import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Settings', style: GoogleFonts.lato(color: Colors.white)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'settings',
              style: GoogleFonts.lato(color: Color(0xffAFAFAF)),
            ),
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.brush_outlined),
                  ),
                  Text(
                    'Change app color',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.title),
                  ),
                  Text(
                    'Change app typography',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.translate),
                  ),
                  Text(
                    'Change app language',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Import',
              style: GoogleFonts.lato(color: Color(0xffAFAFAF)),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.cloud_download),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Import from Google calendar',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ],
      ),
    );
  }
}
