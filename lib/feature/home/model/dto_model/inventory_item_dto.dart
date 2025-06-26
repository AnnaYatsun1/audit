
class InventoryItemDTO {
  final String id;
  final String name;
  final String brand; // как строка
  final String type;  // как строка
  final String? serialNumber;
  final String? imagePath;
  final String? description;
  final int total;
  final int working;
  final int broken;
  final int used;
  final String? purchaseDate;
  final double? cost;
  final WarrantyDTO? warranty;
  final String? manufacturer;
  final WarehouseDTO? warehouse;

  InventoryItemDTO({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    this.serialNumber,
    this.imagePath,
    this.description,
    required this.total,
    required this.working,
    required this.broken,
    required this.used,
    this.purchaseDate,
    this.cost,
    this.warranty,
    this.manufacturer,
    this.warehouse,
  });

  factory InventoryItemDTO.fromJson(Map<String, dynamic> json) {
    return InventoryItemDTO(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      type: json['type'],
      serialNumber: json['serialNumber'],
      imagePath: json['imagePath'],
      description: json['description'],
      total: json['total'],
      working: json['working'],
      broken: json['broken'],
      used: json['used'],
      purchaseDate: json['purchaseDate'],
      cost: json['cost']?.toDouble(),
      warranty: json['warranty'] != null
          ? WarrantyDTO.fromJson(json['warranty'])
          : null,
      manufacturer: json['manufacturer'],
      warehouse: json['warehouse'] != null
          ? WarehouseDTO.fromJson(json['warehouse'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brand': brand,
        'type': type,
        'serialNumber': serialNumber,
        'imagePath': imagePath,
        'description': description,
        'total': total,
        'working': working,
        'broken': broken,
        'used': used,
        'purchaseDate': purchaseDate,
        'cost': cost,
        'warranty': warranty?.toJson(),
        'manufacturer': manufacturer,
        'warehouse': warehouse?.toJson(),
      };
}


class WarrantyDTO {
  final String term;
  final String supplier;
  final String? startDate; // как строка в ISO
  final String? endDate;
  final String? conditions;

  WarrantyDTO({
    required this.term,
    required this.supplier,
    this.startDate,
    this.endDate,
    this.conditions,
  });

  factory WarrantyDTO.fromJson(Map<String, dynamic> json) {
    return WarrantyDTO(
      term: json['term'],
      supplier: json['supplier'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      conditions: json['conditions'],
    );
  }

  Map<String, dynamic> toJson() => {
        'term': term,
        'supplier': supplier,
        'startDate': startDate,
        'endDate': endDate,
        'conditions': conditions,
      };
}


class WarehouseDTO {
  final String id;
  final String name;
  final String? location; // если нужно

  WarehouseDTO({
    required this.id,
    required this.name,
    this.location,
  });

  factory WarehouseDTO.fromJson(Map<String, dynamic> json) {
    return WarehouseDTO(
      id: json['id'],
      name: json['name'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
      };
}
