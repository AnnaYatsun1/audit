part of 'location_bloc.dart';

abstract class LocationState {
  const LocationState();
}

class LocationInitial extends LocationState {
  const LocationInitial();
}


class LocationLoaded extends LocationState {
  final List<LocationModel> locations;
  const LocationLoaded(this.locations);
}

class LocationError extends LocationState {
  final Object massage;
  const LocationError(this.massage);
}
