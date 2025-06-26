part of 'edit_location_bloc.dart';

abstract class EditLocationEvent {}

class EditLocationStarted extends EditLocationEvent {
    final Warehouse warehouse;
  EditLocationStarted (this.warehouse) ;
}

class EditWarehouseUpdated extends EditLocationEvent {
  final Warehouse warehouse;

  EditWarehouseUpdated(this.warehouse);
}