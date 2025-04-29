import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/home/repository/home_repository.dart';

import '../model/technique_list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<HomeStarted>((event, emit) async {
      try {
        emit(HomeLoading());
        final techniqueList = await _repository.loadTechnickList();
        emit(HomeLoaded(techniqueList));
      } on Exception catch (e) {
        emit(HomeError(e));
      }
    });
    on<HomeItemDeleted>((event, emit) async {
      try {
        final udpateList = await _repository.deleteItem(event.index);
        emit(HomeLoaded(udpateList));
      } on Exception catch (e) {
        emit(HomeError(e));
      }
    });
    on<HomeFiltersApplied>((event, emit) async {
      try {
        final udpateList = await _repository.applayFilters();
        // TODO: надо пробросить примененные фильтры в главныйэкран 
        emit(HomeLoaded(udpateList));
      } on Exception catch (e) {
        emit(HomeError(e));
      }
    });
  }

  final HomeRepository _repository;
}
