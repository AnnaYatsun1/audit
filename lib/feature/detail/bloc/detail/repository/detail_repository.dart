import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/location/model/location_model.dart';

class DetailRepository {
  final List<InventoryItemView> items;

  DetailRepository(this.items);

  Future<InventoryItemDetails> loadItemById(String id) async {
    final found = items.firstWhere((item) => item.id == id);
    // запрос
    return InventoryItemDetails(
      id: found.id,
      warehouse: found.warehouse!,
      name: found.name,
      brand: found.brand,
      description: 'Mock description',
      type: 'Phone',
      workingQuantity: found.working,
      brokenQuantity: found.broken,
      serialNumber: 'SN-${found.id}',
      totalQuantity: found.total,
      usedQuantity: 10,
      createdBy: 'Hanna',
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
      createdBy: 'Hanna',
      createdAt: DateTime.now(),
    );
  }
Future<InventoryItemDetails> deliveryItem(DeliveryItemModel model) async {
final found = items.firstWhere((item) => item.id == model.id);
   return InventoryItemDetails(
      id: found.id,
      warehouse: model.toLocation.locationName.warehouses.first,
      name: found.name,
      brand: found.brand,
      description: 'Mock description',
      type: 'Phone',
      workingQuantity: found.working,
      brokenQuantity: found.broken,
      serialNumber: 'SN-${found.id}',
      totalQuantity: found.total,
      usedQuantity: 10,
      createdBy: 'Hanna',
      createdAt: DateTime.now(),
    );
}

}
