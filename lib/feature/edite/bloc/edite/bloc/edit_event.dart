part of 'edit_bloc.dart';

abstract class EditEvent {}

class EditStarted extends EditEvent {
  final String id;
   EditStarted({required this.id});
}

class EditApplay extends EditEvent {
  final InventoryItemEdit updateModel;

  EditApplay({required this.updateModel});
}
