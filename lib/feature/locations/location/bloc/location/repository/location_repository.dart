import 'package:flutter/foundation.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

class LocationRepository {
  List<Warehouse> items = [
    // LocationModel(
    //   locationName: City(
    //     cityName: 'Lviv',
    //     warehouses: [
    Warehouse(
      id: '1',
      name: 'Склад 1',
      responsible: User('1', 'Vasay', null, TypeWorker.admin),
      cityNameCode: "111111",
      inventoryItems: [
        // InventoryItemForLocation(type: InventoryType.phone, quantity: 3),
        // InventoryItemForLocation(type: InventoryType.laptop, quantity: 5),
      ],
    ),
    // ],
    // ),
    //  ),
    // LocationModel(
    //     locationName: City(
    //   cityName: 'Kyiv',
    //   warehouses: [
    Warehouse(
      id: '1',
      name: 'Склад 4',
      responsible: User('2', 'Vasay Pipkin', null, TypeWorker.admin),
      cityNameCode: "111111",
      inventoryItems: [
        // InventoryItemForLocation(type: InventoryType.phone, quantity: 3),
        // InventoryItemForLocation(type: InventoryType.laptop, quantity: 12),
      ],
    ),
    //   ],
    // )),
    // LocationModel(
    //     locationName: City(
    //   cityName: 'Kyiv',
    //   warehouses: [
    Warehouse(
      id: '1',
      name: 'Склад 5',
      cityNameCode: "111111",
      responsible: User('2', 'Ivan', null, TypeWorker.admin),
      inventoryItems: [
        // InventoryItemForLocation(type: InventoryType.phone, quantity: 8),
        // InventoryItemForLocation(type: InventoryType.laptop, quantity: 25),
      ],
    ),
  ];

  //   ))
  // ];

  Future<List<Warehouse>> getWarehousesByCategory(Category type) async {
    return items.where((warehouse) {
      return warehouse.inventoryItems.any((item) => item.type == type);
    }).toList();
  }
}
