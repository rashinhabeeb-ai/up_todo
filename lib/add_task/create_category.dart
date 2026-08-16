import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCategory extends StatefulWidget {
   const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();

}

class _CreateCategoryState extends State<CreateCategory> {
  final List<Color> listColor = [
    const Color(0xffC9CC41),
    const Color(0xff66CC41),
    const Color(0xff80FFFF),
    const Color(0xff41CCA7),
    const Color(0xff4181CC),
    const Color(0xffCC8441),
    const Color(0xffFF80EB),
    const Color(0xffCC4173),
  ];

  late final TextEditingController _categoryController = TextEditingController();
  int _selectedColorIndex = 0;



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text('Create new category',
        style: GoogleFonts.lato(
          color: Colors.white,
          fontWeight: FontWeight.w700
        ),),

      ),
      backgroundColor: Colors.black,
      body: Column(
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
              onPressed: () async {
                // final selectedDate = _selectedDay;
                // Navigator.pop(context);
                //
                // final TimeOfDay? pickedTime = await TimePickerDialogWidget.show(
                //   context,
                //   initialTime: _selectedTime ?? TimeOfDay.now(),
                // );
                //
                // if (pickedTime != null) {
                //   setState(() {
                //     _selectedTime = pickedTime;
                //   });
                // }
              },
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
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: listColor[index],
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
                  onPressed: () async {
                    Navigator.pop(context);
                    // final selectedDate = _selectedDay;
                    // Navigator.pop(context);
                    //
                    // final TimeOfDay? pickedTime = await TimePickerDialogWidget.show(
                    //   context,
                    //   initialTime: _selectedTime ?? TimeOfDay.now(),
                    // );
                    //
                    // if (pickedTime != null) {
                    //   setState(() {
                    //     _selectedTime = pickedTime;
                    //   });
                    // }
                  },
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
    );
  }
}
