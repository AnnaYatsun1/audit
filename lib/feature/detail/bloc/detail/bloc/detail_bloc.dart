import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/detail/bloc/detail/repository/detail_repository.dart';
import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(this._repository) : super(const DetailInitial()) {
    on<DetailStarted>((event, emit) async {
      emit(DetailInitial());
      try {
        final detailModel = await _repository.loadItemById(event.id);
        final allWarehouses = await _repository.getWarehouseSearchItems();
        final allReceivers = await _repository.getReceiverSearchItems();
        emit(DetailLoaded(
          detailModel: detailModel,
          allWarehouses: allWarehouses,
          allReceivers: allReceivers,
        ));
      } on Exception catch (e) {
        emit(DetailError(e));
      }
    });
    on<MoveItem>((event, emit) async {
      if (state is! DetailLoaded) return;

      final currentState = state as DetailLoaded;
      try {
        final detailModel = await _repository.moveItem(event.transferModel);
        emit(currentState.copyWith(detailModel: detailModel));
      } on Exception catch (e) {
        emit(DetailError(e));
      }
    });

    on<DeliveryOfGoods>((event, emit) async {
      if (state is! DetailLoaded) return;

      final currentState = state as DetailLoaded;
      try {
        final updatedModel =
            await _repository.deliveryItem(event.deliveryModel);
        emit(currentState.copyWith(detailModel: updatedModel));
      } on Exception catch (e) {
        emit(DetailError(e));
      }
    });
    on<DetailWarehouseSearch>(_onWarehouseSearch);
    on<DetailReceiverSearch>(_onResiverSearch);

  on<ClearSearchResults>((event, emit) {
    if (state is DetailLoaded) {
      final currentState = state as DetailLoaded;
      emit(currentState.copyWith(filteredReceivers: [], filteredWarehouses: []));
      // emit(currentState.copyWith(filteredWarehouses: [] )); // Очищаем результаты поиска
    }
  });

  
  }

  Future<void> _onWarehouseSearch(
    DetailWarehouseSearch event,
    Emitter<DetailState> emit,
  ) async {
    if (state is! DetailLoaded) return;

    final currentState = state as DetailLoaded;
    final query = event.query.trim().toLowerCase();

    if (query.length < 2) {
      emit(currentState.copyWith(filteredWarehouses: []));
      return;
    }

    final filtered = currentState.allWarehouses.where((warehouse) {
      return warehouse.warehouseName.toLowerCase().contains(query) ||
          warehouse.cityName.toLowerCase().contains(query);
    }).toList();

    emit(currentState.copyWith(filteredWarehouses: filtered));
  }

  Future<void> _onResiverSearch(
    DetailReceiverSearch event,
    Emitter<DetailState> emit,
  ) async {
    if (state is! DetailLoaded) return;

    final currentState = state as DetailLoaded;
    final query = event.query.trim().toLowerCase();

    if (query.length < 2) {
      emit(currentState.copyWith(filteredReceivers: []));
      return;
    }

    final filtered = currentState.allReceivers.where((receiver) {
      return receiver.name.toLowerCase().contains(query);
    }).toList();
    print("filtered ${filtered}', reciver:'${currentState.allReceivers.first.name}'");
    emit(currentState.copyWith(filteredReceivers: filtered));
  }

  final DetailRepository _repository;
}
