import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app_provider/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  //What data we will be stored => list of TodoModel type
  final List<TodoModel> _allTodos = [];

  //Getter function to get the actual data that is stored in the private variable
  List<TodoModel> get allTodos => _allTodos;

  //To add new todo
  void addTodo(TodoModel todo) {
    log('Before adding new todo: $_allTodos'); // => empty
    _allTodos.add(todo);
    log('After adding new todo ${todo.title}');
    log('After adding new todo $_allTodos');
    notifyListeners();
  }

  //To delete existed todo
  void deleteTodo(int index) {
    //jun todo delete garnu parne ho tesko index bata tyo todo lai list batah euta
    //single todo vanne variable mah rakhe
    // final todo = _allTodos[index]; // index = 2, _allTodos[2] => sleepa =>todo
    _allTodos.removeAt(index);
    notifyListeners();
  }
}
