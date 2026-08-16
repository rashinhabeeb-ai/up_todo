import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_category.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({required this.name, required this.icon, required this.color});
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
    Category(name: 'Grocery', icon: Icons.local_grocery_store_outlined, color: const Color(0xFFCCFF80)),
    Category(name: 'Work', icon: Icons.work_outline, color: const Color(0xFFFF9680)),
    Category(name: 'Sport', icon: Icons.sports_soccer_outlined, color: const Color(0xFF80FFFF)),
    Category(name: 'Design', icon: Icons.brush_outlined, color: const Color(0xFFFC80FF)),
    Category(name: 'University', icon: Icons.school_outlined, color: const Color(0xFF80FFA3)),
    Category(name: 'Home', icon: Icons.home_outlined, color: const Color(0xFFFFCC80)),
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
        width: w * 0.8,
        height: h * 0.4,
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
                      MaterialPageRoute(builder: (context) => const CreateCategory()),
                    );
                  });
                },
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff80FFD1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFF00A369),
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Create New',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 12,
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
                    width: 60,
                    height: 50,
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: catge.color,
                      borderRadius: BorderRadius.circular(5),
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Icon(catge.icon,
                          color: Colors.black38, size: 20),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    catge.name,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 12,
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