import 'package:flutter/src/foundation/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/locations/location/bloc/location/repository/location_repository.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(this._repository) : super(const LocationInitial()) {
    on<LocationStarted>((event, emit) async {
      emit(LocationInitial());
      try {
        final locationByType = await _repository.getWarehousesByCategory(event.type);
        emit(LocationLoaded(locationByType));
      } on Exception catch (e) {
        emit(LocationError(e));
      }
    });
  }

  final LocationRepository _repository;
}
