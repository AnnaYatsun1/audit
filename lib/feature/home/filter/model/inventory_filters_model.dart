

import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

class InventoryFilter {
  final Warehouse? location;
  final User? responsible;
  final ItemStatus? status;
  final DataTypeSorted? dataSort;
    final InventoryType? type;
  final InventoryBrand? brand;

  InventoryFilter({
    this.location,
    this.responsible,
    this.status,
    this.type,
    this.brand,
     this.dataSort,
  });

    InventoryFilter copyWith({
    Warehouse? location,
    User? responsible,
    ItemStatus? status,
    DataTypeSorted? dataSort,
        final InventoryType? type,
  final InventoryBrand? brand,
  }) {
    return InventoryFilter(
      location: location ?? this.location,
      responsible: responsible ?? this.responsible,
      status: status ?? this.status,
      dataSort: dataSort ?? this.dataSort,
      type: type ?? this.type,
      brand:  brand ?? this.brand
    );

  }

}