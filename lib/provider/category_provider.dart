import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../add_task/category/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final List<Category> _categories = [
    Category(
      name: 'Grocery',
      icon: Icons.local_grocery_store_outlined,
      color: Color(0xFFCCFF80),
      iconColor: Color(0xff21A300),
    ),
    Category(
      name: 'Work',
      icon: Icons.work_outline,
      color: Color(0xFFFF9680),
      iconColor: Color(0xffA31D00),
    ),
    Category(
      name: 'Sport',
      icon: Icons.sports_soccer_outlined,
      color: Color(0xFF80FFFF),
      iconColor: Color(0xff00A32F),
    ),
    Category(
      name: 'Design',
      icon: Icons.brush_outlined,
      color: Color(0xFF80FFD9),
      iconColor: Color(0xff00A372),
    ),
    Category(
      name: 'University',
      icon: Icons.school_outlined,
      color: Color(0xFF809CFF),
      iconColor: Color(0xff0055A3),
    ),
    Category(
      name: 'Home',
      icon: Icons.home_outlined,
      color: Color(0xFFFFCC80),
      iconColor: Color(0xffA36200),
    ),
    Category(
      name: 'Movie',
      icon: Icons.movie_creation_outlined,
      color: Color(0xff80D1FF),
      iconColor: Color(0xff0069A3),
    ),
    Category(
      name: 'Health',
      icon: Icons.monitor_heart_outlined,
      color: Color(0xff80FFA3),
      iconColor: Color(0xff00A3A3),
    ),
    Category(
      name: 'Music',
      icon: CupertinoIcons.double_music_note,
      color: Color(0xffFC80FF),
      iconColor: Color(0xffA000A3),
    ),
  ];

  List<Category> get categories => _categories;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }
}
