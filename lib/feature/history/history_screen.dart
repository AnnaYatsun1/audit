import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, String>> history = [
    {"date": "2023-04-21", "change": "Об'єкт переміщено на склад 1", "user": "Адміністратор"},
    {"date": "2023-04-18", "change": "Об'єкт отримано на склад 2", "user": "Завскладом"},
    {"date": "2023-04-15", "change": "Зміна статусу на 'Відремонтовано'", "user": "Технік"},
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(appBarIsVisible: true,  child: ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              color: Color(0xFF1E1E1E),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Дата изменения
                    Text(
                      item["date"] ?? 'Дата невідома',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Описание изменения
                    Text(
                      item["change"] ?? 'Зміна невідома',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Пользователь, который сделал изменение
                    Text(
                      'Користувач: ${item["user"] ?? "Невідомий"}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Divider между изменениями
                    Divider(color: Colors.grey[700]),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
