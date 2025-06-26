import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/detail/bloc/detail/bloc/detail_bloc.dart';
import 'package:sound_level_meter/feature/detail/bloc/detail/repository/detail_repository.dart';
import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';

import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/home/filter/view/filtre_screen.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/similar_product/model/similar_inventory_item.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/feature/ui/theme/theme.dart';
import 'package:sound_level_meter/router/router.dart';

@RoutePage()
class DetailScreen extends StatefulWidget {
  final InventoryItemView item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailBloc _detailBloc;

  @override
  void initState() {
    super.initState();

    _detailBloc = DetailBloc(DetailRepository([widget.item]));
    _detailBloc.add(DetailStarted(id: widget.item.id));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBarIsVisible: true,
         appBarMode: AppBarMode.titleOnly,
        child: BlocBuilder<DetailBloc, DetailState>(
            bloc: _detailBloc,
            builder: (context, state) {
              if (state is DetailInitial) {
                return Center(child: CustomLoadingIndicator());
              } else if (state is DetailLoaded) {
                return SingleChildScrollView(
                  child: InventoryItemForm(
                      isReadonly: true,
                      viewModel: state.detailModel,
                      filteredReceivers: state.filteredReceivers,
                      filteredWarehouses: state.filteredWarehouses,
                      onSubmit: (model) {},
                      onMove: (onMoveModel) {
                        _detailBloc.add(MoveItem(transferModel: onMoveModel));
                      },
                      onDelivery: (onDeliveryModel) {
                        _detailBloc.add(
                            DeliveryOfGoods(deliveryModel: onDeliveryModel));
                      },
                      serchUserResult: (userResult) {
                        _detailBloc
                            .add(DetailReceiverSearch(query: userResult));
                      },
                      cleanResult: () {
                        _detailBloc.add(ClearSearchResults());
                      },
                      serchWarehouseResult: (warehouse) {
                        _detailBloc
                            .add(DetailWarehouseSearch(query: warehouse));
                      }),
                );
              } else if (state is DetailError) {
                return Text(
                    'Error: ${state.toString() ?? "Smth happend pls try again"}');
              }

              return SizedBox(
                height: 16,
              );
            }));
  }
}

class InventoryItemForm extends StatefulWidget {
  final bool isReadonly;
  final InventoryItemDetails? viewModel;
  final List<WarehouseSearchItem>? filteredWarehouses;
  final List<UserSearchItem>? filteredReceivers;
  final void Function(InventoryItemEdit)? onSubmit;
  final void Function(DeliveryItemModel)? onDelivery;
  final void Function(ItemTransferModel)? onMove;
  final void Function(String)? serchUserResult;
  final void Function(String)? serchWarehouseResult;
  final void Function()? cleanResult;

  const InventoryItemForm({
    super.key,
    this.isReadonly = false,
    this.viewModel,
    this.onSubmit,
    this.onDelivery,
    this.onMove,
    this.serchWarehouseResult,
    this.serchUserResult,
    this.filteredWarehouses,
    this.filteredReceivers,
    this.cleanResult,
  });

  @override
  State<InventoryItemForm> createState() => _InventoryItemFormState();
}

class _InventoryItemFormState extends State<InventoryItemForm> {
  final quantityController = TextEditingController();
  final warehouseController = TextEditingController();

  final recipientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.viewModel?.name);
    final brandController =
        TextEditingController(text: widget.viewModel?.brand);
    final usingController =
        TextEditingController(text: widget.viewModel?.usedQuantity.toString());
    final descriptionController =
        TextEditingController(text: widget.viewModel?.description);
    final workingController = TextEditingController(
      text: widget.viewModel?.workingQuantity.toString(),
    );
    final brokenController = TextEditingController(
        text: widget.viewModel?.brokenQuantity.toString());
    final serialController =
        TextEditingController(text: widget.viewModel?.serialNumber.toString());

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 16),

      // Картинка
      Center(
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.viewModel?.imagePath != null
              ? Image.asset(widget.viewModel!.imagePath!, fit: BoxFit.cover)
              : const Icon(Icons.inventory, size: 100, color: Colors.grey),
        ),
      ),

      SizedBox(height: 16),

      // Serial Number (плашка)
      Center(
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Serial number',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 4),
              Text(serialController.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),

      SizedBox(height: 24),

      // Остальные поля
      _buildField(
          label: 'Product Name',
          controller: nameController,
          enabled: !widget.isReadonly),
      _buildField(
          label: 'Description',
          controller: descriptionController,
          enabled: !widget.isReadonly,
          maxLines: 2),
      _buildField(
          label: 'Бренд',
          controller: brandController,
          enabled: !widget.isReadonly),

      Divider(color: Colors.white24, thickness: 0.5),
      _buildAmountField('Количество рабочих', workingController.text),
      Divider(color: Colors.white24, thickness: 0.5),
      _buildAmountField('Количество нерабочих', brokenController.text),
      Divider(color: Colors.white24, thickness: 0.5),
      _buildAmountField('Количество в использовании', usingController.text),

      SizedBox(height: 24),

      _buildActionsSection(),

      SizedBox(height: 24),
      Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          // Color(0xFF2C2C2C)
          color: Color(0xFF2C2C2C),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExpansionTile(
                    iconColor: Color.fromARGB(255, 255, 149, 0),
                    title: Text(
                      'Видати товар',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    children: [
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorColor: Color.fromARGB(255, 255, 149, 0),
                              style: TextStyle(color: Colors.white),
                              controller: quantityController,
                              decoration: InputDecoration(
                                hintText:
                                    'Кількість', // Это будет текст по умолчанию, который будет исчезать при вводе
                                hintStyle: TextStyle(color: Colors.grey),
                                // labelText: 'Кількість',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white30)),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              cursorColor: Color.fromARGB(255, 255, 149, 0),
                              controller: recipientController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText:
                                    'Кому', // Это будет текст по умолчанию, который будет исчезать при вводе
                                hintStyle: TextStyle(color: Colors.grey),
                                // labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white30)),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (queryParam) {
                                if (queryParam.length > 2) {
                                  print('queryParam ${queryParam}');
                                  // Подаем запрос в BLoC
                                  widget.serchUserResult?.call(queryParam);
                                } else {
                                  // Если запрос меньше 2 символов, очищаем список
                                  widget.serchUserResult?.call("");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Container(
                      //   height: 200,
                      //   child:
                      ListView.builder(
                        shrinkWrap:
                            true, // чтобы список занимал только необходимое пространство
                        itemCount: widget.filteredReceivers?.length ?? 0,
                        itemBuilder: (context, index) {
                          final receiver = widget.filteredReceivers?[index];

                          if (receiver == null) return Container();
                          return ListTile(
                            title: Text(
                              receiver.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              print("receiver.name ${receiver.name}");
                              recipientController.text = receiver.name;

                              widget.cleanResult?.call();
                            },
                          );
                        },
                      ),
                      // ),
                      // ),
                      TextField(
                        cursorColor: Color.fromARGB(255, 255, 149, 0),
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText:
                              'Отримуван для aкту', // Это будет текст по умолчанию, который будет исчезать при вводе
                          hintStyle: TextStyle(color: Colors.grey),
                          // labelText: 'Отримуван для aкту',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white30)),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 255, 149, 0))),
                        onPressed: () {
                          if (widget.onMove != null) {
                            final deliveryDate = DateTime.now();
                            final model = ItemTransferModel(
                                widget.viewModel!.id,
                                Warehouse(
                                    id: widget.viewModel!.warehouse.id,
                                    name: widget.viewModel!.warehouse.name,
                                    cityNameCode: widget.viewModel!.warehouse.cityNameCode,
                                    inventoryItems: widget
                                        .viewModel!.warehouse.inventoryItems));
                            widget.onMove!(model);
                          }
                          // отправить запрос
                        },
                        child: Text(
                          'Видати',
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    iconColor: Color.fromARGB(255, 255, 149, 0),
                    title: Text('Перевести',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Expanded(
                            child: TextField(
                              cursorColor: Color.fromARGB(255, 255, 149, 0),
                              style: TextStyle(color: Colors.white),
                              controller: warehouseController,
                              decoration: InputDecoration(
                                hintText:
                                    'Склад', // Это будет текст по умолчанию, который будет исчезать при вводе
                                hintStyle: TextStyle(color: Colors.grey),
                                // labelText: 'Склад',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white30)),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (queryParam) {
                                if (queryParam.length > 2) {
                                  // Подаем запрос в BLoC
                                  widget.serchWarehouseResult?.call(queryParam);
                                } else {
                                  // Если запрос меньше 2 символов, очищаем список
                                  widget.serchWarehouseResult?.call("");
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              cursorColor: Color.fromARGB(255, 255, 149, 0),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white30)),
                                hintText:
                                    'Количесво', // Это будет текст по умолчанию, который будет исчезать при вводе
                                hintStyle: TextStyle(color: Colors.grey),
                                // labelText: 'Количесво',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 26),
                      ListView.builder(
                        shrinkWrap:
                            true, // чтобы список занимал только необходимое пространство
                        itemCount: widget.filteredWarehouses?.length ?? 0,
                        itemBuilder: (context, index) {
                          final receiver = widget.filteredWarehouses?[index];

                          if (receiver == null) return Container();

                          return ListTile(
                            title: Text(
                              receiver.warehouseName,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              print("receiver.name ${receiver.warehouseName}");
                              warehouseController.text = receiver.warehouseName;
                              widget.cleanResult?.call();
                            },
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 255, 149, 0))),
                        onPressed: () {
                          if (widget.onDelivery != null) {
                            final deliveryDate = DateTime.now();
                            final model = DeliveryItemModel(
                              deliveryDate,
                              id: widget.viewModel!.id,
                              fromLocation: widget.viewModel!.locations.first,
                              toLocation: widget.viewModel!.locations.first,
                              receiver: User("id", "me", "", TypeWorker.admin),
                            );
                            widget.onDelivery!(model);
                          }

                          // отправить запрос
                        },
                        child: Text(
                          'Перевести',
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Positioned(
              //   top: -6,
              //   right: -6,
              //   child: Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              //     decoration: BoxDecoration(
              //       color: const Color.fromARGB(159, 236, 128, 128), // прозрачный красный
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     child: const Text(
              //       'Action',
              //       style: TextStyle(
              //         fontSize: 10,
              //         color: Colors.red, // насыщенный красный текст
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      )
    ]);
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      style: const TextStyle(color: Colors.white),
      maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: Color(0xFF2C2C2C),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _buildAmountField(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Text(
            amount,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ActionTile(
              icon: Icons.shopping_bag,
              label: 'Схожі товари',
              onTap: () async {
                await AutoRouter.of(context)
                    .push<SimilarInventoryItem>(SimilarProductRoute());
//               },
              }),
          _ActionTile(
              icon: Icons.location_on,
              label: 'Локации',
              onTap: () async {
                await AutoRouter.of(context).push<Warehouse>(
                    LocationRoute(productType: InventoryType.laptop));
              }),
          _ActionTile(
              icon: Icons.history,
              label: 'История',
              onTap: () async {
                await AutoRouter.of(context).push(HistoryRoute());
              }),
        ],
      ),
    );
  }

  Widget _buildExpandables() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ExpansionTile(
            tilePadding: EdgeInsetsGeometry.infinity,
            title: const Text('Видати товар',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            children: [
              _buildField(
                  label: 'Кількість', controller: TextEditingController()),
              _buildField(label: 'Кому', controller: TextEditingController()),
              TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 255, 149, 0))),
                  onPressed: () {},
                  child: const Text('Видати')),
            ],
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            title:
                const Text('Перевести', style: TextStyle(color: Colors.white)),
            children: [
              _buildField(label: 'Склад', controller: TextEditingController()),
              _buildField(
                  label: 'Кількість', controller: TextEditingController()),
              TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 255, 149, 0))),
                  onPressed: () {},
                  child: const Text('Перевести')),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: themeDark.canvasColor),
        ),
        child: Column(
          children: [
            // Icon(icon, size: 28, color: Colors.blueAccent),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
