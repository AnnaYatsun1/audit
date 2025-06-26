import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/locations/bloc/all_locations/repository/all_locations_repository.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

part 'all_locations_event.dart';
part 'all_locations_state.dart';

class AllLocationsBloc extends Bloc<AllLocationsEvent, AllLocationsState> {
  final AllLocationsRepository _repository;
  AllLocationsBloc(this._repository) : super(const AllLocationsInitial()) {
    on<AllLocationsStarted>((event, emit) async {
      emit(AllLocationsInitial());
      try {
        final data = await _repository.getAllWarehouses();
        emit(AllLocationLoaded(data));
      } catch (e) {
        emit(LocationsError("Ошибка загрузки: $e"));
      }
    });

    on<DeleteLocation>((event, emit) async {
      if (state is! AllLocationLoaded) return;
      final current = (state as AllLocationLoaded).warehouses;
      // await repository.deleteWarehouse(event.id);
      emit(AllLocationLoaded(
          List.from(current)..removeWhere((w) => w.id == event.id)));
    });
  }
}
