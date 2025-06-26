import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/home/filter/bloc/filters/bloc/filters_bloc.dart';
import 'package:sound_level_meter/feature/home/filter/bloc/filters/repository/filters_repository.dart';
import 'package:sound_level_meter/feature/home/filter/model/inventory_filters_model.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/ui/custom_action_button.dart';

@RoutePage()
class FiltreScreen extends StatefulWidget {
  const FiltreScreen({super.key});
  // , this.selectedBrand, this.selectedBrandType});

  @override
  State<FiltreScreen> createState() => _FiltreScreenState();
}

class _FiltreScreenState extends State<FiltreScreen> {
  final FiltersBloc _filtersBloc = FiltersBloc(FiltersRepository());
  final warehouseController = TextEditingController();
  final responderController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController dataSortedController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  InventoryBrand? selectedBrand;
  InventoryType? selectedType;
  ItemStatus? status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filtersBloc.add(FiltersStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
        bloc: _filtersBloc,
        builder: (context, state) {
          if (state is FiltersInitial) {
            return Center(child: CustomLoadingIndicator());
            // CircularProgressIndicator()); // Показываем лоадер
          } else if (state is FiltersLoaded) {
            return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 39, 37, 37),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  // scrollDirection: ,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 26,
                      ),
                      // Text('Фильтрация и ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      // Индикатор для перетаскивания
                      // Container(
                      //   width: 60,
                      //   height: 5,
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey[800],
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      // ),
                      const SizedBox(height: 12),

                      _buildWarehouseSearchField(
                          'Выберете локацию', warehouseController),
                      SizedBox(
                        height: 18,
                      ),

                      Text(
                        'Ответсвенный',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _buildWarehouseSearchField(
                          'Поиск ответсвенного', responderController),

                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Статус',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      Wrap(
                        spacing: 6,
                        runSpacing: 0,
                        children: ItemStatus.values.map((status) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio<ItemStatus>(
                                value: status,
                                groupValue: ItemStatus.fixed,
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  setState(() {
                                    status = value!;
                                  });
                                },
                              ),
                              Text(status.name,
                                  style: TextStyle(color: Colors.white)),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        spacing: 6,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              // spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Бренд',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                _buildDropdown(
                                    controller: typeController,
                                    items: InventoryType.values,
                                    label: 'Выбрать тип',
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType = value;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          // Expanded(
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Тип',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildDropdown(
                                    controller: brandController,
                                    items: InventoryBrand.values,
                                    label: 'Выбрать бренд',
                                    onChanged: (value) {
                                      setState(() {
                                        selectedBrand = value;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      _buildDropdown(
                          controller: dataSortedController,
                          items: DataTypeSorted.values,
                          label: "Сортировать по дате добавления",
                          onChanged: (value) {
                            setState(() {});
                          }),

                      const SizedBox(height: 24),

                      Row(
                        spacing: 6,
                        children: [
                          Expanded(
                            child: GoldenButton(
                                label: 'Applay filtrs',
                                onPressed: () {
                                  final filters = InventoryFilter(
                                      responsible: User(
                                          'i',
                                          responderController.text,
                                          null,
                                          TypeWorker.admin),
                                      brand: selectedBrand,
                                      type: selectedType,
                                      dataSort: DataTypeSorted.newest,
                                      location: Warehouse(
                                          id: "",
                                          name: "name",
                                          inventoryItems: [],
                                          cityNameCode: "cityNameCode"));
                                  _filtersBloc.add(
                                      FiltersAplay(filter: InventoryFilter()));
                                  context.pop(filters);
                                }),
                          ),
                          Expanded(
                            child: GoldenButton(
                                backgroundColor:
                                    Color.fromARGB(255, 39, 37, 37),
                                textColor: Colors.white.withOpacity(0.7),
                                label: 'Cancel filters',
                                onPressed: () {
                                  // Navigator.pop(context, {
                                  //   'brand': widget.selectedBrand,
                                  //   'type': widget.selectedBrandType,
                                  // });
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ));
          } else if (state is FiltersError) {
            return Text('Error: ${state.massage}');
          }

          return SizedBox.shrink();
        });
  }

  Widget _buildModeButton(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          // const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
        ],
      ),
    );
  }

  //   Widget _buildWarehouseList(FiltersInitial state) {
  //   if ((state as FiltersLoaded).filteredWarehouses.isEmpty) {
  //     print(filteredWarehouses);
  //     return SizedBox
  //         .shrink(); // Возвращаем пустой виджет, если нет результатов
  //   }
  //   return Container(
  //     color: Color(0xFF2C2C2C),
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: state.filteredWarehouses.length,
  //       itemBuilder: (context, index) {
  //         final warehouse = state.filteredWarehouses[index];
  //         return ListTile(
  //           title: Text(warehouse.warehouseName),
  //           textColor: Colors.white,
  //           onTap: () {
  //             // setState(() {
  //             // selectedWarehouse = warehouse;
  //             warehouseController.text = warehouse.warehouseName;
  //             // _createBloc.add(ClearSearchResults());
  //             // });
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildWarehouseSearchField(
      String text, TextEditingController controller) {
    return TextField(
      autocorrect: false,
      cursorColor: Color.fromARGB(255, 255, 149, 0),
      controller: controller,
      decoration: InputDecoration(
        fillColor: Color(0xFF2C2C2C),
        filled: true,
        hintText:
            text, // Это будет текст по умолчанию, который будет исчезать при вводе
        hintStyle: TextStyle(color: Colors.grey),
        // labelText: 'Search Warehouse',
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color(0xFF2C2C2C)), // Цвет бордера при фокусе
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (query) {
        if (query.length > 2) {
          // _createBloc.add(WarehouseSearch(query: query)); // Поиск складов
        } else {
          // setState(() {
          // _createBloc.add(ClearSearchResults());
          // });
        }
      },
    );
  }

  Widget _buildDropdown<T>({
    required TextEditingController controller,
    required List<T> items,
    required String label,
    required void Function(T?) onChanged,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // width: 250, // Установи нужную ширину
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xFF1A1A1A), // Цвет выпадающего списка
          ),
          child: DropdownButtonFormField<T>(
            value: controller.text.isEmpty
                ? null
                : items.firstWhere(
                    (item) =>
                        item.toString().split('.').last == controller.text,
                    orElse: () => items[0],
                  ),
            selectedItemBuilder: (context) {
              return items.map<Widget>((T value) {
                return Text(
                  value.toString().split('.').last,
                  style: const TextStyle(color: Colors.white),
                );
              }).toList();
            },
            onChanged: (T? newValue) {
              setState(() {
                if (newValue != null) {
                  controller.text = newValue.toString().split('.').last;
                }
              });
            },
            decoration: InputDecoration(
              fillColor: const Color(0xFF2C2C2C),
              filled: true,
              labelText: label,
              // hintText: label,
              labelStyle: const TextStyle(color: Colors.white),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            dropdownColor: const Color(0xFF1A1A1A), // дубль на всякий случай
            items: items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.toString().split('.').last,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onSaved: onChanged,
            // onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: const Color.fromARGB(130, 0, 0, 0),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Кольцо
            SizedBox(
              height: 48,
              width: 48,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                color: const Color(0xFFFF9500), // как на кнопках
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Завантаження...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
