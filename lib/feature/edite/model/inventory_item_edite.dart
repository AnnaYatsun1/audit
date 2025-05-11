import 'package:sound_level_meter/feature/location/model/location_model.dart';

enum InventoryBrand {
  Apple,
  Samsung,
  Nokia,
  Saomi,
  Brandbary
}

enum InventoryType {
  phone,
  tablet,
  laptop,
}
class InventoryItemCreate {
  final String name;
  final String? description;
  final InventoryBrand brand;
  final InventoryType type;
  final int workingCount;
  final int brokenCount;
  final String? serialNumber;
  final String? photoPath;

  InventoryItemCreate({
    required this.name,
    required this.description,
    required this.brand,
    required this.type,
    required this.workingCount,
    required this.brokenCount,
    this.serialNumber,
    this.photoPath,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'brand': brand,
        'type': type,
        'workingCount': workingCount,
        'brokenCount': brokenCount,
        'serialNumber': serialNumber,
        'photoPath': photoPath,
      };
}

class InventoryItemEdit extends InventoryItemCreate {
  final String id;
  InventoryItemEdit({
    required this.id,
    required super.name,
    required super.description,
    required super.brand,
    required super.type,
    required super.workingCount,
    required super.brokenCount,
    super.serialNumber,
    super.photoPath,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        ...super.toJson(),
      };

  factory InventoryItemEdit.fromDetails(InventoryItemDetails details) {
        InventoryBrand brandEnum = InventoryBrand.values.firstWhere(
      (e) => e.toString().split('.').last == details.brand.toUpperCase(),
      orElse: () => InventoryBrand.Apple,
    );
            InventoryType tyeEnum = InventoryType.values.firstWhere(
      (e) => e.toString().split('.').last == details.brand.toUpperCase(),
      orElse: () => InventoryType.phone, 
    );
    return InventoryItemEdit(
      id: details.id,
      name: details.name,
      brand: brandEnum,
      type:tyeEnum,
      description: details.description,
      workingCount: details.workingQuantity,
      brokenCount: details.brokenQuantity,
      serialNumber: details.serialNumber,
      photoPath: details.imagePath,
    );
  }
}

class InventoryItemDetails {
  final String id;
  final String name;
  final String brand;
  final String type;
  final String? imagePath;
  final String? serialNumber;
  final String? barcode;
  final String? description;
  final int totalQuantity;
  final int workingQuantity;
  final int brokenQuantity;
  final int usedQuantity;
  final String createdBy;
  final DateTime createdAt;
  final Warehouse warehouse;
  // TODO: заменить
  final List<String> locations;
  final List<String> history;
  final List<String> similarItemsIds;

  InventoryItemDetails({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.warehouse,
    this.imagePath,
    this.serialNumber,
    this.barcode,
    this.description,
    required this.totalQuantity,
    required this.workingQuantity,
    required this.brokenQuantity,
    required this.usedQuantity,
    required this.createdBy,
    required this.createdAt,
    this.locations = const [],
    this.history = const [],
    this.similarItemsIds = const [],
  });
}
