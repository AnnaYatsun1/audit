
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomPhotoPicker extends StatelessWidget {
  final XFile? imageFile;
  final void Function(ImageSource source) onTap;
  // final VoidCallback? onGalleryTap;

  const CustomPhotoPicker({
    required this.imageFile,
    required this.onTap,
    // required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.2;

    return GestureDetector(
      onTap: () => onTap(ImageSource.camera),
      child: Container(
        height: height,

        width: 200,
        decoration: BoxDecoration(color: Color(0xFF2C2C2C)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageFile != null
                  ? Image.file(File(imageFile!.path), height: height * 0.5)
                  : Icon(Icons.camera_alt,
                      color: Colors.white, size: height * 0.4),
              SizedBox(height: 12),
              TextButton(
                onPressed: () => onTap(ImageSource.gallery),
                child: Text('Вибрати з галереї',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}