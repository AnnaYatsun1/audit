import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';


// class DropdownButtonWidget<T> extends StatelessWidget {
//   final TextEditingController controller;
//   final List<T> items;
//   final String label;

//   const DropdownButtonWidget({
//     super.key,
//     required this.controller,
//     required this.items,
//     required this.label,
//   });
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<T>(
//       value: _parseEnumValue(controller.text) as T?, // Преобразуем строку в enum
//       selectedItemBuilder: (BuildContext context) {
//         return items.map<Widget>((T item) {
//           return Text(
//             item.toString().split('.').last,
//             style: TextStyle(color: Colors.white), // Белый для выбранного
//           );
//         }).toList();
//       },
//       onChanged: (value) {
//         // Обновление контроллера с выбранным значением
//         controller.text = value.toString().split('.').last;
//       },
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.white),
//         border: OutlineInputBorder(),
//       ),
//       items: items.map<DropdownMenuItem<T>>((T item) {
//         return DropdownMenuItem<T>(
//           value: item,
//           child: Text(
//             item.toString().split('.').last, // Отображаем название элемента
//             style: TextStyle(color: Colors.black),
//           ),
//         );
//       }).toList(),
//     );
//   }

//     T _parseEnumValue<T>(String value) {
//     if (T == InventoryBrand) {
//       return InventoryBrand.values.firstWhere(
//         (e) => e.toString().split('.').last == value,
//         orElse: () => InventoryBrand.Apple, // Значение по умолчанию
//       ) as T;
//     } else if (T == InventoryType) {
//       return InventoryType.values.firstWhere(
//         (e) => e.toString().split('.').last == value,
//         orElse: () => InventoryType.phone, // Значение по умолчанию
//       ) as T;
//     }
//     throw Exception("Unknown enum type");
//   }
// }

class DropdownButtonWidget<T> extends StatelessWidget {
  final TextEditingController controller;
  final List<T> items;
  final String label;
  final T Function(String value) fromString;

  const DropdownButtonWidget({
    super.key,
    required this.controller,
    required this.items,
    required this.label,
    required this.fromString,
  });

  @override
  Widget build(BuildContext context) {
    T? selectedValue;

    try {
      selectedValue = fromString(controller.text);
    } catch (_) {
      selectedValue = null;
    }

    return DropdownButtonFormField<T>(
      value: selectedValue,
      onChanged: (value) {
        if (value != null) {
          controller.text = value.toString().split('.').last;
        }
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
      ),
      dropdownColor: Colors.grey[850],
      items: items.map<DropdownMenuItem<T>>((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString().split('.').last,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
