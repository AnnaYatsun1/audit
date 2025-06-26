import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/auth/repository/user_repository.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/edite/view/edit_screen.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/locations/location/edit_location/bloc/edit_location/bloc/edit_location_bloc.dart';
import 'package:sound_level_meter/feature/locations/location/edit_location/bloc/edit_location/repository/edit_location_repository.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/ui/custom_action_button.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/feature/ui/textField_view.dart';
import 'package:sound_level_meter/router/router.dart';

@RoutePage()
class EditWarehouseScreen extends StatefulWidget {
  final Warehouse model;

  const EditWarehouseScreen({super.key, required this.model});

  @override
  State<EditWarehouseScreen> createState() => _EditWarehouseScreenState();
}

class _EditWarehouseScreenState extends State<EditWarehouseScreen> {
  late EditLocationBloc _editeLocationBloc;
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final responsibleController = TextEditingController();
  User? selectedUser;

  @override
  void initState() {
    super.initState();
    print('получаем модель ${widget.model}');
    _editeLocationBloc = EditLocationBloc(
        EditLocationRepository([widget.model]), ImplementUserRepository());
    _editeLocationBloc.add(EditLocationStarted(widget.model));
  }

  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();
    responsibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditLocationBloc, EditLocationState>(
      bloc: _editeLocationBloc,
      builder: (context, state) {
        if (state is EditLocationInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EditLocationLoaded) {
          final warehouse = state.warehouse;
          nameController.text = warehouse.name;
          cityController.text = warehouse.cityNameCode;
          selectedUser ??= warehouse.responsible;

          return CustomScaffold(
            appBarIsVisible: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 8.0, right: 8.0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    label: 'Назва складу',
                    errorText: '',
                    onChanged: (_) {},
                    onChange: (_) {},
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: cityController,
                    label: 'Місто',
                    errorText: '',
                    onChanged: (_) {},
                    onChange: (_) {},
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<User>(
                    value: selectedUser,
                    items: state.users.map((user) {
                      return DropdownMenuItem<User>(
                        value: user,
                        child: Text(user.name,
                            style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (User? newUser) {
                      setState(() {
                        selectedUser = newUser;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Відповідальний',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color:  Color(0xFF2C2C2C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF2C2C2C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: const Color(0xFF2C2C2C),
                    menuMaxHeight:
                        200, // Показывать до 3 элементов, затем скролл
                  ),

                  // DropdownButtonFormField<User>(
                  //   value: selectedUser,
                  //   items: state.users.map((user) {
                  //     return DropdownMenuItem<User>(
                  //       value: user,
                  //       child: Text(user.name),
                  //     );
                  //   }).toList(),
                  //   onChanged: (User? newUser) {
                  //     setState(() {
                  //       selectedUser = newUser;
                  //     });
                  //   },
                  //   decoration: InputDecoration(
                  //     labelText: 'Відповідальний',
                  //     filled: true,
                  //     fillColor: const Color(0xFF2C2C2C),
                  //     labelStyle: const TextStyle(color: Colors.white),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),

                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  GoldenButton(
                    label: 'SAVE',
                    onPressed: () {
                      final updatedWarehouse = Warehouse(
                        id: warehouse.id,
                        name: nameController.text,
                        cityNameCode: cityController.text,
                        inventoryItems: warehouse.inventoryItems,
                        responsible: selectedUser,
                      );
                      _editeLocationBloc
                          .add(EditWarehouseUpdated(updatedWarehouse));
                      AutoRouter.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        } else if (state is EditLocationError) {
          return Text('Error: ${state.massage}');
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget _buildDropdown<T>({
  required TextEditingController controller,
  required List<T> items,
  required String label,
}) {
  return DropdownButtonFormField<T>(
    value: controller.text.isEmpty
        ? null
        : items.firstWhere(
            (item) => item.toString().split('.').last == controller.text,
            orElse: () =>
                items[0], // Если не найдено значение, берем первый элемент
          ),
    selectedItemBuilder: (context) {
      return items.map<Widget>((T value) {
        return Text(
          value.toString().split('.').last,
          style:
              TextStyle(color: Colors.white), // Текст выбранного элемента белый
        );
      }).toList();
    }, // Устанавливаем value в null для первого рендера
    onChanged: (T? newValue) {
      // setState(() {
      //   if (newValue != null) {
      //     controller.text = newValue
      //         .toString()
      //         .split('.')
      //         .last; // Преобразование значения в текст
      //   }
      // });
    },
    decoration: InputDecoration(
      fillColor: Color(0xFF2C2C2C),
      filled: true,
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF2C2C2C)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    items: items.map((T value) {
      return DropdownMenuItem<T>(
        value: value,
        child: Text(
          value.toString().split('.').last,
          style: TextStyle(color: Colors.black),
        ),
      );
    }).toList(),
  );
}
