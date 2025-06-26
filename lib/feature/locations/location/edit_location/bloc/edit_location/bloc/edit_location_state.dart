part of 'edit_location_bloc.dart';

abstract class EditLocationState {
  const EditLocationState();
}

class EditLocationInitial extends EditLocationState {
  const EditLocationInitial();
}

class EditLocationLoaded extends EditLocationState {
  final Warehouse warehouse;
  final List<User> users;
    const EditLocationLoaded({
    required this.warehouse,
    required this.users,
  });
}

class EditLocationError extends EditLocationState {
  final Object massage;
  const EditLocationError(this.massage);
}
