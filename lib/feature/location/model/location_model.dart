import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';

class InventoryItemForLocation {
  final InventoryType type;
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
          InventoryType.values.firstWhere((e) => e.toString() == json['type']),
      quantity: json['quantity'],
    );
  }
}

// Модель склада
class Warehouse {
  final String id;
  final String name;
  final List<InventoryItemForLocation>
      inventoryItems; // Список товаров с количеством на складе

  Warehouse({
    required this.id,
    required this.name,
    required this.inventoryItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inventoryItems': inventoryItems.map((item) => item.toJson()).toList(),
    };
  }

  // Создание модели из JSON
  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'],
      name: json['name'],
      inventoryItems: (json['inventoryItems'] as List)
          .map((item) => InventoryItemForLocation.fromJson(item))
          .toList(),
    );
  }
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

class LocationModel {
  final City locationName;

  LocationModel({
    required this.locationName,
  });
  Map<String, dynamic> toJson() {
    return {
      'locationName': locationName.toJson(),
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationName: City.fromJson(json['locationName']),
    );
  }
}
