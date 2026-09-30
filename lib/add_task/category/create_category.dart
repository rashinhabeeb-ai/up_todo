import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/add_task/category/category_model.dart';
import 'package:up_todo/provider/category_provider.dart';

class CreateCategory extends StatefulWidget {
   const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();

}

class _CreateCategoryState extends State<CreateCategory> {
  final TextEditingController _categoryController = TextEditingController();

  IconData selectedIcon = Icons.category_outlined;

  Color selectedColor = Color(0xffD7DD35);
  Color selectedIconColor = Color(0xff0055A3);

  final List<IconData> icons = [
    Icons.category_outlined,
    Icons.shopping_basket_outlined,
    Icons.work_outline,
    Icons.fitness_center,
    Icons.school_outlined,
    Icons.music_note_outlined,
    Icons.favorite_outline,
    Icons.movie_outlined,
    Icons.home_outlined,
    Icons.sports_soccer,
    Icons.book_outlined,
    Icons.restaurant_outlined,
  ];

  final List<Color> listColor = [
     Color(0xffC9CC41),
     Color(0xff66CC41),
     Color(0xff80FFFF),
     Color(0xff41CCA7),
     Color(0xff4181CC),
     Color(0xffCC8441),
     Color(0xffFF80EB),
     Color(0xffCC4173),
  ];

  int _selectedColorIndex = 0;

@override
  void dispose() {
_categoryController.dispose();
super.dispose();
  }

  void showIconPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF363636),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: icons.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              final isSelected = icons[index] == selectedIcon;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIcon = icons[index];
                  });

                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(10),
                    border: isSelected
                        ? Border.all(
                      color: Colors.white,
                      width: 2,
                    )
                        : null,
                  ),
                  child: Icon(
                    icons[index],
                    color: selectedIconColor,
                    size: 28,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

void createCategory(){
  final name = _categoryController.text.trim();

  if( name.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Enter Category name"))
    );
    return;
  }


  final category = Category(
  name: name,
  icon: selectedIcon,
  color: selectedColor,
  iconColor: selectedIconColor
  );
  context.read<CategoryProvider>().addCategory(category);
  Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Create new category',
        style: GoogleFonts.lato(
          color: Colors.white,
          fontWeight: FontWeight.w700
        ),),

      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Category name :',style: GoogleFonts.lato(
                color: Colors.white,fontSize: w*0.035
              ),),
            ),
            SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _categoryController,
                style: GoogleFonts.lato(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:Color(0xff1D1D1D),
                  hintText: 'Category name',
                  hintStyle: GoogleFonts.lato(
                    color: Color(0xffAFAFAF),
                    fontSize: 14,
                  ),
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
            SizedBox(height: 4),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Category icon :',style: GoogleFonts.lato(
                color: Colors.white,fontSize: w*0.035
              ),),
            ),
            SizedBox(height: 4),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: showIconPicker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0x36FFFFFF),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Choose icon from library',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Category color :',style: GoogleFonts.lato(
                  color: Colors.white,fontSize: w*0.035
              ),),
            ),
            SizedBox(height: 4),

            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listColor.length ,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedColorIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                      selectedColor = listColor[index];
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: listColor[index],
                      child: isSelected
                      ? Icon(Icons.check,
                      color: Colors.black,):
                      null,
                      ),
                  ),
                );
              },),
            ),
            SizedBox(height: h*0.3),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Cancel Button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
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

                  /// Create Category
                  ElevatedButton(
                    onPressed: createCategory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C7CFF),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child:  Text(
                      'Create Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
