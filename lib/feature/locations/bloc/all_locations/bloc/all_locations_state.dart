part of 'all_locations_bloc.dart';

abstract class AllLocationsState {
  const AllLocationsState();
}

class AllLocationsInitial extends AllLocationsState {
  const AllLocationsInitial();
}



class AllLocationLoaded extends AllLocationsState {
  final List<Warehouse> warehouses;
  AllLocationLoaded(this.warehouses);
}

class LocationsError extends AllLocationsState {
  final String message;
  LocationsError(this.message);
}