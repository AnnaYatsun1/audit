import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/similar_product/bloc/similar/repository/similar_repository.dart';

part 'similar_event.dart';
part 'similar_state.dart';

class SimilarBloc extends Bloc<SimilarEvent, SimilarState> {
  SimilarBloc(this._repository) : super(const SimilarInitial()) {
    on<SimilarStarted>((event, emit) async {
      // TODO: Implement logic here
    });
  }

  final SimilarRepository _repository;
}
