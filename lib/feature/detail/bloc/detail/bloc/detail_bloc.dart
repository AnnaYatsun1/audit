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
        emit(DetailLoaded(detailModel));
      } on Exception catch (e) {
        emit(DetailError(e));
      }
    });
      on<MoveItem>((event, emit) async {
      emit(DetailInitial());
      try {
        final detailModel = await _repository.moveItem(event.transferModel);
        emit(DetailLoaded(detailModel));
      } on Exception catch (e) {
        emit(DetailError(e));
      }
    });

      on<DeliveryOfGoods>((event, emit) async {
      emit(DetailInitial());
      try {
        final detailModel = await _repository.deliveryItem(event.deliveryModel);
        emit(DetailLoaded(detailModel));
      } on Exception catch (e) {
        emit(DetailError(e));
      }
    });
  }

  final DetailRepository _repository;
}
