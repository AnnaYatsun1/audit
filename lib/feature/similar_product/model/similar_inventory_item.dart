import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

class SimilarInventoryItem {
  final String id;
  final String name;
  final String brand;
  final int total;
  final int working;
  final int broken;
  final String? barcode;
  final Warehouse? warehouse;
  // final int usingQuantity;

  SimilarInventoryItem({
    required this.id,
    required this.name,
    required this.brand,
    // required this.warehouse,
    required this.total,
    required this.working,
    required this.broken,
    this.barcode,
    this.warehouse
  });
  factory SimilarInventoryItem.fromJson(Map<String, dynamic> json) {
    return SimilarInventoryItem(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      total: json['total'],
      working: json['working'],
      broken: json['broken'],
      barcode: json['barcode'],
      warehouse: json['warhouse'],
    );
  }

  InventoryItemView toInventoryItemView() {
    return InventoryItemView(
      id: id,
      name: name,
      brand: brand,
      total: total,
      working: working,
      broken: broken,
      usingQuantity: total - (working + broken),
      warehouse: warehouse, // Можно установить null или передать нужное значение
    );
  }
}
