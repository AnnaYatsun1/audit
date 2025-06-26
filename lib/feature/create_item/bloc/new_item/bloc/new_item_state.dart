part of 'new_item_bloc.dart';

abstract class NewItemState {
  const NewItemState();
}

class NewItemInitial extends NewItemState {
  const NewItemInitial();
}

class NewItemyLoaded extends NewItemState {
  final List<WarehouseSearchItem> allWarehouses;
  final List<WarehouseSearchItem> filteredWarehouses;
  final InventoryItemCreate newInventory;
    final Warehouse selectedWarehouse;

  NewItemyLoaded({
    required this.allWarehouses,
     this.filteredWarehouses =  const [],
    required this.newInventory,
    required this.selectedWarehouse
  });


    NewItemyLoaded copyWith({
      InventoryItemCreate? newInventory,
      Warehouse? selectedWarehouse,
      List<WarehouseSearchItem>? allWarehouses,
      List<WarehouseSearchItem>? filteredWarehouses,


    }) {
    return NewItemyLoaded(
      newInventory: newInventory ?? this.newInventory,
      allWarehouses: allWarehouses ?? this.allWarehouses,
      filteredWarehouses: filteredWarehouses ?? this.filteredWarehouses,
      selectedWarehouse: selectedWarehouse ?? this.selectedWarehouse,
  
      );
    }
}

class NewItemError extends NewItemState {
  final Object massage;
  const NewItemError(this.massage);
}