part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeStarted extends HomeEvent {}

class HomeItemDeleted extends HomeEvent {
  final int index;
  HomeItemDeleted(this.index);
}

class HomeFiltersApplied extends HomeEvent {
  final String? brand;
  final String? type;
  HomeFiltersApplied({this.brand, this.type});
}

class HomeItemUdate extends HomeEvent {
  InventoryItemView _inventoryItem;
  HomeItemUdate(this._inventoryItem);
}

class HomeItemDetail extends HomeEvent {
  InventoryItemView _inventoryItem;
  HomeItemDetail(this._inventoryItem);
}


