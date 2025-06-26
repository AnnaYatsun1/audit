import 'package:equatable/equatable.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/new_type/model/type_model.dart';

class InventoryItemForLocation {
  final Catogory type;
  final int quantity; // Количество товара этого типа

  InventoryItemForLocation({
    required this.type,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'quantity': quantity,
    };
  }

  factory InventoryItemForLocation.fromJson(Map<String, dynamic> json) {
    return InventoryItemForLocation(
      type:
          Catogory.fromJson(json['type']),
      quantity: json['quantity'],
    );
  }
}

// Модель склада
class Warehouse extends Equatable {
  final String id;
  final String name;
  final String cityNameCode;
  final List<InventoryItemForLocation> inventoryItems; 
  final User? responsible; // Список товаров с количеством на складе

  Warehouse({
    required this.id,
    required this.name,
    required this.inventoryItems,
    required this.cityNameCode,
    this.responsible
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inventoryItems': inventoryItems.map((item) => item.toJson()).toList(),
      'responsible': responsible
    };
  }

  // Создание модели из JSON
  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'],
      name: json['name'],
      cityNameCode: json[''],
      inventoryItems: (json['inventoryItems'] as List)
          .map((item) => InventoryItemForLocation.fromJson(item))
          .toList(),
    );
  }

   @override
  List<Object?> get props => [id];
}

class City {
  final String cityName;
  final List<Warehouse> warehouses;

  City({required this.cityName, required this.warehouses});

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'warehouses': warehouses.map((warehouse) => warehouse.toJson()).toList(),
    };
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityName: json['cityName'],
      warehouses: (json['warehouses'] as List)
          .map((warehouse) => Warehouse.fromJson(warehouse))
          .toList(),
    );
  }
}

// class LocationModel {
//   final City locationName;

//   LocationModel({
//     required this.locationName,
//   });
//   Map<String, dynamic> toJson() {
//     return {
//       'locationName': locationName.toJson(),
//     };
//   }

//   factory LocationModel.fromJson(Map<String, dynamic> json) {
//     return LocationModel(
//       locationName: City.fromJson(json['locationName']),
//     );
//   }
// }
