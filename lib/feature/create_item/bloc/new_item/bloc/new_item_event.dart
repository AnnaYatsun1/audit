part of 'new_item_bloc.dart';

abstract class NewItemEvent {}

class NewItemStarted extends NewItemEvent {}

class NewItemCreated extends NewItemEvent {
  InventoryItemCreate newInventoryItem;
  NewItemCreated(this.newInventoryItem);
}

class WarehouseSearch extends NewItemEvent {
  final String query;

  WarehouseSearch({required this.query}); 
}

class ClearSearchResults  extends NewItemEvent {
  
}

class SelectWarehouse extends NewItemEvent {
  final Warehouse warehouse;
  SelectWarehouse(this.warehouse);
}
