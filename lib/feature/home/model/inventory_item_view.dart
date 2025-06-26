import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/model/dto_model/inventory_item_dto.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

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
}
//   factory InventoryItemView.fromJson(Map<String, dynamic> json) {
//     return InventoryItemView(
//       id: json['id'],
//       warehouse: json['warehouse'],
//       name: json['name'],
//       brand: json['brand'],
//       total: json['total'],
//       working: json['working'],
//       broken: json['broken'],
//       barcode: json['barcode'],
//       usingQuantity: json['usingQuantity'],
//     );
//   }

//     factory InventoryItemView.fromDTO(InventoryItemDTO dto) {
//     return InventoryItemView(
//       id: dto.id,
//       name: dto.name,
//       brand: InventoryBrand.values.firstWhere(
//         (e) => e.name.toLowerCase() == dto.brand.toLowerCase(),
//         orElse: () => InventoryBrand.Apple, // default fallback
//       ),
//       type: InventoryType.values.firstWhere(
//         (e) => e.name.toLowerCase() == dto.type.toLowerCase(),
//         orElse: () => InventoryType.non,
//       ),
//       serialNumber: dto.serialNumber,
//       imagePath: dto.imagePath,
//       description: dto.description,
//       totalQuantity: dto.total,
//       workingQuantity: dto.working,
//       brokenQuantity: dto.broken,
//       usedQuantity: dto.used,
//       purchaseDate: dto.purchaseDate != null
//           ? DateTime.tryParse(dto.purchaseDate!)
//           : null,
//       cost: dto.cost,
//       warranty:
//           dto.warranty != null ? Warranty.fromDTO(dto.warranty!) : null,
//       manufacturer: dto.manufacturer,
//       warehouse:
//           dto.warehouse != null ? Warehouse.fromDTO(dto.warehouse!) : null,
//     );
//   }

//   /// 📤 Маппер в DTO
//   InventoryItemDTO toDTO() {
//     return InventoryItemDTO(
//       id: id,
//       name: name,
//       brand: brand.name,
//       type: type.name,
//       serialNumber: serialNumber,
//       imagePath: imagePath,
//       description: description,
//       total: totalQuantity,
//       working: workingQuantity,
//       broken: brokenQuantity,
//       used: usedQuantity,
//       purchaseDate: purchaseDate?.toIso8601String(),
//       cost: cost,
//       warranty: warranty?.toDTO(),
//       manufacturer: manufacturer,
//       warehouse: warehouse?.toDTO(),
//     );
//   }
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'name': name,
//   //     'brand': brand,
//   //     'totalQuantity': totalQuantity,
//   //     'workingQuantity': workingQuantity,
//   //     'brokenQuantity': brokenQuantity,
//   //   };
//   // }
// }
