import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/home/bloc/home_bloc.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/edite/bloc/edite/bloc/edit_bloc.dart';
import 'package:sound_level_meter/feature/edite/bloc/edite/repository/edite_repository.dart';
import 'package:sound_level_meter/feature/location/model/location_model.dart';
import 'package:sound_level_meter/feature/similar_product/model/similar_inventory_item.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/feature/ui/theme/theme.dart';
import 'package:sound_level_meter/router/router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sound_level_meter/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@RoutePage()
class EditScreen extends StatefulWidget {
  final InventoryItemView item;
  const EditScreen({super.key, required this.item});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? selectedBrand;
  final Map<int, String?> selectedBrands = {};
  late TextEditingController nameController;
  late TextEditingController usingController;
  late TextEditingController workingController;
  late TextEditingController brokenController;
  late TextEditingController descriptionController;

  final _formKey = GlobalKey<FormState>();
  late EditBloc _editBloc;

  @override
  void dispose() {
    nameController.dispose();
    usingController.dispose();
    workingController.dispose();
    brokenController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _editBloc = EditBloc(EditeRepository([widget.item]));
    _editBloc.add(EditStarted(id: widget.item.id));
    usingController =
        TextEditingController(text: widget.item.usingQuantity.toString());

    workingController =
        TextEditingController(text: widget.item.working.toString());
    descriptionController =
        TextEditingController(text: widget.item.barcode.toString());
    brokenController =
        TextEditingController(text: widget.item.broken.toString());
    nameController = TextEditingController(
      text: widget.item.name.isNotEmpty ? widget.item.name : '',
    );
  }

  Future<void> pickPhotoFromGalery() async {
    final picker = await _picker.pickImage(source: ImageSource.gallery);
    if (picker != null) {
      setState(() {
        _imageFile = picker;
      });
    }
  }

  Future<void> pickPhotoFromCamera() async {
    final picker = await _picker.pickImage(source: ImageSource.camera);
    if (picker != null) {
      print('картинка выбрана ');
      setState(() {
        _imageFile = picker;
      });
    } else {
      print('картинка не выбрана ');
    }
  }

  @override
  Widget build(BuildContext context) {
    int value = 5;
    return CustomScaffold(
      appBarIsVisible: false,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: BlocBuilder<EditBloc, EditState>(
            bloc: _editBloc,
            builder: (context, state) {
              if (state is EditInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EditLoaded) {
                final model = state.updateModel;
                return
                    // InventoryItemEditForm(editModel: model, onSubmit: (model){});
                    SingleChildScrollView(
                        child: InventoryItemEditForm2(
                  // _imageFile,
                  editModel: state.updateModel,
                  onSubmit: (model) {},
                ));
                //  InventoryItemForm(
                //     isReadonly: false,
                //     editModel: state.updateModel,
                //     onSubmit: (model) {}));
                //    InventoryItemForm(
                //  isReadonly: true,
                //  editModel: state.updateModel,
                //   ),
                //     Column(
                //   children: [
                //     SizedBox(
                //       height: 10,
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         pickPhotoFromCamera();
                //         print('open camera');
                //       },
                //       child: Container(
                //         height: MediaQuery.of(context).size.height * 0.2,
                //         width: MediaQuery.of(context).size.width * 0.5,
                //         decoration: BoxDecoration(color: Colors.blueAccent),
                //         child: LayoutBuilder(builder: (context, constraints) {
                //           final containerHeight = constraints.maxHeight;
                //           return Center(
                //             child: Padding(
                //               padding: const EdgeInsets.only(top: 20.0),
                //               child: Column(
                //                 children: [
                //                   _imageFile != null
                //                       ? Image.file(
                //                           File(_imageFile!.path),
                //                           height: containerHeight * 0.4,
                //                           width: containerHeight * 0.4,
                //                           fit: BoxFit.cover,
                //                         )
                //                       : Icon(Icons.camera_alt,
                //                           color: Colors.white,
                //                           size: containerHeight * 0.4),
                //                   SizedBox(
                //                     height: 12,
                //                   ),
                //                   Material(
                //                     elevation: 10,
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(10)),
                //                     child: InkWell(
                //                       radius: 20,
                //                       borderRadius: BorderRadius.circular(20),
                //                       child: TextButton(
                //                           onPressed: () {
                //                             pickPhotoFromGalery();
                //                           },
                //                           child: Text(
                //                               S.of(context).pickAnImage)),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           );
                //         }),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(top: 10, bottom: 10),
                //       child: TextFormField(
                //         style: TextStyle(color: Colors.white),
                //         controller: nameController,
                //         decoration: InputDecoration(
                //           // Плейсхолдер если поле пустое
                //           labelText: 'Product Name',

                //           labelStyle: themeDark.textTheme.labelSmall,
                //         ),
                //         validator: (value) {
                //           if (value == null || value.isEmpty) {
                //             return 'Пожалуйста, введите имя';
                //           }
                //           return null;
                //         },
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(top: 10.0),
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: TextField(
                //                 decoration: InputDecoration(
                //                     labelText: 'Serial number ',
                //                     labelStyle:
                //                         TextStyle(color: Colors.white)),
                //                 keyboardType: TextInputType.number),
                //           ),
                //           SizedBox(
                //             width: 8,
                //           ),
                //           IconButton(
                //             icon: Icon(Icons.qr_code_scanner),
                //             color: Colors.white,
                //             tooltip: 'Scan',
                //             onPressed: () {
                //               // Открыть камеру для сканирования
                //             },
                //           )
                //         ],
                //       ),
                //     ),

                //     Padding(
                //       padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                //       child: TextField(
                //         style: TextStyle(color: Colors.white),
                //         controller: descriptionController,
                //         decoration: InputDecoration(
                //             labelText: 'Description',
                //             labelStyle: themeDark.textTheme.labelSmall),
                //         keyboardType: TextInputType.text,
                //         minLines: 1,
                //         maxLines: 4,
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                //       child: TextFormField(
                //           style: TextStyle(color: Colors.white),
                //           controller: workingController,
                //           decoration: InputDecoration(
                //               labelText: 'Working Quantity',
                //               labelStyle: themeDark.textTheme.labelSmall),
                //           validator: (value) {
                //             if (value == null || value.isEmpty) {
                //               return S.of(context).plsEnterPassword;
                //               ;
                //             }
                //             final number = int.parse(value);
                //             if (number == null) {
                //               return 'Некорректное число';
                //             }

                //             if (number < 0) {
                //               return 'Число должно быть ≥ 0';
                //             }

                //             return null;
                //           }),
                //     ),

                //     Padding(
                //       padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                //       child: TextFormField(
                //           style: TextStyle(color: Colors.white),
                //           controller: brokenController,
                //           inputFormatters: [
                //             FilteringTextInputFormatter.allow(
                //                 RegExp(r'^\d*\.?\d*')),
                //           ],
                //           keyboardType: TextInputType.number,
                //           // style: themeDark.textTheme.labelSmall,
                //           decoration: InputDecoration(
                //               labelText: 'Broken Quantity',
                //               labelStyle: themeDark.textTheme.labelSmall),
                //           validator: (value) {
                //             if (value == null || value.isEmpty) {
                //               return 'Inut number';
                //             }
                //             final number = int.parse(value);
                //             if (number == null) {
                //               return 'Некорректное число';
                //             }

                //             if (number < 0) {
                //               return 'Число должно быть ≥ 0';
                //             }

                //             return null;
                //           }),
                //     ),
                //     // тут бедем брать с запроса

                //     Padding(
                //       padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                //       child: IgnorePointer(
                //         child: TextField(
                //           readOnly: true,
                //           decoration: InputDecoration(
                //               labelText: '',
                //               // 'Количество в использовании ${int.parse(.text) > 0 ? int.parse(totalCount.text) : "нет данных"}',
                //               labelStyle: themeDark.textTheme.labelSmall),
                //           keyboardType: TextInputType.text,
                //         ),
                //       ),
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         // Expanded(
                //         // child:
                //         Card(
                //           color: const Color(0xFF1E1E1E),
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(12)),
                //           elevation: 10,
                //           child: Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 // Кнопка "История объекта"
                //                 TextButton.icon(
                //                   onPressed: () async {
                //                     await AutoRouter.of(context)
                //                         .push(HistoryRoute());

                //                     // Navigator.push(
                //                     //   context,
                //                     //   MaterialPageRoute(builder: (context) => HistoryScreen()),
                //                     // );
                //                   },
                //                   icon: Icon(
                //                     Icons.history,
                //                     color: Colors.white,
                //                   ),
                //                   label: Text('История объекта',
                //                       style: TextStyle(color: Colors.white)),
                //                   style: TextButton.styleFrom(
                //                     // padding: EdgeInsets.symmetric(
                //                     //     vertical: 12, horizontal: 16),
                //                     alignment: Alignment.bottomLeft,
                //                   ),
                //                 ),

                //                 SizedBox(height: 8),

                //                 // Кнопка "Схожие товары"
                //                 TextButton.icon(
                //                   onPressed: () async {
                //                     // await AutoRouter.of(context)
                //                     //     .push<TechniqueList>(
                //                     //         SimilarProductRoute());

                //                     // Navigator.push(
                //                     //   context,
                //                     //   // MaterialPageRoute(builder: (context) => SimilarProductsScreen()),
                //                     // );
                //                   },
                //                   icon: Icon(
                //                     Icons.shopping_bag,
                //                     color: Colors.white,
                //                   ),
                //                   label: Text('Схожие товары',
                //                       style: TextStyle(color: Colors.white)),
                //                   style: TextButton.styleFrom(
                //                     padding: EdgeInsets.symmetric(
                //                         vertical: 12, horizontal: 16),
                //                     alignment: Alignment.centerLeft,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         // ),
                //         // Expanded(
                //         // child:
                //         Card(
                //           color: const Color(0xFF1E1E1E),
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(12)),
                //           elevation: 10,
                //           child: Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 // Кнопка "Перевесті"
                //                 TextButton.icon(
                //                   onPressed: () async {
                //                     // await AutoRouter.of(context)
                //                     //     .push<In>(
                //                     //         HistoryRoute());
                //                   },
                //                   icon: Icon(
                //                     Icons.history,
                //                     color: Colors.white,
                //                   ),
                //                   label: Text(
                //                     'Перевести',
                //                     style: TextStyle(color: Colors.white),
                //                   ),
                //                   style: TextButton.styleFrom(
                //                     padding: EdgeInsets.symmetric(
                //                         vertical: 12, horizontal: 16),
                //                     alignment: Alignment.centerLeft,
                //                   ),
                //                 ),

                //                 SizedBox(height: 8),

                //                 // Кнопка "Видать"
                //                 TextButton.icon(
                //                   onPressed: () {
                //                     // Navigator.push(
                //                     //   context,
                //                     //   // MaterialPageRoute(builder: (context) => SimilarProductsScreen()),
                //                     // );
                //                   },
                //                   icon: Icon(
                //                     Icons.shopping_bag,
                //                     color: Colors.white,
                //                   ),
                //                   label: Text(
                //                     'Выдать',
                //                     style: TextStyle(color: Colors.white),
                //                   ),
                //                   style: TextButton.styleFrom(
                //                     padding: EdgeInsets.symmetric(
                //                         vertical: 12, horizontal: 16),
                //                     alignment: Alignment.centerLeft,
                //                   ),
                //                 ),
                //                 TextButton.icon(
                //                   onPressed: () async {
                //                     await AutoRouter.of(context)
                //                         .push<InventoryItemEdit>(
                //                             LocationRoute());
                //                     // Navigator.push(
                //                     //   context,
                //                     //   MaterialPageRoute(builder: (context) => HistoryScreen()),
                //                     // );
                //                   },
                //                   icon: Icon(
                //                     Icons.history,
                //                     color: Colors.white,
                //                   ),
                //                   label: Text('Локации',
                //                       style: TextStyle(color: Colors.white)),
                //                   style: TextButton.styleFrom(
                //                     padding: EdgeInsets.symmetric(
                //                         vertical: 12, horizontal: 16),
                //                     alignment: Alignment.centerLeft,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         // ),
                //       ],
                //     ),
                //     // Expanded(
                //     // child:
                //     Container(
                //       child: ListView.builder(
                //           shrinkWrap: true,
                //           itemCount: 1,
                //           itemBuilder: (context, index) {
                //             return AdaptiveBrandSelector(
                //                 selectedBrand: selectedBrands[0],
                //                 brands: ['Apple', 'Samsung', 'Xiaomi'],
                //                 textOfBrand: 'Brend',
                //                 onBrandSelected: (brand) {
                //                   setState(() {
                //                     selectedBrands[0] = brand;
                //                   });
                //                 });
                //           }),
                //     ),
                //     // ),

                //     Container(
                //       color: const Color(0xFF1E1E1E),
                //       child: ListView.builder(
                //           itemCount: 1,
                //           shrinkWrap: true,
                //           itemBuilder: (context, index) {
                //             return AdaptiveBrandSelector(
                //                 selectedBrand: selectedBrands[1],
                //                 brands: [
                //                   'Comp',
                //                   'Mouse',
                //                   'Keyboard',
                //                   'Micropphone'
                //                 ],
                //                 textOfBrand: 'Type',
                //                 onBrandSelected: (brand) {
                //                   setState(() {
                //                     selectedBrands[1] = brand;
                //                   });
                //                 });
                //           }),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: SizedBox(
                //         width: double.infinity,
                //         child: CupertinoButton(
                //             color: const Color(0xFF1E1E1E),
                //             padding: const EdgeInsets.symmetric(
                //                 vertical: 16.0), // высота кнопки
                //             child: Text(
                //               'Готово',
                //               style: TextStyle(
                //                   color: Colors.blue), // так как фон белый
                //             ),
                //             onPressed: () {
                //               // if (_formKey.currentState!.validate()) {
                //               final updatedItem = InventoryItemView(
                //                 id: widget.item.id,
                //                 name: nameController.text,
                //                 brand: selectedBrand ?? '',
                //                 // description: descriptionController.text,
                //                 // t: int.parse(totalCount.text),
                //                 working: int.parse(workingController.text),
                //                 broken: int.parse(brokenController.text),

                //                 total: 0,
                //               );

                //               //  Navigator.of(context).pop(updatedItem);

                //               context.router.pop(updatedItem);
                //             }
                //             // }
                //             //  => Navigator.of(context).pop(),
                //             ),
                //       ),
                //     )
                //   ],
                // ),
                // );
              } else if (state is HomeError) {
                // надо сделать обработчик обибок обьект
                return Text(
                    'Error: ${state.toString() ?? "Smth happend pls try again"}');
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}

class AdaptiveBrandSelector extends StatelessWidget {
  final String textOfBrand;
  final String? selectedBrand;
  final List<String> brands;
  final Function(String) onBrandSelected;

  const AdaptiveBrandSelector({
    super.key,
    required this.selectedBrand,
    required this.brands,
    required this.textOfBrand,
    required this.onBrandSelected,
  });

  void _showCupertinoPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (index) {
                  onBrandSelected(brands[index]);
                },
                children: brands
                    .map((b) => Text(
                          b,
                        ))
                    .toList(),
              ),
            ),
            CupertinoButton(
              child: Text('Готово'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return ListTile(
        title: Text(
          textOfBrand,
          style: themeDark.textTheme.labelSmall,
        ),
        titleAlignment: ListTileTitleAlignment.center,
        subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              selectedBrand ?? S.of(context).chose_picker,
              style: themeDark.textTheme.labelSmall,
            )),
        trailing: const Icon(CupertinoIcons.chevron_forward),
        onTap: () => _showCupertinoPicker(context),
      );
    } else {
      return DropdownButtonFormField<String>(
        value: selectedBrand,
        items: brands
            .map((brand) => DropdownMenuItem(
                  value: brand,
                  child: Text(brand),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) onBrandSelected(value);
        },
        decoration: const InputDecoration(
          labelText: 'Бренд',
        ),
      );
    }
  }
}

class CustomCuertinoButtom extends StatelessWidget {
  //  bool? isSelected;
  const CustomCuertinoButtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0), // высота кнопки
          child: Text(
            'Готово',
            style: TextStyle(color: Colors.black), // так как фон белый
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class InventoryItemForm extends StatefulWidget {
  final bool isReadonly;
  final InventoryItemEdit? editModel;
  final InventoryItemDetails? viewModel;
  final void Function(InventoryItemEdit)? onSubmit;
  final void Function()? pickPhotoFromGalery;
  final void Function()? pickPhotoFromCamera;
  final XFile? imageFile;

  const InventoryItemForm(
      {super.key,
      this.isReadonly = false,
      this.editModel,
      this.viewModel,
      this.onSubmit,
      this.pickPhotoFromGalery,
      this.pickPhotoFromCamera,
      this.imageFile});

  @override
  State<InventoryItemForm> createState() => _InventoryItemFormState();
}

class _InventoryItemFormState extends State<InventoryItemForm> {
  final quantityController = TextEditingController();

  final recipientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(
        text: widget.isReadonly
            ? widget.viewModel?.name
            : widget.editModel?.name);
    final usingController = TextEditingController(
        text:
            widget.isReadonly ? widget.viewModel?.usedQuantity.toString() : "");
    final descriptionController = TextEditingController(
        text: widget.isReadonly
            ? widget.viewModel?.description
            : widget.editModel?.description);
    final workingController = TextEditingController(
      text: widget.isReadonly
          ? widget.viewModel?.workingQuantity.toString()
          : widget.editModel?.workingCount.toString(),
    );
    final brokenController = TextEditingController(
      text: widget.isReadonly
          ? widget.viewModel?.brokenQuantity.toString()
          : widget.editModel?.brokenCount.toString(),
    );

    return Column(children: [
      if (!widget.isReadonly) ...[updatePhoto(context)] else
        Icon(Icons.inventory, size: 80, color: Colors.grey),
      SizedBox(height: 16),
      //TODO: c Фото и сериал и надо добавить дефотллнутную картинку
      if (widget.viewModel?.imagePath != null ||
          widget.editModel?.photoPath != null)
        Image.asset(
            widget.viewModel?.imagePath ?? widget.editModel!.photoPath! ?? ''),

      TextFormField(
        enabled: !widget.isReadonly,
        style: TextStyle(color: Colors.white),
        controller: nameController,
        decoration: InputDecoration(
          labelText: 'Product Name',
          labelStyle: themeDark.textTheme.labelSmall,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Пожалуйста, введите имя';
          }
          return null;
        },
      ),

      // TextFormField(
      //   controller: nameController,
      //   enabled: !isReadonly,
      //   decoration: InputDecoration(labelText: 'Назва'),
      // ),

      // TextFormField(
      //   controller: descriptionController,
      //   enabled: !isReadonly,

      //   decoration: InputDecoration(labelText: 'Опис'),
      // ),

      TextField(
        enabled: !widget.isReadonly,
        style: TextStyle(color: Colors.white),
        controller: descriptionController,
        decoration: InputDecoration(
            labelText: 'Description',
            labelStyle: themeDark.textTheme.labelSmall),
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 4,
      ),

      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                  enabled: !widget.isReadonly,
                  decoration: InputDecoration(
                      labelText: 'Serial number ',
                      labelStyle: TextStyle(color: Colors.white)),
                  keyboardType: TextInputType.number),
            ),
            SizedBox(
              width: 8,
            ),
            if (!widget.isReadonly) ...{
              IconButton(
                icon: Icon(Icons.qr_code_scanner),
                color: Colors.white,
                tooltip: 'Scan',
                onPressed: () {
                  // Открыть камеру для сканирования
                },
              )
            }
          ],
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: TextFormField(
            style: TextStyle(color: Colors.white),
            controller: workingController,
            enabled: !widget.isReadonly,
            decoration: InputDecoration(
                labelText: 'Working Quantity',
                labelStyle: themeDark.textTheme.labelSmall),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).plsEnterPassword;
                ;
              }
              final number = int.parse(value);
              if (number == null) {
                return 'Некорректное число';
              }

              if (number < 0) {
                return 'Число должно быть ≥ 0';
              }

              return null;
            }),
      ),

      // Сломанные
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: TextFormField(
            enabled: !widget.isReadonly,
            style: TextStyle(color: Colors.white),
            controller: brokenController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            keyboardType: TextInputType.number,
            // style: themeDark.textTheme.labelSmall,
            decoration: InputDecoration(
                labelText: 'Broken Quantity',
                labelStyle: themeDark.textTheme.labelSmall),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inut number';
              }
              final number = int.parse(value);
              if (number == null) {
                return 'Некорректное число';
              }

              if (number < 0) {
                return 'Число должно быть ≥ 0';
              }

              return null;
            }),
      ),

      const SizedBox(height: 16),
      if (!widget.isReadonly)
        Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return AdaptiveBrandSelector(
                    selectedBrand: 'Apple',
                    brands: ['Apple', 'Samsung', 'Xiaomi'],
                    textOfBrand: 'Brend',
                    onBrandSelected: (brand) {
                      // setState(() {
                      //   selectedBrands[0] = brand;
                      // });
                    });
              }),
        ),
      // ),
      SizedBox(
        height: 16,
      ),
      if (!widget.isReadonly)
        Container(
          color: const Color(0xFF1E1E1E),
          child: ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AdaptiveBrandSelector(
                    selectedBrand: 'Com',
                    brands: ['Comp', 'Mouse', 'Keyboard', 'Micropphone'],
                    textOfBrand: 'Type',
                    onBrandSelected: (brand) {
                      // setState(() {
                      //   selectedBrands[1] = brand;
                      // });
                    });
              }),
        ),
      // SizedBox(height: 16,),

      if (!widget.isReadonly && widget.onSubmit != null)
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0), // высота кнопки
                  child: Text(
                    'Готово',
                    style: TextStyle(color: Colors.black), // так как фон белый
                  ),

                  onPressed: () => widget.onSubmit!(
                    InventoryItemEdit(
                      id: widget.editModel!.id,
                      name: nameController.text,
                      brand: widget.editModel!.brand,
                      type: widget.editModel!.type,
                      description: widget.editModel!.description,
                      workingCount: widget.editModel!.workingCount,
                      brokenCount: widget.editModel!.brokenCount,
                    ),
                  ),
                ))),

      // if (!isReadonly && onSubmit != null)
      //   ElevatedButton(
      //     onPressed: () {
      //       onSubmit!(
      //         InventoryItemEdit(
      //           id: editModel!.id,
      //           name: nameController.text,
      //           brand: editModel!.brand,
      //           type: editModel!.type,
      //           description: descriptionController.text,
      //           workingCount: int.tryParse(workingController.text) ?? 0,
      //           brokenCount: int.tryParse(brokenController.text) ?? 0,
      //         ),
      //       );
      //     },
      //     child: Text('Зберегти'),
      //   ),
      // if (isReadonly) ...[
      //   Card(child:
      //    Column(children: [
      //   Text(
      //     'Кількість у використанні: ${viewModel!.usedQuantity}',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   Text('Локації: ${viewModel!.locations.join(', ')}',
      //       style: TextStyle(color: Colors.black)),
      //   SizedBox(
      //     height: 16,
      //   ),
      //   Row(
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           // TODO: навигация на "видати"
      //         },
      //         child: Text('Видати'),
      //       ),
      //       const SizedBox(width: 8),
      //       ElevatedButton(
      //         onPressed: () {
      //           print("Перевести");
      //           // TODO: навигация на "перевести"
      //         },
      //         child: Text('Перевести'),
      //       ),
      //     ],
      //   ),

      //   const SizedBox(height: 16),
      //   Row(
      //     children: [
      //       ElevatedButton.icon(
      //         onPressed: () {
      //           print("History");
      //           // TODO: навигация на історію
      //         },
      //         icon: Icon(Icons.history),
      //         label: Text('Історія обʼєкта'),
      //       ),
      //       ElevatedButton.icon(
      //         onPressed: () {
      //           print("Похожие товари ");
      //           // TODO: навигация на схожі товари
      //         },
      //         icon: Icon(Icons.shopping_bag),
      //         label: Text('Схожі товари'),
      //       ),
      //     ],
      //   ),
      // ],
      //    )
      //    )
      //    ]

      if (widget.isReadonly) ...[
        Row(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 14),
                children: [
                  const TextSpan(text: 'Кількість у використанні: '),
                  TextSpan(
                    text: '${widget.viewModel!.usedQuantity}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(color: const Color(0xFF1E1E1E)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActionTile(
                icon: Icons.shopping_bag,
                label: 'Схожі товари',
                onTap: () async {
                  await AutoRouter.of(context)
                      .push<SimilarInventoryItem>(SimilarProductRoute());
                  // TODO
                },
              ),
              _ActionTile(
                icon: Icons.shopping_bag,
                label: 'Локации',
                onTap: () async {
                  await AutoRouter.of(context).push<LocationModel>(
                      LocationRoute(productType: InventoryType.laptop));
                },
              ),
              _ActionTile(
                icon: Icons.shopping_bag,
                label: 'История',
                onTap: () async {
                  await AutoRouter.of(context)
                      .push<SimilarInventoryItem>(HistoryRoute());
                  // TODO
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: Text(
                    'Видати товар',
                    style: TextStyle(color: Colors.white),
                  ),
                  
                  children: [
                    // Поля внутри раскрытого блока
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: quantityController,
                            decoration: InputDecoration(
                              labelText: 'Кількість',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white30)
                              ),
                              border: OutlineInputBorder(
                                
                              ),
                              
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: recipientController,
                            decoration: InputDecoration(
                              labelText: 'Кому',
                              labelStyle: TextStyle(color: Colors.white),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white30)
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Добавляем другие поля, которые нужно показать внутри "Видати товар"
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Отримуван для к',
                        labelStyle: TextStyle(color: Colors.white),
                         focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white30)
                              ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        
                        // отправить запрос
                      },
                      child: Text('Видати'),
                    )
                  ],
                ),
                SizedBox(height: 16),
                ExpansionTile(
                  title:
                      Text('Перевести', style: TextStyle(color: Colors.white)),
                  children: [
                    // Поля внутри раскрытого блока для "Перевести"
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Склад',
                              labelStyle: TextStyle(color: Colors.white),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white30)
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white30)
                              ),
                              labelText: 'Количесво',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // отправить запрос
                      },
                      child: Text('Перевести'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        // )
      ]
    ]);
  }

  Widget updatePhoto(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.pickPhotoFromCamera!();
        print('open camera');
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: LayoutBuilder(builder: (context, constraints) {
          final containerHeight = constraints.maxHeight;
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  widget.imageFile != null
                      ? Image.file(
                          File(widget.imageFile!.path),
                          height: containerHeight * 0.4,
                          width: containerHeight * 0.4,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.camera_alt,
                          color: Colors.white, size: containerHeight * 0.4),
                  SizedBox(
                    height: 12,
                  ),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      radius: 20,
                      borderRadius: BorderRadius.circular(20),
                      child: TextButton(
                          onPressed: () {
                            widget.pickPhotoFromGalery!();
                          },
                          child: Text(S.of(context).pickAnImage)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
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
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// class InventoryItemEditForm extends StatelessWidget {
//   final InventoryItemEdit editModel;
//   final void Function(InventoryItemEdit) onSubmit;
//   final void Function()? pickPhotoFromGalery;
//   final void Function()? pickPhotoFromCamera;
//   final XFile? imageFile;

//   const InventoryItemEditForm({
//     super.key,
//     required this.editModel,
//     required this.onSubmit,
//     this.pickPhotoFromGalery,
//     this.pickPhotoFromCamera,
//     this.imageFile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final nameController = TextEditingController(text: editModel.name);
//     final descriptionController =
//         TextEditingController(text: editModel.description ?? '');
//     final workingController =
//         TextEditingController(text: editModel.workingCount.toString());
//     final brokenController =
//         TextEditingController(text: editModel.brokenCount.toString());

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _PhotoPicker(
//           imageFile: imageFile,
//           onCameraTap: pickPhotoFromCamera,
//           onGalleryTap: pickPhotoFromGalery,
//         ),
//         SizedBox(height: 16),
//         _buildTextField(context, 'Назва', nameController),
//         _buildTextField(context, 'Опис', descriptionController, maxLines: 3),
//         _buildTextField(context, 'Кількість робочих', workingController,
//             inputType: TextInputType.number),
//         _buildTextField(context, 'Кількість неробочих', brokenController,
//             inputType: TextInputType.number),
//         SizedBox(height: 16),
//         AdaptiveBrandSelector(
//           textOfBrand: 'Бренд',
//           selectedBrand: editModel.brand,
//           brands: ['Apple', 'Samsung', 'Xiaomi'],
//           onBrandSelected: (brand) {},
//         ),
//         SizedBox(height: 16),
//         AdaptiveBrandSelector(
//           textOfBrand: 'Тип',
//           selectedBrand: editModel.type,
//           brands: ['Телефон', 'Планшет', 'Ноутбук'],
//           onBrandSelected: (type) {},
//         ),
//         SizedBox(height: 24),
//         CupertinoButton.filled(
//           child: Text('Зберегти'),
//           onPressed: () {
//             onSubmit(
//               InventoryItemEdit(
//                 id: editModel.id,
//                 name: nameController.text,
//                 brand: editModel.brand,
//                 type: editModel.type,
//                 description: descriptionController.text,
//                 workingCount: int.tryParse(workingController.text) ?? 0,
//                 brokenCount: int.tryParse(brokenController.text) ?? 0,
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }

//   Widget _buildTextField(
//       BuildContext context, String label, TextEditingController controller,
//       {int maxLines = 1, TextInputType inputType = TextInputType.text}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: inputType,
//         maxLines: maxLines,
//         style: TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: themeDark.textTheme.labelSmall,
//         ),
//       ),
//     );
//   }
// }

class _PhotoPicker extends StatelessWidget {
  final XFile? imageFile;
  final void Function(ImageSource source) onTap;
  // final VoidCallback? onGalleryTap;

  const _PhotoPicker({
    required this.imageFile,
    required this.onTap,
    // required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.2;

    return GestureDetector(
      onTap: () => onTap(ImageSource.camera),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageFile != null
                  ? Image.file(File(imageFile!.path), height: height * 0.5)
                  : Icon(Icons.camera_alt,
                      color: Colors.white, size: height * 0.4),
              SizedBox(height: 12),
              TextButton(
                onPressed: () => onTap(ImageSource.gallery),
                child: Text('Вибрати з галереї',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class InventoryItemEditF extends StatelessWidget {
//   final InventoryItemEdit editModel;
//   final void Function(InventoryItemEdit) onSubmit;

//   const InventoryItemEditF({
//     Key? key,
//     required this.editModel,
//     required this.onSubmit,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final serialNumberController =
//         TextEditingController(text: editModel.serialNumber);
//     final brandController = TextEditingController(text: editModel.brand);
//     final typeController = TextEditingController(text: editModel.type);
//     final workerCountController =
//         TextEditingController(text: editModel.workingCount.toString());
//     final nonWorkerCountController =
//         TextEditingController(text: editModel.brokenCount.toString());

//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             // Логика для выбора фото из галереи
//           },
//           child: Container(
//             padding: EdgeInsets.all(16),
//             color: Colors.grey[300],
//             child: Text('Вибрати фото'),
//           ),
//         ),
//         SizedBox(height: 16),
//         TextField(
//           controller: serialNumberController,
//           decoration: InputDecoration(
//             labelText: 'Серійний номер',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 16),
//         TextField(
//           controller: brandController,
//           decoration: InputDecoration(
//             labelText: 'Бренд',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 16),
//         TextField(
//           controller: typeController,
//           decoration: InputDecoration(
//             labelText: 'Тип',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: workerCountController,
//                 decoration: InputDecoration(
//                   labelText: 'Кількість робочих',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//             SizedBox(width: 8),
//             Expanded(
//               child: TextField(
//                 controller: nonWorkerCountController,
//                 decoration: InputDecoration(
//                   labelText: 'Кількість не робочих',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         ElevatedButton(
//           onPressed: () {
//             // final updatedModel = InventoryItem(
//             //   serialNumber: serialNumberController.text,
//             //   brand: brandController.text,
//             //   type: typeController.text,
//             //   workerCount: int.tryParse(workerCountController.text) ?? 0,
//             //   nonWorkerCount: int.tryParse(nonWorkerCountController.text) ?? 0,
//             // );
//             // onSubmit(updatedModel);
//           },
//           child: Text('Зберегти'),
//         ),
//       ],
//     );
//   }
// }

class InventoryItemEditForm2 extends StatefulWidget {
  final InventoryItemEdit editModel;
  final XFile? imageFile;
  final void Function(InventoryItemEdit) onSubmit;

  const InventoryItemEditForm2({
    Key? key,
    required this.editModel,
    required this.onSubmit,
    this.imageFile,
  }) : super(key: key);

  @override
  _InventoryItemEditForm2State createState() => _InventoryItemEditForm2State();
}

class _InventoryItemEditForm2State extends State<InventoryItemEditForm2> {
  late TextEditingController serialNumberController;
  late TextEditingController brandController;
  late TextEditingController typeController;
  late TextEditingController workerCountController;
  late TextEditingController nonWorkerCountController;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    serialNumberController =
        TextEditingController(text: widget.editModel.serialNumber);
    brandController = TextEditingController(
        text: widget.editModel.brand.toString().split('.').last);
    typeController = TextEditingController(
        text: widget.editModel.type.toString().split('.').last);
    workerCountController =
        TextEditingController(text: widget.editModel.workingCount.toString());
    nonWorkerCountController =
        TextEditingController(text: widget.editModel.brokenCount.toString());

    _imageFile = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhotoPicker(
          imageFile: _imageFile,
          onTap: pickPhotoFrom,
        ),
        SizedBox(height: 100),

        // Серийный номер
        TextField(
          controller: serialNumberController,
          decoration: InputDecoration(
            labelText: 'Серійний номер',
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 16),

        // Бренд
        DropdownButtonFormField<String>(
          value: brandController.text,
          selectedItemBuilder: (BuildContext context) {
            return InventoryBrand.values.map<Widget>((InventoryBrand brand) {
              return Text(
                brand.toString().split('.').last,
                style: TextStyle(color: Colors.white), // Белый для выбранного
              );
            }).toList();
          },
          onChanged: (value) {
            setState(() {
              brandController.text = value!;
            });
          },
          decoration: InputDecoration(
            labelText: 'Бренд',
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(),
          ),
          items: InventoryBrand.values
              .map<DropdownMenuItem<String>>((InventoryBrand brand) {
            return DropdownMenuItem<String>(
              value:
                  brand.toString().split('.').last, // Преобразуем enum в строку
              child: Text(
                brand.toString().split('.').last, // Отображаем название бренда
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 16),

        // Тип
        DropdownButtonFormField<String>(
          value: typeController.text,
          selectedItemBuilder: (BuildContext context) {
            return InventoryType.values.map<Widget>((InventoryType type) {
              return Text(
                type.toString().split('.').last,
                style: TextStyle(color: Colors.white), // Белый для выбранного
              );
            }).toList();
          },
          onChanged: (value) {
            setState(() {
              typeController.text = value!;
            });
          },
          decoration: InputDecoration(
            labelText: 'Тип',
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(),
          ),
          items: InventoryType.values
              .map<DropdownMenuItem<String>>((InventoryType type) {
            return DropdownMenuItem<String>(
              value:
                  type.toString().split('.').last, // Преобразуем enum в строку
              child: Text(
                type.toString().split('.').last, // Отображаем название бренда
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 16),

        // Количество рабочих
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: workerCountController,
                decoration: InputDecoration(
                  labelText: 'Кількість робочих',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                setState(() {
                  int currentValue =
                      int.tryParse(workerCountController.text) ?? 0;
                  if (currentValue > 0) {
                    workerCountController.text = (currentValue - 1).toString();
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                setState(() {
                  int currentValue =
                      int.tryParse(workerCountController.text) ?? 0;
                  workerCountController.text = (currentValue + 1).toString();
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16),

        // Количество нерабочих
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: nonWorkerCountController,
                decoration: InputDecoration(
                  labelText: 'Кількість не робочих',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                setState(() {
                  int currentValue =
                      int.tryParse(nonWorkerCountController.text) ?? 0;
                  if (currentValue > 0) {
                    nonWorkerCountController.text =
                        (currentValue - 1).toString();
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                setState(() {
                  int currentValue =
                      int.tryParse(nonWorkerCountController.text) ?? 0;
                  nonWorkerCountController.text = (currentValue + 1).toString();
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16),

        // Кнопка "Зберегти"
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // final updatedModel = (
                //   serialNumber: serialNumberController.text,
                //   brand: brandController.text,
                //   type: typeController.text,
                //   workingCount: int.tryParse(workerCountController.text) ?? 0,
                //   brokenCount: int.tryParse(nonWorkerCountController.text) ?? 0,
                // );
                // widget.onSubmit(updatedModel);
              },
              // style: ElevatedButton.styleFrom(: Colors.purple),
              child: Text('Зберегти'),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> pickPhotoFrom(ImageSource type) async {
    final picker = await _picker.pickImage(source: type);
    if (picker != null) {
      print('картинка выбрана ');
      setState(() {
        _imageFile = picker;
      });
    } else {
      print('картинка не выбрана ');
    }
  }
}
