import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/detail/bloc/detail/bloc/detail_bloc.dart';
import 'package:sound_level_meter/feature/detail/model/move_item_model.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/home/bloc/home_bloc.dart';
import 'package:sound_level_meter/feature/home/filter/view/filtre_screen.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/edite/bloc/edite/bloc/edit_bloc.dart';
import 'package:sound_level_meter/feature/edite/bloc/edite/repository/edite_repository.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/similar_product/model/similar_inventory_item.dart';
import 'package:sound_level_meter/feature/ui/custom_action_button.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/feature/ui/theme/theme.dart';
import 'package:sound_level_meter/feature/ui/photo_picker.dart';
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
       appBarMode: AppBarMode.titleOnly,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: BlocBuilder<EditBloc, EditState>(
            bloc: _editBloc,
            builder: (context, state) {
              if (state is EditInitial) {
                return Center(child: CustomLoadingIndicator());
              } else if (state is EditLoaded) {
                final model = state.updateModel;
                return SingleChildScrollView(
                    child: InventoryItemEditForm2(
                  editModel: state.updateModel,
                  onSubmit: (model) {},
                ));
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
  final String label;
  //  bool? isSelected;
  const CustomCuertinoButtom({
    super.key, required this.label,
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
            label,
            style: TextStyle(color: Colors.black), // так как фон белый
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

// class _PhotoPicker extends StatelessWidget {
//   final XFile? imageFile;
//   final void Function(ImageSource source) onTap;
//   // final VoidCallback? onGalleryTap;

//   const _PhotoPicker({
//     required this.imageFile,
//     required this.onTap,
//     // required this.onGalleryTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height * 0.2;

//     return GestureDetector(
//       onTap: () => onTap(ImageSource.camera),
//       child: Container(
//         height: height,
//         width: double.infinity,
//         decoration: BoxDecoration(color: Colors.blueAccent),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               imageFile != null
//                   ? Image.file(File(imageFile!.path), height: height * 0.5)
//                   : Icon(Icons.camera_alt,
//                       color: Colors.white, size: height * 0.4),
//               SizedBox(height: 12),
//               TextButton(
//                 onPressed: () => onTap(ImageSource.gallery),
//                 child: Text('Вибрати з галереї',
//                     style: TextStyle(color: Colors.white)),
//               )
//             ],
//           ),
//         ),
//       ),
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
        CustomPhotoPicker(
          imageFile: _imageFile,
          onTap: pickPhotoFrom,
        ),
        SizedBox(height: 24),

        // Серийный номер
        TextField(
          controller: serialNumberController,
          decoration: InputDecoration(
            fillColor: Color(0xFF2C2C2C),
            filled: true,
            hintText: 'Серійний номер', // Плейсхолдер для пустого поля
            hintStyle: TextStyle(
                color: Colors.white
                    .withOpacity(0.6)), // Тонкий цвет для placeholder

            labelText: serialNumberController.text.isEmpty
                ? null
                : 'Серійний номер', // Убираем labelText, если поле пустое
            labelStyle: TextStyle(color: Colors.white), // Стиль для метки
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFF2C2C2C)), // Цвет бордера при фокусе
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: TextStyle(color: Colors.white), // Стиль для текста внутри поля
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
            fillColor: Color(0xFF2C2C2C),
            filled: true,
            labelText: 'Бренд',
            labelStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF2C2C2C)),
            ),
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
            fillColor: Color(0xFF2C2C2C),
            filled: true,
            labelText: 'Тип',
            labelStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF2C2C2C)),
            ),
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
                  fillColor: Color(0xFF2C2C2C),
                  filled: true,
                  labelText: 'Кількість робочих',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF2C2C2C)), // Цвет бордера при фокусе
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
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
                  fillColor: Color(0xFF2C2C2C),
                  filled: true,
                  labelText: 'Кількість не робочих',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF2C2C2C)), // Цвет бордера при фокусе
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
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
            child: GoldenButton(label: "Зберегти", onPressed:() {

            },)
            // ElevatedButton(
            //   onPressed: () {
            //     // final updatedModel = (
            //     //   serialNumber: serialNumberController.text,
            //     //   brand: brandController.text,
            //     //   type: typeController.text,
            //     //   workingCount: int.tryParse(workerCountController.text) ?? 0,
            //     //   brokenCount: int.tryParse(nonWorkerCountController.text) ?? 0,
            //     // );
            //     // widget.onSubmit(updatedModel);
            //   },
            //   // style: ElevatedButton.styleFrom(: Colors.purple),
            //   child: Text('Зберегти'),
            // ),
            
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
