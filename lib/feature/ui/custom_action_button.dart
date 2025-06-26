import 'package:flutter/material.dart';

class GoldenButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const GoldenButton({
    super.key,
    required this.label,
    required this.onPressed,
   this.backgroundColor = const Color(0xFFF1C40F),
   this.textColor = const  Color.fromARGB(255, 46, 46, 44),
    
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        //  minimumSize: Size(double.infinity, 120),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
      child: Ink(
        decoration: BoxDecoration(
          // gradient: LinearGradient(

          //   colors: [Color(0xFFF1C40F),   Color.fromARGB(255, 255, 149, 0)], // Градиент от золотого
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 46,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor, // Черный цвет текста на золотом фоне
            ),
          ),
        ),
      ),
    );
  }
}
