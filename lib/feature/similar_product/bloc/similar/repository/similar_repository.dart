import 'package:sound_level_meter/feature/similar_product/model/similar_inventory_item.dart';

class SimilarRepository {
  List<SimilarInventoryItem> items = [
    SimilarInventoryItem(
      id: '1',
      name: 'iPhone 13',
      brand: 'Apple',
      total: 25,
      working: 20,
      broken: 5, 
    ),
    SimilarInventoryItem(
      id: '2',  
      name: 'Samsung S22',
      brand: 'Samsung',
      total: 30,
      working: 28,
      broken: 2,
    ),
    SimilarInventoryItem(
      id: '3',
      name: 'iPhone 15',
      brand: 'Apple',
      total: 15,
      working: 12,
      broken: 3,
    ),
    SimilarInventoryItem(
      id: '4',
      name: 'iPhone 16',
      brand: 'Apple',
      total: 5,
      working: 2,
      broken: 3,
    )
  ];

  Future<List<SimilarInventoryItem>> loadSimilarItems(String brand) async {
    //TODO: запрос на бек 
    return items;
  }
}
