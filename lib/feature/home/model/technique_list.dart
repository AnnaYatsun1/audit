

class TechniqueList {
  final String name;
  final String brand;
  final int totalQuantity;
  final int workingQuantity;
  final int brokenQuantity;
  // final int usingQuantity;

  TechniqueList({
    required this.name, 
    required this.brand, 
    required this.totalQuantity, 
    required this.workingQuantity, 
    required this.brokenQuantity,
    // required this.usingQuantity
    });

  factory TechniqueList.fromJson(Map<String, dynamic> json) {
    return TechniqueList(
      name: json['name'],
      brand: json['brand'],
      totalQuantity: json['totalQuantity'],
      workingQuantity: json['workingQuantity'],
      brokenQuantity: json['brokenQuantity'],
      // usingQuantity: json['usingQuantity'],
    );
  }
}
