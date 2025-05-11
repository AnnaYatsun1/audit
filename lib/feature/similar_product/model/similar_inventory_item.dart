class SimilarInventoryItem {
  final String id;
  final String name;
  final String brand;
  final int total;
  final int working;
  final int broken;
  final String? barcode;
  // final int usingQuantity;

  SimilarInventoryItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.total,
    required this.working,
    required this.broken,
    this.barcode,
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
    );
  }
}
