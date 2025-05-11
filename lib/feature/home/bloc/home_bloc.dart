import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/home/repository/home_repository.dart';

import '../model/inventory_item_view.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
    final HomeRepository _repository;

  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<HomeStarted>((event, emit) async {
      try {
        emit(HomeInitial());
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
        emit(HomeLoaded(udpateList));
      } on Exception catch (e) {
        emit(HomeError(e));
      }
    });

    on<HomeItemUdate>((event, emit) async {
      try {
        final updatedItem = await _repository.updateItem(event._inventoryItem);

        emit(HomeLoaded(updatedItem)); 
      } on Exception catch (e) {
        emit(HomeError(e));
      }
    });
  }

    @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeItemUdate) {
      try {
        // Получаем обновленный список объектов из репозитория
        final updatedList = await _repository.updateItem(event._inventoryItem);

        emit(HomeLoaded(updatedList)); 
      } on Exception catch (e) {
        emit(HomeError(e)); 
      }
    }
  }

}
