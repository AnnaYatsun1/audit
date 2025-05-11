import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';

class HomeRepository {
  List<InventoryItemView> items = [
    InventoryItemView(
      id: '1',
      name: 'iPhone 13',
      brand: 'Apple',
      total: 25,
      working: 20,
      broken: 5, 
      usingQuantity: 5,
    ),
    InventoryItemView(
      id: '2',
      name: 'Samsung S22',
      brand: 'Samsung',
      total: 30,
      working: 28,
      broken: 2,
      usingQuantity: 5,
    ),
    InventoryItemView(
      id: '3',
      name: 'Google Pixel 7',
      brand: 'Google',
      total: 15,
      working: 12,
      broken: 3,
      usingQuantity: 5,
    ),
    InventoryItemView(
      id: '4',
      name: 'iPhone 16',
      brand: 'Apple',
      total: 5,
      working: 2,
      broken: 3,
       usingQuantity: 5,
    )
  ];

  Future<List<InventoryItemView>> loadTechnickList() async {
    return items;
    // return items.map((item) => TechniqueList.fromJson(item)).toList();
  }

  Future<List<InventoryItemView>> deleteItem(int id) async {
    items.removeAt(id);
    return items;
    // .map((item) => TechniqueList.fromJson(item)).toList();
  }

  applayFilters() async {}
  Future<List<InventoryItemView>> updateItem(InventoryItemView updatedItem) async {
    final index = items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      items[index] = updatedItem;
    }
    return items;
  }
}
