import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int? maxLines;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value!.isEmpty || value == "") {
          return "Please enter the title";
        } else if (value.length < 4) {
          return "Please enter title length greater than 4";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
