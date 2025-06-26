import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/filter/bloc/filters/repository/filters_repository.dart';
import 'package:sound_level_meter/feature/home/filter/model/inventory_filters_model.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final FiltersRepository _repository;


  FiltersBloc(this._repository) : super(const FiltersInitial()) {
    on<FiltersStarted>((event, emit) async {
      emit(const FiltersInitial());

      try {
        final locations = await _repository.getLocations();
        final users = await _repository.getUsers();
        final types = await _repository.getTypes();
        final brands = await _repository.getBrands();

        final initialFilter = InventoryFilter(
          dataSort: DataTypeSorted.newest,
        );

        emit(FiltersLoaded(
          filter: initialFilter,
          locations: locations,
          users: users,
          types: types,
          brands: brands,
               filteredWarehouses: [],

        ));
      } catch (e) {
        emit(FiltersError(e));
      }
    });

    on<FiltersAplay>((event, emit) async {
      try {
        await _repository.saveFilter(event.filter);

        final locations = await _repository.getLocations();
        final users = await _repository.getUsers();
        final types = await _repository.getTypes();
        final brands = await _repository.getBrands();

        emit(FiltersLoaded(
          filter: event.filter,
          locations: locations,
          users: users,
          types: types,
          brands: brands, 
          filteredWarehouses: [],
        ));
      } catch (e) {
        emit(FiltersError(e));
      }
    });

    on<FiltersDecline>((event, emit) async {
      try {
        final defaultFilter = InventoryFilter(dataSort: DataTypeSorted.newest);
        final locations = await _repository.getLocations();
        final users = await _repository.getUsers();
        final types = await _repository.getTypes();
        final brands = await _repository.getBrands();

        emit(FiltersLoaded(
          filter: defaultFilter,
          locations: locations,
          users: users,
          types: types,
          brands: brands,
               filteredWarehouses: [],
        ));
      } catch (e) {
        emit(FiltersError(e));
      }
    });
  }
}

