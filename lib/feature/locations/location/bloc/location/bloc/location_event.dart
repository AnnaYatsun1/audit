part of 'product_location_bloc.dart';

abstract class LocationEvent {}

class LocationStarted extends LocationEvent {
  final Category type;
  LocationStarted({required this.type});
}
