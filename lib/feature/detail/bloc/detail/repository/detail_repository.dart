import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

class DetailRepository {
  final List<InventoryItemView> items;

  DetailRepository(this.items);

  Future<InventoryItemDetails> loadItemById(String id) async {
    final found = items.firstWhere((item) => item.id == id);
    final defaultModel = Warehouse(id: "1", name: "name", inventoryItems: [], cityNameCode: '1111');
    // запрос
    return InventoryItemDetails(
      id: found.id,
      warehouse: found.warehouse ?? defaultModel,
      name: found.name,
      brand: found.brand,
      description: 'Mock description',
      type: 'Phone',
      workingQuantity: found.working,
      brokenQuantity: found.broken,
      serialNumber: 'SN-${found.id}',
      totalQuantity: found.total,
      usedQuantity: 10,
      createdBy: User("1", "Hanna", "avatar", TypeWorker.admin),
      createdAt: DateTime.now(),
    );
  }

  Future<InventoryItemDetails> moveItem(ItemTransferModel model) async {
    final found = items.firstWhere((item) => item.id == model.id);
    // found.usingQuantity -= model.warehouse.inventoryItems.first.quantity;
    // found. -= model.quantity;
    return InventoryItemDetails(
      id: found.id,
      warehouse: model.warehouse,
      name: found.name,
      brand: found.brand,
      description: 'Mock description',
      type: 'Phone',
      workingQuantity: found.working,
      brokenQuantity: found.broken,
      serialNumber: 'SN-${found.id}',
      totalQuantity: found.total,
      usedQuantity: 10,
      createdBy: User("1", "Hanna", "avatar", TypeWorker.admin),
      createdAt: DateTime.now(),
    );
  }

  Future<InventoryItemDetails> deliveryItem(DeliveryItemModel model) async {
    final found = items.firstWhere((item) => item.id == model.id);
    return InventoryItemDetails(
      id: found.id,
      warehouse: model.toLocation,
      name: found.name,
      brand: found.brand,
      description: 'Mock description',
      type: 'Phone',
      workingQuantity: found.working,
      brokenQuantity: found.broken,
      serialNumber: 'SN-${found.id}',
      totalQuantity: found.total,
      usedQuantity: 10,
      createdBy: User("1", "Hanna", "avatar", TypeWorker.admin),
      createdAt: DateTime.now(),
    );
  }

  Future<List<WarehouseSearchItem>> getWarehouseSearchItems() async {
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

  Future<List<UserSearchItem>> getReceiverSearchItems() async {
  // await Future.delayed(Duration(milliseconds: 500));

  return [
    UserSearchItem(id: 'u1', name: 'Анна Иванова'),
    UserSearchItem(id: 'u1', name: 'Анна Иванова1'),
    UserSearchItem(id: 'u1', name: 'Анна Иванова2'),
    UserSearchItem(id: 'u2', name: 'Иван Петров'),
    UserSearchItem(id: 'u3', name: 'Ольга Смирнова'),
    UserSearchItem(id: 'u4', name: 'Сергей Сергеев'),
  ];
}
}

