import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/models/todo_model.dart';
import 'package:todo_app_provider/providers/todo_provider.dart';
import 'package:todo_app_provider/widgets/custom_text_field.dart';

class DetailsScreen extends StatefulWidget {
  final TodoModel todo;
  final int index;
  const DetailsScreen({super.key, required this.todo, required this.index});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.desc;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.todo.title)),
      body: Center(
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                CustomTextField(
                  controller: titleController,
                  labelText: 'Title',
                ),
                CustomTextField(
                  controller: descriptionController,
                  labelText: 'Description',
                  maxLines: 2,
                ),

                ElevatedButton(
                  onPressed: () {
                    final newTodo = TodoModel(
                      id: DateTime.now().toString(),
                      title: titleController.text.trim(),
                      desc: descriptionController.text.trim(),
                    );
                    provider.updateTodo(widget.index, newTodo);
                    Navigator.pop(context);
                  },
                  child: Text('update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
