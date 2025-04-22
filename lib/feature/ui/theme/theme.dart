import 'package:flutter/material.dart';

final themeDark = ThemeData.dark().copyWith(
  primaryColor: const Color.fromARGB(255, 55, 59, 61), 
  hintColor: const Color(0xFF4D4D4D),
  canvasColor: const Color.fromARGB(255, 195, 185, 185),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        
        fontSize: 18,
    ),
    
    labelLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        
        fontSize: 20,
    ),
    bodyLarge: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
    labelSmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 16,
    ),
  ),
);

