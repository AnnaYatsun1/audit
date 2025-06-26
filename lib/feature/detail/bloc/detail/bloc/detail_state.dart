part of 'detail_bloc.dart';

abstract class DetailState {
  const DetailState();
}

class DetailInitial extends DetailState {
  const DetailInitial();
}

class DetailLoaded extends DetailState {
  final InventoryItemDetails detailModel;
  final List<WarehouseSearchItem> allWarehouses;
  final List<WarehouseSearchItem> filteredWarehouses;
  final List<UserSearchItem> allReceivers;
  final List<UserSearchItem> filteredReceivers;

    DetailLoaded({
    required this.detailModel,
    required this.allWarehouses,
    this.filteredWarehouses = const [],
    required this.allReceivers,
    this.filteredReceivers = const [],
  });

    DetailLoaded copyWith({
      InventoryItemDetails? detailModel,
      List<WarehouseSearchItem>? allWarehouses,
      List<WarehouseSearchItem>? filteredWarehouses,
      List<UserSearchItem>? allReceivers,
      List<UserSearchItem>? filteredReceivers,
    }) {
    return DetailLoaded(
      detailModel: detailModel ?? this.detailModel,
      allWarehouses: allWarehouses ?? this.allWarehouses,
      filteredWarehouses: filteredWarehouses ?? this.filteredWarehouses,
      allReceivers: allReceivers ?? this.allReceivers,
      filteredReceivers: filteredReceivers ?? this.filteredReceivers,
      );
    }
}

class DetailError extends DetailState {
  final Object error;

  DetailError(this.error);
}
