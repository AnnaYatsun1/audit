part of 'new_type_bloc.dart';

abstract class NewTypeState {
  const NewTypeState();
}

class NewTypeInitial extends NewTypeState {
  const NewTypeInitial();
}

class NewTypeLoaded extends NewTypeState {
  final List<Brand> brands;
  final List<Catogory> types;

  NewTypeLoaded({required this.brands, required this.types});
}

class NewTypeError extends NewTypeState {
  final Object massage;

  NewTypeError({required this.massage});
}
