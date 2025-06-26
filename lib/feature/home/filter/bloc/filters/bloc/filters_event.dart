part of 'filters_bloc.dart';

abstract class FiltersEvent {}

class FiltersStarted extends FiltersEvent {}

class FiltersAplay extends FiltersEvent {
    final InventoryFilter filter;

  FiltersAplay({required this.filter});
}
class FiltersDecline extends FiltersEvent {}



