import 'package:sound_level_meter/feature/home/model/technique_list.dart';

class HomeRepository {
      List<Map<String, dynamic>> items = [
      {
        'name': 'iPhone 13',
        'brand': 'Apple',
        'totalQuantity': 25,
        'workingQuantity': 20,
        'brokenQuantity': 5,
      },
      {
        'name': 'Samsung S22',
        'brand': 'Samsung',
        'totalQuantity': 30,
        'workingQuantity': 28,
        'brokenQuantity': 2,
      },
      {
        'name': 'Google Pixel 7',
        'brand': 'Google',
        'totalQuantity': 15,
        'workingQuantity': 12,
        'brokenQuantity': 3,
      },
      {
        'name': 'iPhone 16',
        'brand': 'Apple',
        'totalQuantity': 5,
        'workingQuantity': 2,
        'brokenQuantity': 3,
      },
    ];

    Future<List<TechniqueList>> loadTechnickList() async {
    return items.map((item) => TechniqueList.fromJson(item)).toList();
    
  }

  Future<List<TechniqueList>> deleteItem(int id) async {
    items.removeAt(id);  
    return items.map((item) => TechniqueList.fromJson(item)).toList();
  }

  applayFilters() async {

  }
}
