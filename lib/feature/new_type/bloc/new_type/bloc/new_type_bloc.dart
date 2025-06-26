import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/new_type/bloc/new_type/repository/new_type_repository.dart';

import '../../../view.dart';

part 'new_type_event.dart';
part 'new_type_state.dart';

class NewTypeBloc extends Bloc<NewTypeEvent, NewTypeState> {
  NewTypeBloc(this._repository) : super(const NewTypeInitial()) {
    on<NewTypeStarted>((event, emit) async {
      try {
        emit(NewTypeInitial());
        final brandList = await _repository.loadBrand();
        final typeList = await _repository.loadType();

        brandList.sort((a, b) => a.name.compareTo(b.name));
        typeList.sort((a, b) => a.name.compareTo(b.name));
        emit(NewTypeLoaded(brands: brandList, types: typeList));
      } on Exception catch (e) {
        emit(NewTypeError(massage: e));
      }
    });

    on<NewTypeCreate<Brand>>((event, emit) async {
      await _repository.addBrand(event.item);
      final updatedBrands = await _repository.loadBrand();
      final currentTypes = await _repository.loadType();
      emit(NewTypeLoaded(brands: updatedBrands, types: currentTypes));
    });

    on<NewTypeCreate<Catogory>>((event, emit) async {
      await _repository.addType(event.item);
      final updatedTypes = await _repository.loadType();
      final currentBrands = await _repository.loadBrand();
      emit(NewTypeLoaded(brands: currentBrands, types: updatedTypes));
    });

    on<NewTypeDelete<Brand>>((event, emit) async {
      await _repository.deleteBrand(event.item);
      final updatedBrands = await _repository.loadBrand();
      final currentTypes = await _repository.loadType();
      emit(NewTypeLoaded(brands: updatedBrands, types: currentTypes));
    });

    on<NewTypeDelete<Catogory>>((event, emit) async {
      await _repository.deleteType(event.item);
      final updatedTypes = await _repository.loadType();
      final currentBrands = await _repository.loadBrand();
      emit(NewTypeLoaded(brands: currentBrands, types: updatedTypes));
    });

    on<NewTypeEdite<Brand>>((event, emit) async {
      print('BLoC получил NewTypeEdite<Brand>: ${event.newItem.name}');
      await _repository.editBrand(event.oldItem, event.newItem);
      final updatedBrands = await _repository.loadBrand();
      final types = await _repository.loadType();
      emit(NewTypeLoaded(brands: updatedBrands, types: types));
    });

    on<NewTypeEdite<Catogory>>((event, emit) async {
      await _repository.editType(event.oldItem, event.newItem);
      final updatedTypes = await _repository.loadType();
      final brands = await _repository.loadBrand();
      emit(NewTypeLoaded(brands: brands, types: updatedTypes));
    });
  }

  final NewTypeRepository _repository;
}
