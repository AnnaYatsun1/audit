part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeStarted extends HomeEvent {}


class HomeItemDeleted extends HomeEvent {
  final int index;
  HomeItemDeleted(this.index);
}

class HomeFiltersApplied extends HomeEvent {
  final String? brand;
  final String? type;
  HomeFiltersApplied({this.brand, this.type});
}
