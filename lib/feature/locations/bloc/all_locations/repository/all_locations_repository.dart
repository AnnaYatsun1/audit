import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';


// abstract class LocationRepository {
//   Future<List<Warehouse>> getAllWarehouses();
//   Future<void> deleteWarehouse(String id);
// }
class AllLocationsRepository  {

    List<Warehouse> warehouses = [
    Warehouse(id: '1', name: 'Склад 1', cityNameCode: 'Lviv', inventoryItems: []),
    Warehouse(id: '2', name: 'Склад 4', cityNameCode: 'Kyiv', inventoryItems: []),
    Warehouse(id: '3', name: 'Склад 5', cityNameCode: 'Kyiv', inventoryItems: []),
  ];

  @override
  Future<List<Warehouse>> getAllWarehouses() async {
    return Future.value(warehouses);
  }

  @override
  Future<void> deleteWarehouse(String id) async {
    warehouses.removeWhere((e) => e.id == id);
  }
}

  // final List<Warehouse> _warehouses = [
  //   Warehouse(
  //     id: '1',
  //     name: 'Склад 1',
  //     inventoryItems: [
  //       InventoryItemForLocation(type: Catogory(id: "1", name: "Laptop"), quantity: 3),
  //       InventoryItemForLocation(type: InventoryType.laptop, quantity: 5),
  //     ],
  //   ),
  //   Warehouse(
  //     id: '2',
  //     name: 'Склад 2',
  //     inventoryItems: [
  //       InventoryItemForLocation(type: InventoryType.drone, quantity: 10),
  //     ],
  //   ),
  // ];

  // Future<List<Warehouse>> loadWarehouses() async {
  //   return List<Warehouse>.from(_warehouses);
  // }

  // Future<void> addWarehouse(Warehouse warehouse) async {
  //   _warehouses.add(warehouse);
  // }

  // Future<void> deleteWarehouse(Warehouse warehouse) async {
  //   _warehouses.removeWhere((w) => w.id == warehouse.id);
  // }

  // Future<void> updateWarehouse(Warehouse old, Warehouse updated) async {
  //   final index = _warehouses.indexWhere((w) => w.id == old.id);
  //   if (index != -1) {
  //     _warehouses[index] = updated;
  //   }
  // }
// }

