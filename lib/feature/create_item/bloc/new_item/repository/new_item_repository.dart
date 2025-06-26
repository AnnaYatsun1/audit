import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';

class NewItemRepository {
   Future<InventoryItemCreate> createInventoryItem(
      InventoryItemCreate newItem) async {
    return newItem;
  }

    Future<List<WarehouseSearchItem>> getWarehouseSearchItems() async {
       await Future.delayed(Duration(milliseconds: 500));
    // Надо будет кешироватл 
     List<WarehouseSearchItem> list = [
    WarehouseSearchItem(
      warehouseId: '1',
      warehouseName: 'Главный склад',
      cityName: 'Киев',
    ),
    WarehouseSearchItem(
      warehouseId: '2',
      warehouseName: 'Резервный склад',
      cityName: 'Львов',
    ),
    WarehouseSearchItem(
      warehouseId: '3',
      warehouseName: 'Ремонтный центр',
      cityName: 'Одесса',
    ),
    WarehouseSearchItem(
      warehouseId: '4',
      warehouseName: 'Склад 2-й этаж',
      cityName: 'Киев',
    ),
    WarehouseSearchItem(
      warehouseId: '5',
      warehouseName: 'Удаленный склад',
      cityName: 'Днепр',
    ),
  ];
    return list;
  }
}

