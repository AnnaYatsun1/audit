part of 'filters_bloc.dart';

abstract class FiltersState {
  const FiltersState();
}

class FiltersInitial extends FiltersState {
  const FiltersInitial();
}

class FiltersLoaded extends FiltersState {
  final InventoryFilter filter;
  final List<Warehouse> locations;
  final List<WarehouseSearchItem> filteredWarehouses;
  final List<UserSearchItem> users;
  // final List<UserSearchItem> users;
  final List<InventoryType> types;
  final List<InventoryBrand> brands;

   const FiltersLoaded({
    required this.filter,
    required this.filteredWarehouses,
    required this.locations,
    required this.users,
    required this.types,
    required this.brands,
  });
}

class FiltersError extends FiltersState {
  final Object massage;
  const FiltersError(this.massage);
}
