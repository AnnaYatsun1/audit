import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAdaptiveButton extends StatelessWidget {
  final bool isActivated;
  final String title;
  final VoidCallback? onPressed;
  final bool isDestructive; 
  final Color? color; 
  final double? height; 

  const CustomAdaptiveButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isDestructive = false,
    this.isActivated = false,
    this.color,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    // Определяем платформу
    if (Platform.isIOS) {
      // iOS: CupertinoButton
      return SizedBox(
        height: height,
        width: double.infinity,
        child: CupertinoButton(
          color: color ?? (isDestructive ? CupertinoColors.systemRed : CupertinoColors.activeBlue),
          borderRadius: BorderRadius.circular(12),
           onPressed: isActivated ? onPressed : null,
          child: Text(
            title,
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 18,
            ),
          ),
        ),
      );
    } else {
      // Android: ElevatedButton
      return SizedBox(
        height: height,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isActivated ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? (isDestructive ? Colors.red : Colors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      );
    }
  }
}
