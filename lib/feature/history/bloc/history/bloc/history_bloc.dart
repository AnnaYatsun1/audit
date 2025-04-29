import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/history/bloc/history/repository/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._repository) : super(const HistoryInitial()) {
    on<HistoryStarted>((event, emit) async {
      // TODO: Implement logic here
    });
  }

  final HistoryRepository _repository;
}
