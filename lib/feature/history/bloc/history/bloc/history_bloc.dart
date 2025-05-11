import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/history/bloc/history/repository/history_repository.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';


part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._repository) : super(const HistoryInitial()) {
    on<HistoryStarted>((event, emit) async {
       emit(HistoryInitial());
      try {
        final inventoryHistory = await _repository.loadHistoryInformation(event.inventoryId);
        emit(HistoryLoaded(inventoryHistory));
      } on Exception catch (e) {
        emit(HistoryError(e));
      }
    });
  }


  final HistoryRepository _repository;
}
