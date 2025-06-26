import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/auth/repository/user_repository.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/locations/location/edit_location/bloc/edit_location/repository/edit_location_repository.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

part 'edit_location_event.dart';
part 'edit_location_state.dart';

class EditLocationBloc extends Bloc<EditLocationEvent, EditLocationState> {
  EditLocationBloc(this._repository, this._userRepository)
      : super(const EditLocationInitial()) {
    on<EditLocationStarted>((event, emit) async {
      emit(EditLocationInitial());
      try {
        final updateLocation =
            await _repository.loadWarehouse(event.warehouse.id);
        final users = await _userRepository.loadUsers();
        emit(EditLocationLoaded(warehouse: updateLocation, users: users));
      } on Exception catch (e) {
        emit(EditLocationError(e));
      }
    });
    on<EditWarehouseUpdated>((event, emit) async {
      final currentState = state;
      if (currentState is! EditLocationLoaded) return;

      try {
        await _repository.updateWarehouse(event.warehouse);
        final users = currentState.users;
        emit(EditLocationLoaded(
          warehouse: event.warehouse,
          users: users,
        ));
      } catch (e) {
        emit(EditLocationError(e));
      }
    });
  }

  final EditLocationRepository _repository;
  final UserRepository _userRepository;
}
