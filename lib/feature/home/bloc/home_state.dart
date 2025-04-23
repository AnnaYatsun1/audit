part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<TechniqueList> techniqueList;

  HomeLoaded(this.techniqueList);
}
