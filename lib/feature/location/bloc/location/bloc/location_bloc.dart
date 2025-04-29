import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/location/bloc/location/repository/location_repository.dart';


part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(this._repository) : super(const LocationInitial()) {
    on<LocationStarted>((event, emit) async {
      // TODO: Implement logic here
    });
  }

  final LocationRepository _repository;
}
