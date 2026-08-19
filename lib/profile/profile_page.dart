import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo/task_provider.dart';

class SettingsItemData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  SettingsItemData({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });
}

class SettingsSectionData {
  final String sectionTitle;
  final List<SettingsItemData> items;

  SettingsSectionData({required this.sectionTitle, required this.items});
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late final TextEditingController _nameController =
  TextEditingController();
  late final TextEditingController _oldpasswordController =
  TextEditingController();
  late final TextEditingController _newpasswordController =
  TextEditingController();

  String profileName = 'rash';

  @override
  void dispose() {
    _nameController.dispose();
    _newpasswordController.dispose();
    super.dispose();
  }

  void _showEditNameDialog() async {
    _nameController.text = profileName;
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff363636),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: Text(
            'Change account name',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 700,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(color: Colors.white70),
                SizedBox(height: 12),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: _nameController,
                    autofocus: true,
                    style: GoogleFonts.lato(color: Colors.white54),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff979797)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff979797)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.lato(
                          color: const Color(0xFF7C7CFF),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final updatedName = _nameController.text.trim();
                        if (updatedName.isNotEmpty) {
                          Navigator.pop(context, updatedName);
                        }
                        print("New Name: ${_nameController.text}");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C7CFF),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Edit',
                        style: GoogleFonts.lato(
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
      },
    );
    if (result != null && result.isNotEmpty) {
      setState(() {
        profileName = result;
      });
    }
  }

  void _showEditPasswordDialog() async {
    final String? newPassword = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff363636),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: Text(
            'Change account password',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: 200,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.white70),
                Text(
                  'Enter old password',
                  style: GoogleFonts.lato(color: Colors.white60),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: _oldpasswordController,
                    autofocus: true,
                    style: GoogleFonts.lato(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: '*********',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff979797)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff979797)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                ///textField
                SizedBox(height: 15),
                Text(
                  'Enter new password',
                  style: GoogleFonts.lato(color: Colors.white60),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: _newpasswordController,
                    autofocus: true,
                    style: GoogleFonts.lato(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: '*********',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff979797)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff979797)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                ///textField
                SizedBox(height: 15),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.lato(
                      color: const Color(0xFF7C7CFF),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final oldPass = _oldpasswordController.text.trim();
                    final newPass = _newpasswordController.text.trim();

                    if (oldPass.isEmpty || newPass.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Enter both field',
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (oldPass == newPass) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'New password cannot be same as old password',
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // if (newPass.length < 6) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text('Password must be atleast contain 6 characters'),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    //   return;
                    // }

                    if (oldPass.isNotEmpty && newPass.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Password Updated',
                            style: GoogleFonts.lato(color: Colors.black),
                          ),
                        ),
                      );
                      Navigator.pop(context, newPass);
                    }
                    print("New Name: ${_nameController.text}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C7CFF),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    if (newPassword != null && newPassword.isNotEmpty) {
      print('New Password Saved: $newPassword');
    }
  }

  void _editAccountImage() {
    showModalBottomSheet(
      backgroundColor: Color(0xff363636),
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(4)
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Change account Image',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Color(0xff979797),
                height: 30,
                endIndent: 32,
                indent: 32,
              ),
              TextButton(
                onPressed: () {},

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Take picture',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Import from gallery',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Import from Google Drive',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<SettingsSectionData> _getSettingsMenu() {
    return [
      SettingsSectionData(
        sectionTitle: 'Settings',
        items: [
          SettingsItemData(
            icon: Icons.settings_outlined,
            title: 'App Settings',
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      SettingsSectionData(
        sectionTitle: 'Account',
        items: [
          SettingsItemData(
            icon: Icons.person_outline,
            title: 'Change account name',
            onTap: () => _showEditNameDialog(),
          ),
          SettingsItemData(
            icon: Icons.key_outlined,
            title: 'Change account password',
            onTap: () => _showEditPasswordDialog(),
          ),
          SettingsItemData(
            icon: Icons.camera_alt_outlined,
            title: 'Change account Image',
            onTap: () => _editAccountImage(),
          ),
        ],
      ),
      SettingsSectionData(
        sectionTitle: 'Uptodo',
        items: [
          SettingsItemData(
            icon: Icons.grid_view,
            title: 'About US',
            onTap: () {},
          ),
          SettingsItemData(
            icon: Icons.info_outline,
            title: 'FAQ',
            onTap: () {},
          ),
          SettingsItemData(
            icon: Icons.flash_on,
            title: 'Help & Feedback',
            onTap: () {},
          ),
          SettingsItemData(
            icon: Icons.thumb_up_alt_outlined,
            title: 'Support US',
            onTap: () {},
          ),
          SettingsItemData(
            icon: Icons.logout,
            title: 'Log out',
            isDestructive: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Color(0xff363636),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5)
                    ),
                    title: Text('LogOut',style: GoogleFonts.lato(color: Colors.white),),
                    content: Text(
                      'Are you sure you want to LogOut?',
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          'NO',
                          style: GoogleFonts.lato(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: Text(
                          'Yes',
                          style: GoogleFonts.lato(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    ];
  }

  Widget _buildTile(SettingsItemData item) {
    final color = item.isDestructive ? Colors.red : Colors.white;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      leading: Icon(item.icon, color: color),
      title: Text(
        item.title,
        style: GoogleFonts.lato(color: color, fontSize: 16),
      ),
      trailing: Icon(Icons.chevron_right, color: color),
      onTap: item.onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final List<SettingsSectionData> sections = _getSettingsMenu();

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   automaticallyImplyLeading: false,
      //   title: Text('Profile',
      //       style: GoogleFonts.lato(color: Colors.white)),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          SizedBox(height: 15),

          Text('Profile',
            style: GoogleFonts.lato(
                color: Colors.white,fontSize:25),
         ),
          SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmsxGwCKdVps9Wy59EB2ZNEpG9sjqzXtLA81-AFjkfKcfCvxDWbo5gAGz5&s=10',
            ),
          ),
          SizedBox(height: h * 0.015),
          Text(
            profileName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: h * 0.025),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: h * 0.07,
                width: w * 0.4,
                decoration: BoxDecoration(
                  color: const Color(0xFF363636),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '10 Task left',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: h * 0.07,
                width: w * 0.4,
                decoration: BoxDecoration(
                  color: const Color(0xFF363636),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '5 Task done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.02),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: sections.length,
              itemBuilder: (context, sectionIndex) {
                final section = sections[sectionIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        section.sectionTitle,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ...section.items.map((item) => _buildTile(item)),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
