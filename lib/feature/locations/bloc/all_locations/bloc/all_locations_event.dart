part of 'all_locations_bloc.dart';

abstract class AllLocationsEvent {}

class AllLocationsStarted extends AllLocationsEvent {}


class DeleteLocation extends AllLocationsEvent {
  final String id;
  DeleteLocation(this.id);
}