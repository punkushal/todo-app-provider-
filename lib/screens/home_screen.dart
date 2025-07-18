import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void onAddingTodo(BuildContext context) {
    if (formkey.currentState!.validate()) {
      log('you added todo succesfully');
      Navigator.pop(context);
    }
  }

  void showAddPop(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 14,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter the title";
                    } else if (value.length < 4) {
                      return "Please enter title length greater than 4";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter the description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 6),

                //It aligns the two buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Cancel button
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),

                    //Add button
                    ElevatedButton(
                      onPressed: () {
                        onAddingTodo(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPop(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
