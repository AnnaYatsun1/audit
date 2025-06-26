import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/filter/model/inventory_filters_model.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/new_type/view.dart';

class FiltersRepository {

   Future<List<Warehouse>> getLocations() async {
   return [
  
          Warehouse(
            id: '1',
            name: 'Склад 1',
            cityNameCode: "111111",
            inventoryItems: [
              InventoryItemForLocation(type: Catogory(id: "1", name: "Laptop"), quantity: 3),
              InventoryItemForLocation(type: Catogory(id: "1", name: "Laptop"), quantity: 5),
            ],
          ),
      
 
        Warehouse(
          id: '1',
          name: 'Склад 4',
           cityNameCode: "111111",
          inventoryItems: [
            InventoryItemForLocation(type: Catogory(id: "1", name: "Phone"), quantity: 3),
            InventoryItemForLocation(type: Catogory(id: "1", name: "Phone"), quantity: 12),
          ],
        ),
  
 
        Warehouse(
          id: '1',
          name: 'Склад 5',
           cityNameCode: "111111",
          inventoryItems: [
            InventoryItemForLocation(type:Catogory(id: "1", name: "Laptop"), quantity: 8),
            InventoryItemForLocation(type: Catogory(id: "1", name: "Laptop"), quantity: 25),
          ],
        ),
      ];
  
  }

  Future<List<UserSearchItem>> getUsers() async {
    return [
      UserSearchItem(id: '1', name: 'Анна Іванова'),
      UserSearchItem(id: '2', name: 'Олег Петров'),
    ];
  }

  Future<List<InventoryType>> getTypes() async {
    return InventoryType.values;
  }

  Future<List<InventoryBrand>> getBrands() async {
    return InventoryBrand.values;
  }


  Future<void> saveFilter(InventoryFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
 
}
