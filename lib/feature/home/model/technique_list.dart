

class TechniqueList {
  final String name;
  final String brand;
  final int totalQuantity;
  final int workingQuantity;
  final int brokenQuantity;

  TechniqueList({
    required this.name, 
    required this.brand, 
    required this.totalQuantity, 
    required this.workingQuantity, 
    required this.brokenQuantity});

  factory TechniqueList.fromJson(Map<String, dynamic> json) {
    return TechniqueList(
      name: json['name'],
      brand: json['brand'],
      totalQuantity: json['totalQuantity'],
      workingQuantity: json['workingQuantity'],
      brokenQuantity: json['brokenQuantity'],
    );
  }
}
