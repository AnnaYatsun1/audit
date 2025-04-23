import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/home/repository/home_repository.dart';

import '../model/technique_list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<HomeStarted>((event, emit) async {
      final techniqueList = await _repository.loadTechnickList();
      emit(HomeLoaded(techniqueList));
    });
  }

  final HomeRepository _repository;
}
