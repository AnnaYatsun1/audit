part of 'location_bloc.dart';

abstract class LocationEvent {}

class LocationStarted extends LocationEvent {
  final InventoryType type;
  LocationStarted({required this.type});
}
