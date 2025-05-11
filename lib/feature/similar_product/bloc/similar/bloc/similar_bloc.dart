import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/similar_product/bloc/similar/repository/similar_repository.dart';
import 'package:sound_level_meter/feature/similar_product/model/similar_inventory_item.dart';

part 'similar_event.dart';
part 'similar_state.dart';

class SimilarBloc extends Bloc<SimilarEvent, SimilarState> {
  final SimilarRepository _repository;
  SimilarBloc(this._repository) : super(const SimilarInitial()) {
    on<SimilarStarted>((event, emit) async {
      emit(SimilarInitial());
     try {  final similarInvetories = await _repository.loadSimilarItems(event.brand);
      emit(SimilarLoaded(similarInvetories));
      } on Exception catch (e) {
        emit(SimilarError(e));
      }
    });
  }
}
