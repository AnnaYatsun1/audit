part of 'edit_bloc.dart';

abstract class EditState {
  const EditState();
}

class EditInitial extends EditState {
  const EditInitial();
}

class EditLoaded extends EditState {
  final InventoryItemEdit updateModel;
  const EditLoaded(this.updateModel);
}

class EditError extends EditState {
  final Object massage;
  const EditError(this.massage);
}
