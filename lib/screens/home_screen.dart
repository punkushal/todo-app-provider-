import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/models/todo_model.dart';
import 'package:todo_app_provider/providers/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void onAddingTodo(BuildContext context) {
    //We get our actual defined provider which is in => todo_provider.dart
    final provider = Provider.of<TodoProvider>(context, listen: false);
    //todomodel variable to store todo
    final todo = TodoModel(
      id: DateTime.now().toString(),
      title: titleController.text.trim(),
      desc: descController.text.trim(),
    );

    if (formkey.currentState!.validate()) {
      provider.addTodo(todo);
      //To display toast message when todo is successfully added
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully created your todo'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
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
    //We get our actual defined provider which is in => todo_provider.dart
    final provider = Provider.of<TodoProvider>(context);
    Widget content = Center(
      child: Text(
        'No task added yet!!',
        style: TextStyle(fontSize: 26, color: Colors.grey),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: provider.allTodos.isEmpty
          ? content
          : Consumer<TodoProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.allTodos.length,
                  itemBuilder: (context, index) {
                    final todo = provider.allTodos[index];
                    return Text(todo.title);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPop(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
