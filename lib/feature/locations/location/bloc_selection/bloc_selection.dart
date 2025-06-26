

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

// EVENTS
abstract class WarehouseSelectionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectWarehouse extends WarehouseSelectionEvent {
  final Warehouse warehouse;

  SelectWarehouse(this.warehouse);

  @override
  List<Object?> get props => [warehouse];
}

// STATES
class WarehouseSelectionState extends Equatable {
  final Warehouse? selectedWarehouse;

  const WarehouseSelectionState({this.selectedWarehouse});

  @override
  List<Object?> get props => [selectedWarehouse ?? 'null'];
}

// BLOC
class WarehouseSelectionBloc extends Bloc<WarehouseSelectionEvent, WarehouseSelectionState> {
  WarehouseSelectionBloc(Warehouse defaultWarehouse)
      : super(WarehouseSelectionState(selectedWarehouse: defaultWarehouse)) {
    on<SelectWarehouse>((event, emit) {
      emit(WarehouseSelectionState(selectedWarehouse: event.warehouse));
    });
  }
}

