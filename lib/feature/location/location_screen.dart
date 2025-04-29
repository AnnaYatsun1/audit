import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

@RoutePage()
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationState();
}

class _LocationState extends State<LocationScreen> {
  final List<Map<String, String>> locations = [
    {"location": "Склад 1", "available": "10"},
    {"location": "Склад 2", "available": "5"},
    {"location": "Склад 3", "available": "8"},
    {"location": "Склад 4", "available": "12"},
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: false,
      child: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            color: Color(0xFF1E1E1E),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location["location"] ?? 'Невідома локація',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Кількість: ${location["available"] ?? "0"}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, color: Colors.white),
                    onPressed: () {
                      // Действие при нажатии
                      print('Перейти до детальної локації');
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
