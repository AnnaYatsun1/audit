import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';

class EditeRepository {
  final List<InventoryItemView> items;

  EditeRepository(this.items);

  Future<InventoryItemEdit> loadItemById(String id) async {
    final found = items.firstWhere((item) => item.id == id);
    InventoryBrand brandEnum = found.brand.toEnum(InventoryBrand.values);
    InventoryType typeEnum = found.brand.toEnum(InventoryType.values);

    // запрос
    return InventoryItemEdit(
       
      id: found.id,
     
      name: found.name,
      brand: brandEnum,
      description: 'Mock description',
      type: typeEnum,
      workingCount: found.working,
      brokenCount: found.broken,
      serialNumber: 'SN-${found.id}',
      
    );
  }

  Future<InventoryItemEdit> uptate(InventoryItemEdit item) async {
    return item;
  }
}

extension StringToEnum on String {
  T toEnum<T>(List<T> values) {
    return values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == this.toLowerCase(),
      orElse: () => values
          .first, // Возвращаем первый элемент по умолчанию, если ничего не найдено
    );
  }
}
