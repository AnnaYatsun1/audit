

import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration customDecoration(BuildContext context, String label, String hintLabel) {
    return InputDecoration(
      labelText: label,
      hintText: hintLabel,
      hintStyle: const TextStyle(color: Colors.black26),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
