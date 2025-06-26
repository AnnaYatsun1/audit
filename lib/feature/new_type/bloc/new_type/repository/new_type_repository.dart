import '../../../view.dart';

class NewTypeRepository {
  List<Brand> brands = [
    Brand('1', 'Apple'),
    Brand('2', 'Samsung'),
    Brand('3', 'Saomi'),
    Brand('4', 'Nokia'),
    Brand('5', 'Philips'),
  ];
  List<Catogory> types = [
    Catogory(id: '1', name: ''),
    Catogory(id: '2', name: 'Drone'),
    Catogory(id: '3', name: 'Monitor'),
    Catogory(id: '4', name: 'Nokia'),
    Catogory(id: '5', name: 'Laptop'),
  ];
  // new Type
  Future<List<Brand>> loadBrand() async => List<Brand>.from(brands);

  Future<List<Catogory>> loadType() async => List<Catogory>.from(types);

  Future<void> addBrand(Brand brand) async {
    brands.add(brand);
  }

  Future<void> deleteBrand(Brand brand) async =>
      brands.removeWhere((b) => b.id == brand.id);

  Future<void> addType(Catogory type) async => types.add(type);
  Future<void> deleteType(Catogory type) async =>
      types.removeWhere((t) => t.id == type.id);

  Future<void> editBrand(Brand oldItem, Brand newItem) async {
    final index = brands.indexWhere((b) => b.id == oldItem.id);
    print('Редактируем Brand с id=${oldItem.id} → index=$index');
    if (index != -1) {
      brands[index] = newItem;
    }
  }

  Future<void> editType(Catogory oldItem, Catogory newItem) async {
    final index = types.indexWhere((t) => t.id == oldItem.id);
    if (index != -1) {
      types[index] = newItem;
    }
  }
}
