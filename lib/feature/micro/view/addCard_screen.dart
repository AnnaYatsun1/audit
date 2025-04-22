
import 'package:flutter/material.dart';

class AddStoreCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddStoreCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, size: 40),
              SizedBox(height: 8),
              Text('Add Store'),
            ],
          ),
        ),
      ),
    );
  }
}
