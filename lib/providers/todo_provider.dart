import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void toggleTodoDone(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }

  void toggleTodoPriority(int index) {
    _todos[index].isHighPriority = !_todos[index].isHighPriority;
    notifyListeners();
  }
}

class Todo {
  String title;
  DateTime date;
  bool isDone;
  bool isHighPriority;

  Todo({
    required this.title,
    required this.date,
    this.isDone = false,
    this.isHighPriority = false,
  });
}
