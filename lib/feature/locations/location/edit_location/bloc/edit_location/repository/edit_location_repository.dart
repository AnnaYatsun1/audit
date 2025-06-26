import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

// class EditLocationRepository {
//   final List<Warehouse> location;

//   EditLocationRepository(this.location);

//   Future<Warehouse> loadWarehouse(Warehouse warehouse) async {
//     // final location = this.location.firstWhere(
//     //     (item) =>
//     //         item.locationName.warehouses.any((wh) => wh.id == warehouse.id),
//     //     orElse: () {
//     //   throw StateError(
//     //       '❌ Не найден location для warehouse.id = ${warehouse.id}');
//     // });

//     return Warehouse(id: location.i)
//   }

// //     Future<Warehouse> updateLocation(Warehouse editedWarehouse) async {
// //     // Здесь ты будешь обновлять склад в репозитории или моковых данных
// //     final location = this.location.firstWhere((item) =>
// //         item.locationName.warehouses.any((wh) => wh.id == editedWarehouse.warehouse.id),   orElse: () {
// //       throw StateError('❌ Не найден location для warehouse.id = ${editedWarehouse.locationName}');
// //     });

// //     // Обновим склад в локации
// //     final updatedLocation = location.locationName.warehouses
// //         .map((warehouse) {
// //           if (warehouse.id == editedWarehouse.warehouse.id) {
// //             return editedWarehouse.warehouse;
// //           }
// //           return warehouse;
// //         }).toList();

// //     // Возвращаем обновленную модель
// //     return Warehouse(warehouse, locationName: location.locationName);
// //   }
// }

// //   // class EditeWarehouse extends Warehouse {
// //   //   final Warehouse warehouse;
// //   //   EditeWarehouse(this.warehouse, {required super.locationName});
// //   // }


class EditLocationRepository {
  final List<Warehouse> warehouses;
 

  EditLocationRepository(this.warehouses);

  // Получаем склад по ID (как бы "загружаем" его)
  Future<Warehouse> loadWarehouse(String warehouseId) async {
    final warehouse = warehouses.firstWhere(
      (wh) => wh.id == warehouseId,
      orElse: () => throw StateError('❌ Склад не найден по id = $warehouseId'),
    );
    return warehouse;
  }

  // Обновляем склад
  Future<Warehouse> updateWarehouse(Warehouse updatedWarehouse) async {
    final index = warehouses.indexWhere((wh) => wh.id == updatedWarehouse.id);

    if (index == -1) {
      throw StateError('❌ Невозможно обновить — склад не найден по id = ${updatedWarehouse.id}');
    }

    warehouses[index] = updatedWarehouse;

    return updatedWarehouse;
  }

}
