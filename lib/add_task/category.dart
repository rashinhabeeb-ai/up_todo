import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_category.dart';


class Category {
  final String name;
  final IconData icon;
  final Color color;
  final Color iconColor;

  Category({required this.name, required this.icon,
    required this.color, required this.iconColor, });
}

class CategoryDialog extends StatefulWidget {
  final Category? initialCategory;

  const CategoryDialog({super.key, this.initialCategory});

  // FIX 1: Changed return type from Future<int?> to Future<Category?>
  static Future<Category?> show(BuildContext context, {
    Category? initialCategory
  }) {
    // FIX 2: Changed generic parameter from <int> to <Category>
    return showDialog<Category>(
      context: context,
      builder: (context) => CategoryDialog(initialCategory: initialCategory),
    );
  }

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  Category? _selectedCategory;

  final List<Category> categories = [
    Category(name: 'Grocery', icon: Icons.local_grocery_store_outlined, color:  Color(0xFFCCFF80), iconColor: Color(0xff21A300)),
    Category(name: 'Work', icon: Icons.work_outline, color:  Color(0xFFFF9680), iconColor: Color(0xffA31D00)),
    Category(name: 'Sport', icon: Icons.sports_soccer_outlined, color:  Color(0xFF80FFFF), iconColor: Color(0xff00A32F)),
    Category(name: 'Design', icon: Icons.brush_outlined, color:  Color(0xFF80FFD9), iconColor:Color(0xff00A372)),
    Category(name: 'University', icon: Icons.school_outlined, color:  Color(0xFF809CFF), iconColor: Color(0xff0055A3)),
    Category(name: 'Home', icon: Icons.home_outlined, color:  Color(0xFFFFCC80), iconColor: Color(0xffA36200)),
    Category(name: 'Movie', icon: Icons.movie_creation_outlined, color: Color(0xff80D1FF), iconColor: Color(0xff0069A3)),
    Category(name: 'Health', icon: Icons.monitor_heart_outlined, color: Color(0xff80FFA3), iconColor:Color(0xff00A3A3)),
    Category(name: 'Music', icon: CupertinoIcons.double_music_note, color: Color(0xffFC80FF), iconColor:Color(0xffA000A3) )
    
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: const Color(0xFF363636),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      titlePadding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      actionsPadding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      title: const Column(
        children: [
          Text(
            'Choose Category',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Divider(color: Colors.white70),
        ],
      ),
      content: SizedBox(
        width: w * 0.9,
        height: h * 0.45,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            mainAxisExtent: 80,
          ),
          itemCount: categories.length + 1,
          itemBuilder: (context, index) {
            if (index == categories.length){
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)
                      => CreateCategory()),
                    );
                  });
                },
                child: Column(
                  children: [
                    Container(
                      width: w*0.17,
                      height: h*0.065,
                      decoration: BoxDecoration(
                        color:  Color(0xff80FFD1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:  Icon(
                        Icons.add_rounded,
                        color: Color(0xFF00A369),
                        size: 25,
                      ),
                    ),
                     SizedBox(height: 4),
                    Text(
                      'Create New',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }

            final catge = categories[index];
            final isSelected = _selectedCategory?.name == catge.name;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = catge;
                });
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    width: w*0.17,
                    height: h*0.065,
                    duration:  Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: catge.color,
                      borderRadius: BorderRadius.circular(5),
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Icon(catge.icon,
                          color: catge.iconColor,
                          size: 25),
                    ),
                  ),
                   SizedBox(height: 4),
                  Text(
                    catge.name,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // FIX 3: Return the full Category object instead of .id
                  Navigator.pop(context, _selectedCategory);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8687E7),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Add Category',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}