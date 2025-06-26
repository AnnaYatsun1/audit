import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final ValueChanged<String> onChange;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.errorText, required this.onChange, required Null Function(dynamic text) onChanged});

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      controller: controller,
      autocorrect: false,
      decoration: InputDecoration(
        fillColor: Color(0xFF2C2C2C),
        filled: true,
        labelText: label,
        hintText:
            label, // Это будет текст по умолчанию, который будет исчезать при вводе
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color(0xFF2C2C2C)), // Цвет бордера при фокусе
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: onChange,
    );
  }
}

