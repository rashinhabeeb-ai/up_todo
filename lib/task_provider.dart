import 'package:flutter/material.dart';
import 'package:up_todo/add_task/category.dart';

class Task {
  final String title;
  final String description;
  final DateTime? date;
  final Category? category;
  final int? priority;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.date,
    this.category,
    this.priority,
    this.isCompleted = false,
  });
}

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask({
    required String title,
    required String description,
    DateTime? date,
    Category? category,
    int? priority,
  }) {
    _tasks.add(
      Task(
        title: title,
        description: description,
        date: date,
        category: category,
        priority: priority,
      ),
    );

    notifyListeners();
  }

  void toggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}