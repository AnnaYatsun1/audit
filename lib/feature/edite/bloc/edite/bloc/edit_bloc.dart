import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/home/model/technique_list.dart';
import 'package:sound_level_meter/feature/edite/bloc/edite/repository/edite_repository.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc(this._repository) : super(const EditInitial()) {
    on<EditApplay>((event, emit) async {
      emit(EditLoading());
      final updateModel = _repository.uptate(event.updateModel);
      emit(EditLoaded(updateModel as TechniqueList));
    });
  }

  final EditeRepository _repository;
}
