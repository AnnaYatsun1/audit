part of 'detail_bloc.dart';

abstract class DetailState {
  const DetailState();
}

class DetailInitial extends DetailState {
  const DetailInitial();
}

class DetailLoaded extends DetailState {
  final InventoryItemDetails detailModel;

  DetailLoaded(this.detailModel);
}

class DetailError extends DetailState {
  final Object error;

  DetailError(this.error);
}
