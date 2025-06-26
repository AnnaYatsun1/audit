import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sound_level_meter/feature/create_item/bloc/new_item/bloc/new_item_bloc.dart';
import 'package:sound_level_meter/feature/create_item/bloc/new_item/repository/new_item_repository.dart';
import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/filter/view/filtre_screen.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/ui/custom_action_button.dart';
import 'package:sound_level_meter/feature/ui/dropDown_button.dart';
import 'package:sound_level_meter/feature/ui/photo_picker.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

@RoutePage()
class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateNewProductScreenState();
}

class _CreateNewProductScreenState extends State<CreateProductScreen> {
  final NewItemBloc _createBloc = NewItemBloc(NewItemRepository());
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  Warehouse? selectedWarehouse;
  List<WarehouseSearchItem> filteredWarehouses = [];
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final workingCountController = TextEditingController();
  final noWorkingCountController = TextEditingController();
  final quantityController = TextEditingController();
  final warehouseController = TextEditingController();

  final recipientController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  bool isNameValid = false;
  bool isDescriptionValid = false;
  bool isQuantityValid = true;
  bool isWarehouseValid = true;
  bool isButtonEnabled = false;

  bool _isFormValid() {
    return isNameValid;
    // && isDescriptionValid && isQuantityValid && isWarehouseValid;
  }

  @override
  void dispose() {
    nameController.dispose();
    warehouseController.dispose();
    noWorkingCountController.dispose();
    workingCountController.dispose();
    recipientController.dispose();
    descriptionController.dispose();
    brandController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _createBloc.add(NewItemStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewItemBloc, NewItemState>(
      bloc: _createBloc,
      builder: (context, state) {
        if (state is NewItemInitial) {
          return Center(child: CustomLoadingIndicator());// Показываем лоадер
        } else if (state is NewItemyLoaded) {
          return CustomScaffold(
            appBarIsVisible: true,
            appBarMode: AppBarMode.titleOnly,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Поле для фото
                    CustomPhotoPicker(
                      imageFile: imageFile,
                      onTap: pickPhotoFrom,
                    ),
                    SizedBox(height: 16),

                    // Название продукта
                    _buildTextField(
                      controller: nameController,
                      label: 'Product Name',
                      errorText: isNameValid ? null : 'This field is required',
                    ),
                    SizedBox(height: 16),

                    // Описание продукта
                    _buildTextField(
                        controller: descriptionController,
                        label: 'Description'),
                    SizedBox(height: 16),

                    // Количество рабочих
                    _buildCountRow(
                        controller: workingCountController,
                        label: 'Quantity of Working Items'),
                    SizedBox(height: 16),

                    // Количество нерабочих
                    _buildCountRow(
                        controller: noWorkingCountController,
                        label: 'Quantity of Non-Working Items'),
                    SizedBox(height: 16),

                    // Выбор бренда
                    _buildDropdown<InventoryBrand>(
                      controller: brandController,
                      items: InventoryBrand.values,
                      label: "Select Brand",
                    ),
                    SizedBox(height: 16),

                    // Выбор типа
                    _buildDropdown<InventoryType>(
                      controller: typeController,
                      items: InventoryType.values,
                      label: "Select Type",
                    ),
                    SizedBox(height: 16),

                    // Выбор склада
                    _buildWarehouseSearchField(),
                    // SizedBox(height: 16),

                    // Список складов

                    // Список складов появляется только если введено больше 2 символов
                    //  if (filteredWarehouses.isNotEmpty)
                    _buildWarehouseList(state),

                    SizedBox(height: 26),

                    // Кнопка создания инвентаря
                    GoldenButton(
                      onPressed: () {
                        if (selectedWarehouse != null) {
                          final newItem = InventoryItemCreate(
                            name: nameController.text,
                            description: descriptionController.text,
                            brand: InventoryBrand.Apple,
                            type: InventoryType.phone,
                            workingCount:
                                int.parse(workingCountController.text),
                            brokenCount: 0,
                            warehouse:
                                selectedWarehouse!, // Передаем выбранный склад
                          );
                          _createBloc.add(
                              NewItemCreated(newItem)); // Создание инвентаря
                        }
                      },
                      label: 'Create Inventory',
                    ),
                    SizedBox(height: 26,)
                  ],
                ),
              ),
            ),
          );
        } else if (state is NewItemError) {
          return Text('Error: ${state.massage}');
        }

        return SizedBox.shrink(); // Возвращаем пустой виджет по умолчанию
      },
    );
  }

  // Функция для TextField с более чистым кодом
  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      String? errorText}) {
    print(isNameValid);
    return TextFormField(
      controller: controller,
       cursorColor: Color.fromARGB(255, 255, 149, 0), 
      autocorrect: false,
      decoration: InputDecoration(
        fillColor: Color(0xFF2C2C2C),
        filled: true,
        // labelText: label,
        hintText:
            label, // Это будет текст по умолчанию, который будет исчезать при вводе
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color(0xFF2C2C2C)), // Цвет бордера при фокусе
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (value) {
        setState(() {
          isNameValid = value.isNotEmpty;
        });
      },
    );
  }

  // Функция для поля количества с кнопками добавления/убавления
  Widget _buildCountRow(
      {required TextEditingController controller, required String label}) {
    return Row(
      children: [
        Expanded(
          child: TextField(
             cursorColor: Color.fromARGB(255, 255, 149, 0), 
            controller: controller,
            decoration: InputDecoration(
              fillColor: Color(0xFF2C2C2C),
              filled: true,
              hintText:
                  label, // Это будет текст по умолчанию, который будет исчезать при вводе
              hintStyle: TextStyle(color: Colors.grey),
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFF2C2C2C)), // Цвет бордера при фокусе
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
          ),
        ),
        IconButton(
          icon: Icon(Icons.remove, color: Colors.white),
          onPressed: () {
            setState(() {
              int currentValue = int.tryParse(controller.text) ?? 0;
              if (currentValue > 0) {
                controller.text = (currentValue - 1).toString();
              }
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            setState(() {
              int currentValue = int.tryParse(controller.text) ?? 0;
              controller.text = (currentValue + 1).toString();
            });
          },
        ),
      ],
    );
  }
  Widget _buildDropdown<T>({
  required TextEditingController controller,
  required List<T> items,
  required String label,
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
        ),
      ),
    ),
  );
}


  // Widget _buildDropdown<T>({
  //   required TextEditingController controller,
  //   required List<T> items,
  //   required String label,
  // }) {
  //   return DropdownButtonFormField<T>(
  //     value: controller.text.isEmpty
  //         ? null
  //         : items.firstWhere(
  //             (item) => item.toString().split('.').last == controller.text,
  //             orElse: () =>
  //                 items[0], // Если не найдено значение, берем первый элемент
  //           ),
  //     selectedItemBuilder: (context) {
  //       return items.map<Widget>((T value) {
  //         return Text(
  //           value.toString().split('.').last,
  //           style: TextStyle(
  //               color: Colors.white), // Текст выбранного элемента белый
  //         );
  //       }).toList();
  //     }, // Устанавливаем value в null для первого рендера
  //     onChanged: (T? newValue) {
  //       setState(() {
  //         if (newValue != null) {
  //           controller.text = newValue
  //               .toString()
  //               .split('.')
  //               .last; // Преобразование значения в текст
  //         }
  //       });
  //     },
  //     decoration: InputDecoration(
  //       fillColor: Color(0xFF2C2C2C),
  //       filled: true,
  //       labelText: label,
  //       labelStyle: TextStyle(color: Colors.white),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Color(0xFF2C2C2C)),
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //     ),
  //     items: items.map((T value) {
  //       return DropdownMenuItem<T>(
  //         value: value,
  //         child: Text(
  //           value.toString().split('.').last,
  //           style: TextStyle(color: Colors.black),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  Widget _buildWarehouseSearchField() {
    return TextField(
      autocorrect: false,
       cursorColor: Color.fromARGB(255, 255, 149, 0), 
      controller: warehouseController,
      decoration: InputDecoration(
        fillColor: Color(0xFF2C2C2C),
        filled: true,
        hintText:
            'Search Warehouse', // Это будет текст по умолчанию, который будет исчезать при вводе
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
          _createBloc.add(WarehouseSearch(query: query)); // Поиск складов
        } else {
          // setState(() {
          _createBloc.add(ClearSearchResults());
          // });
        }
      },
    );
  }

  // Функция для отображения списка складов
  Widget _buildWarehouseList(NewItemState state) {
    if ((state as NewItemyLoaded).filteredWarehouses.isEmpty) {
      print(filteredWarehouses);
      return SizedBox
          .shrink(); // Возвращаем пустой виджет, если нет результатов
    }
    return Container(
      color: Color(0xFF2C2C2C),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.filteredWarehouses.length,
        itemBuilder: (context, index) {
          final warehouse = state.filteredWarehouses[index];
          return ListTile(
            title: Text(warehouse.warehouseName),
            textColor: Colors.white,
            onTap: () {
              // setState(() {
              // selectedWarehouse = warehouse;
              warehouseController.text = warehouse.warehouseName;
              _createBloc.add(ClearSearchResults());
              // });
            },
          );
        },
      ),
    );
  }

  Future<void> pickPhotoFrom(ImageSource source) async {
    final picker = await _picker.pickImage(source: source);
    if (picker != null) {
      setState(() {
        imageFile = picker;
      });
    }
  }
}


