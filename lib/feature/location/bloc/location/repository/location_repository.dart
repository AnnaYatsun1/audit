import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/location/model/location_model.dart';

class LocationRepository {
  List<LocationModel> items = [
    LocationModel(
      locationName: City(
        cityName: 'Lviv',
        warehouses: [
          Warehouse(
            id: '1',
            name: 'Склад 1',
            inventoryItems: [
              InventoryItemForLocation(type: InventoryType.phone, quantity: 3),
              InventoryItemForLocation(type: InventoryType.laptop, quantity: 5),
            ],
          ),
        ],
      ),
    ),
    LocationModel(
        locationName: City(
      cityName: 'Kyiv',
      warehouses: [
        Warehouse(
          id: '1',
          name: 'Склад 4',
          inventoryItems: [
            InventoryItemForLocation(type: InventoryType.phone, quantity: 3),
            InventoryItemForLocation(type: InventoryType.laptop, quantity: 12),
          ],
        ),
      ],
    )),
    LocationModel(
        locationName: City(
      cityName: 'Kyiv',
      warehouses: [
        Warehouse(
          id: '1',
          name: 'Склад 5',
          inventoryItems: [
            InventoryItemForLocation(type: InventoryType.phone, quantity: 8),
            InventoryItemForLocation(type: InventoryType.laptop, quantity: 25),
          ],
        ),
      ],
    ))
  ];

  Future<List<LocationModel>> getLocationsBy(InventoryType type) async {
      return items
        .expand((city) {
          // Для каждого города распаковываем все склады и возвращаем их как новые объекты
          return city.locationName.warehouses
              .where((warehouse) => warehouse.inventoryItems
                  .any((item) => item.type == type)) // Фильтруем по типу товара
              .map((warehouse) {
                return LocationModel(
                  locationName: City(
                    cityName: city.locationName.cityName, // Город остаётся тот же
                    warehouses: [warehouse], // Добавляем только этот склад
                  ),
                );
              });
        })
        .toList(); // Преобразуем результат в список
  }
}