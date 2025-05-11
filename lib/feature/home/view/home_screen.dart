import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/bloc/home_bloc.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/home/repository/home_repository.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/router/router.dart';

import '../../info/view.dart';
import '../view.dart';

@RoutePage()
class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  bool isHiddenPassword = true;
  final TextEditingController emailTextInputController =
      TextEditingController();
  final TextEditingController passwordTextInputController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool showOnlyWorking = false;
  final _homeBloc = HomeBloc(HomeRepository());
  @override
  void initState() {
    _homeBloc.add(HomeStarted());
    super.initState();
  }

  void toogleToPasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void onEditItem(InventoryItemView item) async {
    final updatedItem = await AutoRouter.of(context).push<InventoryItemView>(
      EditRoute(item: item),
    );

    if (updatedItem != null) {
      // Отправляем событие для обновления данных в Bloc
      _homeBloc.add(HomeItemUdate(updatedItem));
    }
  }

  void onDetailItem(InventoryItemView item) async {
    final updatedItem = await AutoRouter.of(context).push<InventoryItemView>(
      DetailRoute(item: item),
    );

    if (updatedItem != null) {
      // Отправляем событие для обновления данных в Bloc
      _homeBloc.add(HomeItemDetail(updatedItem));
    }
  }

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
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

  Widget _buildFilterContent(BuildContext context) {
    String? selectedBrand;
    String? selectedBrandType;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Индикатор для перетаскивания
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 12),

          // Заголовок и температура
          const Text(
            'Mode Control',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          const Text(
            'Exterior 32°  •  Interior 20°',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: selectedBrand,
            dropdownColor: Colors.black,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              labelText: 'Выбрать бренд',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: ['Apple', 'Samsung', 'Xiaomi', 'Sony']
                .map((brand) => DropdownMenuItem(
                      value: brand,
                      child: Text(brand),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedBrand = value;
              });
            },
          ),

          const SizedBox(height: 12),

          // Заголовок и температура
          const Text(
            'Mode Control',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          const Text(
            'Exterior 32°  •  Interior 20°',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: selectedBrand,
            dropdownColor: Colors.black,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              labelText: 'Выбрать бренд',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: ['Смартфон', 'Ноутбук', 'Планшет', 'Наушники']
                .map((brand) => DropdownMenuItem(
                      value: brand,
                      child: Text(brand),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedBrand = value;
              });
            },
          ),

          SwitchListTile(
              value: showOnlyWorking,
              activeColor: Colors.blue,
              title: const Text(
                'Только рабочие устройства',
                style: TextStyle(color: Colors.white),
              ),
              onChanged: (value) {
                setState(() {
                  showOnlyWorking = value;
                });
              }),
          // Кнопки режимов
          _buildModeButton('Quick Defrost', Icons.ac_unit, Colors.black),
          _buildModeButton('Pet Mode', Icons.pets, Colors.black),
          _buildModeButton('Normal Mode', Icons.air, Colors.blue),

          const SizedBox(height: 24),

          // Просмотр камеры
          TextButton(
            onPressed: () {
              Navigator.pop(context, {
                'brand': selectedBrand,
                'type': selectedBrandType,
              }); // Закрыть модалку
            },
            child: const Text(
              'Applay filtrs',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showFiltureModelScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return _buildFilterContent(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showBackButton: false,
        appBarIsVisible: true,
        aBarImage: Image.asset(
          'assets/images/info.png',
          width: 30,
          height: 30,
        ),
        // appBarIsVisible: true,
        child: BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeBloc,
            builder: (context, state) {
              if (state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: CustomSearchBar()),
                          SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white,
                            ), // Сканер баркоду
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRScannerScreen()));
                              MobileScanner(onDetect: (capture) {});
                              //_scanBarcode(); // Метод для сканування
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.filter_list, color: Colors.white),
                            onPressed: () {
                              _showFiltureModelScreen(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                          child: ListView.builder(
                              controller: _scrollController,
                              itemCount: state.techniqueList.length,
                              // items.length,
                              itemBuilder: (context, index) {
                                final item = state.techniqueList[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: InventoryCard(
                                    name: item.name,
                                    brand: item.brand,
                                    totalQuantity: item.total,
                                    workingQuantity: item.working,
                                    brokenQuantity: item.broken,
                                    onDetail: () {
                                      onDetailItem(item);
                                    },
                                    onEdit: () {
                                      onEditItem(item);
                                      print('Редагувати');
                                    },
                                    onDelete: () {
                                      _homeBloc.add(HomeItemDeleted(index));
                                    },
                                    onGenerateBarcode: () {
                                      AutoRouter.of(context)
                                          .push(QRScannerRoute());
                                      print('Генерація баркоду');
                                    },
                                  ),
                                );
                              })),
                    ),
                  ],
                );
              } else if (state is HomeError) {
                // надо сделать обработчик обибок обьект
                return Text(
                    'Error: ${state.message.toString() ?? "Smth happend pls try again"}');
              }
              return const SizedBox.shrink();
            }));
  }
}
