import 'package:sound_level_meter/feature/location/model/location_model.dart';

class InventoryItemView {
  final String id;
  final String name;
  final String brand;
  final int total;
  final int working;
  final int broken;
  final String? barcode;
  final int usingQuantity;
  final Warehouse? warehouse;

  InventoryItemView({
    required this.id,
    required this.name,
    required this.brand,
    required this.total,
    required this.working,
    required this.broken,
    required this.usingQuantity,
    this.barcode,
    this.warehouse,
  });
  factory InventoryItemView.fromJson(Map<String, dynamic> json) {
    return InventoryItemView(
      id: json['id'],
      warehouse: json['warehouse'],
      name: json['name'],
      brand: json['brand'],
      total: json['total'],
      working: json['working'],
      broken: json['broken'],
      barcode: json['barcode'],
      usingQuantity: json['usingQuantity'],
    );
  }
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'brand': brand,
  //     'totalQuantity': totalQuantity,
  //     'workingQuantity': workingQuantity,
  //     'brokenQuantity': brokenQuantity,
  //   };
  // }
}
