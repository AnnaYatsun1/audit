import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/edite/bloc/edite/repository/edite_repository.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc(this._repository) : super(const EditInitial()) {
    on<EditStarted>((event, emit) async {
      emit(EditInitial());
      try {
        final updateModel = await _repository.loadItemById(event.id);
        emit(EditLoaded(updateModel));
      } on Exception catch (e) {
        emit(EditError(e));
      }
    });

        on<EditApplay>((event, emit) async {
      // emit(EditInitial());
      try {
        final updateModel = await _repository.uptate(event.updateModel);
        emit(EditLoaded(updateModel));
      } on Exception catch (e) {
        emit(EditError(e));
      }
    });
  }

  final EditeRepository _repository;
}
