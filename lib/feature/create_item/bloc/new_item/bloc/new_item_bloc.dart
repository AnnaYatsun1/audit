import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/create_item/bloc/new_item/repository/new_item_repository.dart';
import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';

part 'new_item_event.dart';
part 'new_item_state.dart';

class NewItemBloc extends Bloc<NewItemEvent, NewItemState> {
  NewItemBloc(this._repository) : super(const NewItemInitial()) {
    on<NewItemStarted>((event, emit) async {
      emit(NewItemInitial());
      try {
        final warehouses = await _repository.getWarehouseSearchItems();

        final selectedWarehouse = warehouses.isNotEmpty
            ? warehouses[0].toWarehouse()
            : Warehouse(id: '', name: '', inventoryItems: [], cityNameCode: '');

        emit(NewItemyLoaded(
          allWarehouses: [], // Загружаем все склады
          filteredWarehouses: [], // Отображаем все склады пока что
          selectedWarehouse:
              selectedWarehouse, // Выбираем первый склад по умолчанию
          newInventory: InventoryItemCreate(
            name: '',
            description: '',
            brand: null,
            type: null,
            workingCount: 0,
            brokenCount: 0,
            warehouse: selectedWarehouse, // Используем Warehouse объект
          ),
        ));
      } catch (e) {
        emit(NewItemError(
            'Error loading warehouses: $e')); // Если ошибка, выводим сообщение об ошибке
      }
    });
    on<NewItemCreated>((event, emit) async {
      try {
        final newItem =
            await _repository.createInventoryItem(event.newInventoryItem);
        emit(NewItemyLoaded(
          allWarehouses: [], // Сюда подставим все склады
          filteredWarehouses: [], // Фильтруемые склады
          newInventory: newItem, // Новый инвентарь
          selectedWarehouse:
              event.newInventoryItem.warehouse!, // Выбранный склад
        ));
      } on Exception catch (e) {
        emit(NewItemError(e.toString()));
      }
    });

    on<SelectWarehouse>((event, emit) async {
      if (state is NewItemyLoaded) {
        final currentState = state as NewItemyLoaded;
        emit(NewItemyLoaded(
          allWarehouses: currentState.allWarehouses,
          filteredWarehouses: currentState.filteredWarehouses,
          newInventory: currentState.newInventory,
          selectedWarehouse: event.warehouse, // Обновляем выбранный склад
        ));
      }
    });
    on<ClearSearchResults>((event, eemit) async {
       if (state is NewItemyLoaded) {
      final currentState = state as NewItemyLoaded;
      emit(currentState.copyWith(filteredWarehouses: []));
    }
    });


    on<WarehouseSearch>((event, emit) async {
      try {
        // Отправка запроса на получение складов
        final warehouses = await _repository.getWarehouseSearchItems();

        // Фильтрация складов по запросу
        final filteredWarehouses = warehouses.where((warehouse) {
          return warehouse.warehouseName
                  .toLowerCase()
                  .contains(event.query.toLowerCase()) ||
              warehouse.cityName
                  .toLowerCase()
                  .contains(event.query.toLowerCase());
        }).toList();

        print(
            'Filtered Warehouses: $filteredWarehouses'); // Логируем отфильтрованные склады

        // Эмитируем новое состояние с результатами поиска
        emit(
          NewItemyLoaded(
            allWarehouses: [],
            filteredWarehouses: filteredWarehouses,
            selectedWarehouse: Warehouse(id: '', name: '', inventoryItems: [], cityNameCode: ''),
            newInventory: InventoryItemCreate(
                name: '',
                description: '',
                brand: null,
                type: null,
                workingCount: 0,
                brokenCount: 0,
                warehouse: null),
          ),
        );
      } catch (e) {
        // В случае ошибки показываем сообщение об ошибке
        emit(NewItemError(e.toString()));
      }
    });
  }

  final NewItemRepository _repository;
}
