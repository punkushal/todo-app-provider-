import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/models/todo_model.dart';
import 'package:todo_app_provider/providers/todo_provider.dart';
import 'package:todo_app_provider/screens/details_screen.dart';
import 'package:todo_app_provider/widgets/custom_text_field.dart';

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
                CustomTextField(
                  controller: titleController,
                  labelText: 'Title',
                ),
                CustomTextField(
                  controller: descController,
                  labelText: 'Description',
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
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                DetailsScreen(todo: todo, index: index),
                          ),
                        );
                      },
                      title: Text(todo.title, style: TextStyle(fontSize: 18)),
                      subtitle: Text(todo.desc),
                      trailing: IconButton(
                        onPressed: () {
                          provider.deleteTodo(index);
                          //To display toast message when todo is successfully deleted
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Successfully deleted your todo'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
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
