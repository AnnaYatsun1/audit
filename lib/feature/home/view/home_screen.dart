

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/home/bloc/home_bloc.dart';
import 'package:sound_level_meter/feature/home/filter/model/inventory_filters_model.dart';
import 'package:sound_level_meter/feature/home/filter/view/filtre_screen.dart';
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


  Widget _buildFilterContent(BuildContext context) {
    // String? selectedBrand;
    // String? selectedBrandType;

    return FiltreScreen(
      // selectedBrand: selectedBrand,
      // selectedBrandType: selectedBrandType,
    );
  }

  Future<void> _showFiltureModelScreen(BuildContext context) async {
    final result = await showModalBottomSheet<InventoryFilter>(
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

    if (result != null ) {
      setState(() {
        print(result.type?.name);
        print(mounted);
        // _appliedFilter = result; // ← сохрани фильтр, чтобы отобразить его
      });

      // Запрос на обновление списка:
      // _homeBloc.add(HomeFilterApplied(result));
    }
  }

  // void _showFiltureModelScreen(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.black,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return _buildFilterContent(context);
  //     },

  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBarIsVisible: true,
        appBarMode: AppBarMode.main,
        // showBackButton: false,
        // appBarIsVisible: true,
        // aBarImage: Image.asset(
        //   'assets/images/info.png',
        //   width: 30,
        //   height: 30,
        // ),
        // appBarIsVisible: true,
        child: BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeBloc,
            builder: (context, state) {
              if (state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                return Skeletonizer(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //   Padding(
                        //     padding: EdgeInsets.all(10),
                        //     child:
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Flexible(child: CustomSearchBar()),
                        //     SizedBox(
                        //       width: 8,
                        //     ),
                        //     IconButton(
                        //       icon: Icon(
                        //         Icons.qr_code_scanner,
                        //         color: Colors.white,
                        //       ), // Сканер баркоду
                        //       onPressed: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     QRScannerScreen()));
                        //         MobileScanner(onDetect: (capture) {});
                        //         //_scanBarcode(); // Метод для сканування
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        ActiveFiltersBar(
                          filter: InventoryFilter(
                              type: InventoryType.phone,
                              brand: InventoryBrand.Brandbary),
                          // filters: [
                          //   'Apple',
                          //   'Смартфон',
                          //   'Працює',
                          //   'Працює',
                          //   'Працює',
                          //   'Працює',
                          //   'Працює',
                          //   'Працює',

                          // ],
                          onRemoveFilter: (removed) {
                            setState(() {
                              // filters.remove(removed);
                            });
                          },
                        ),

                        SizedBox(
                          height: 16,
                        ),
                        ActionBar(newProduct: () {
                          AutoRouter.of(context).push(CreateProductRoute());
                        }, openFilts: () {
                          _showFiltureModelScreen(context);
                        }),

                        // ),
                        Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 10),
                              child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: state.techniqueList.length,
                                  // items.length,
                                  itemBuilder: (context, index) {
                                    final item = state.techniqueList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
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
                    ));
              } else if (state is HomeError) {
                // надо сделать обработчик обибок обьект
                return Text(
                    'Error: ${state.message.toString() ?? "Smth happend pls try again"}');
              }
              return const SizedBox.shrink();
            }));
  }
}

class ActionBar extends StatelessWidget {
  final VoidCallback newProduct;
  final VoidCallback openFilts;
  final int activeFiltersCount;
  const ActionBar(
      {super.key,
      required this.newProduct,
      required this.openFilts,
      this.activeFiltersCount = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ActionButton(
            label: 'Створити',
            icon: Icons.add_box_outlined,
            onPressed: newProduct,
            badgeText: "HOT",
          ),
          _ActionButton(
            label: 'Фільтр',
            icon: Icons.filter_list,
            onPressed: openFilts,
            badgeText: activeFiltersCount > 0 ? '$activeFiltersCount' : null,
          ),
          _ActionButton(
            label: 'Експорт',
            icon: Icons.file_download_outlined,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final String? badgeText;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            IconButton(
              icon: Icon(icon, color: Colors.white, size: 28),
              onPressed: onPressed,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        if (badgeText != null)
          Positioned(
            top: 2,
            right: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 149, 0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText!,
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
          ),
      ],
    );
  }
}

class ActiveFiltersBar extends StatelessWidget {
  final InventoryFilter filter;
  final void Function(String label) onRemoveFilter;

  const ActiveFiltersBar({
    super.key,
    required this.filter,
    required this.onRemoveFilter,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> labels = _extractFilterLabels(filter);

    if (labels.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = labels[index];
          return Chip(
            backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            label: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            deleteIcon: const Icon(Icons.close,
                size: 18, color: Color.fromARGB(255, 255, 149, 0)),
            onDeleted: () => onRemoveFilter(label),
          );
        },
      ),
    );
  }

  List<String> _extractFilterLabels(InventoryFilter filter) {
    final labels = <String>[];
    if (filter.brand != null) labels.add(filter.brand!.name);
    if (filter.type != null) labels.add(filter.type!.name);
    // if (filter.status != null) labels.add(_statusName(filter.status!));
    // if (filter.location != null)
    //   labels.add(filter.location!.locationName.cityName);
    // if (filter.responsible != null) labels.add(filter.responsible!.name);
    return labels;
  }

  // String _statusName(ItemStatus status) {
  //   switch (status) {
  //     case ItemStatus.working:
  //       return 'Працює';
  //     case ItemStatus.test1:
  //       return 'Зламаний';
  //     case ItemStatus.fixed:
  //       return 'Використовується';

  //   }
  // }
}
