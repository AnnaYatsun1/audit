import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/similar_product/model/similar_inventory_item.dart';

enum InventoryBrand { Apple, Samsung, Nokia, Saomi, Brandbary }

enum InventoryType {
  non,
  phone,
  tablet,
  laptop,
}


class Warranty {
  final String term;  // Термин гарантии
  final String supplier;  // Поставщик гарантии
  final DateTime? startDate;  // Дата начала гарантии
  final DateTime? endDate;  // Дата окончания гарантии
  final String? conditions;  // Условия гарантии (например, ремонт, возврат и т.д.)

  Warranty({
    required this.term,
    required this.supplier,
    this.startDate,
    this.endDate,
    this.conditions,
  });

  Map<String, dynamic> toJson() => {
        'term': term,
        'supplier': supplier,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'conditions': conditions,
      };

  factory Warranty.fromJson(Map<String, dynamic> json) {
    return Warranty(
      term: json['term'],
      supplier: json['supplier'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      conditions: json['conditions'],
    );
  }
}

class InventoryItemCreate {
  final String name;
  final String? description;
  final InventoryBrand? brand;
  final InventoryType? type;
  final int workingCount;
  final int brokenCount;
  final String? serialNumber;
  final String? photoPath;
  final Warehouse? warehouse;
  final String? purchaseDate;
  final double? cost;  // Вартість
  final Warranty? warranty;  // Гарантія
  final String? manufacturer;  

  InventoryItemCreate({
    required this.name,
    required this.description,
    required this.brand,
    required this.type,
    required this.workingCount,
    required this.brokenCount,
    this.serialNumber,
    this.photoPath,
    this.warehouse,
    this.purchaseDate,
    this.cost,
    this.warranty,
    this.manufacturer
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
        'warehouse': warehouse,
        'purchaseDate': purchaseDate,
        'cost': cost,
        'warranty': warranty,
        'manufacturer': manufacturer,
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
      type: tyeEnum,
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
  final User createdBy;
  final DateTime createdAt;
  final Warehouse warehouse;

  final String? purchaseDate;
  final double? cost;
  final Warranty? warranty;
  final String? manufacturer;
  // TODO: заменить
  final List<Warehouse> locations;
  final List<HistoryModel>? history;
  final List<SimilarInventoryItem>? similarItemsIds;

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
    this.purchaseDate,
    this.cost,
    this.warranty,
    this.manufacturer,
    this.locations = const [],
    this.history = const [],
    this.similarItemsIds = const [],
    
  });
}


enum DataTypeSorted {
  newest,
  oldest,
}

extension DataTypeSortedExtension on DataTypeSorted {
  String get label {
    switch (this) {
      case DataTypeSorted.newest:
        return 'Самые новые';
      case DataTypeSorted.oldest:
        return 'Самые старые';
    }
  }
}
