import '../../../model/technique_details_model.dart';

class ScannerRepository {
  Future<TechniqueDetails> vfetchTechniqueDetails(String qrCode) async {
   await Future.delayed(Duration(seconds: 1));
    return TechniqueDetails(
      name: 'iPhone 13',
      brand: 'Apple',
      totalQuantity: 25,
      workingQuantity: 20,
      brokenQuantity: 5,
    );
  }
}
