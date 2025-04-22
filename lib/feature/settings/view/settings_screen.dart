import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/feature/ui/theme/theme.dart';
import 'package:sound_level_meter/router/router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sound_level_meter/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@RoutePage()
class SattingsScreen extends StatefulWidget {
  const SattingsScreen({super.key});

  @override
  State<SattingsScreen> createState() => _SattingsScreenState();
}

class _SattingsScreenState extends State<SattingsScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? selectedBrand;
  final Map<int, String?> selectedBrands = {};

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  pickPhotoFromCamera();
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
                            _imageFile != null
                                ? Image.file(
                                    File(_imageFile!.path),
                                    height: containerHeight * 0.4,
                                    width: containerHeight * 0.4,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.camera_alt,
                                    color: Colors.white,
                                    size: containerHeight * 0.4),
                            SizedBox(
                              height: 12,
                            ),
                            Material(
                              elevation: 10,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: InkWell(
                                radius: 20,
                                borderRadius: BorderRadius.circular(20),
                                child: TextButton(
                                    onPressed: () {
                                      pickPhotoFromGalery();
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
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  decoration: 
                  InputDecoration(  
              
                    labelText: 'Product Name',
                      labelStyle: themeDark.textTheme.labelSmall),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Clobal Rank',
                        labelStyle: themeDark.textTheme.labelSmall),
                    keyboardType: TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Clobal Rank',
                        labelStyle: themeDark.textTheme.labelSmall),
                    keyboardType: TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Serial number ',
                              labelStyle: themeDark.textTheme.labelSmall),
                          keyboardType: TextInputType.number),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      icon: Icon(Icons.qr_code_scanner),
                      color: Colors.white,
                      tooltip: 'Scan',
                      onPressed: () {
                        // Открыть камеру для сканирования
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: themeDark.textTheme.labelSmall),
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    keyboardType: TextInputType.number,
                    style: themeDark.textTheme.labelSmall,
                    decoration: InputDecoration(
                        labelText: 'Робочих',
                        labelStyle: themeDark.textTheme.labelSmall),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Inut number';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Некорректное число';
                      }

                      if (number < 0) {
                        return 'Число должно быть ≥ 0';
                      }

                      return null;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    style: themeDark.textTheme.labelSmall,
                    decoration: InputDecoration(
                        labelText: 'Не робочих',
                        labelStyle: themeDark.textTheme.labelSmall),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Inut number';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Некорректное число';
                      }

                      if (number < 0) {
                        return 'Число должно быть ≥ 0';
                      }

                      return null;
                    }),
              ),
              // тут бедем брать с запроса

              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: IgnorePointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText:
                            'Количество в использовании ${value > 0 ? value : "нет данных"}',
                        labelStyle: themeDark.textTheme.labelSmall),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      color: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Кнопка "История объекта"
                            TextButton.icon(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => HistoryScreen()),
                                // );
                              },
                              icon: Icon(Icons.history, color: Colors.white,),
                              label: Text('История объекта', style: TextStyle(color: Colors.white)),
                              style: TextButton.styleFrom(
                                // padding: EdgeInsets.symmetric(
                                //     vertical: 12, horizontal: 16),
                                alignment: Alignment.bottomLeft,
                              ),
                            ),

                            SizedBox(height: 8),

                            // Кнопка "Схожие товары"
                            TextButton.icon(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   // MaterialPageRoute(builder: (context) => SimilarProductsScreen()),
                                // );
                              },
                              icon: Icon(Icons.shopping_bag, color: Colors.white,),
                              label: Text('Схожие товары', style: TextStyle(color: Colors.white)),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color:    const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Кнопка "История объекта"
                            TextButton.icon(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => HistoryScreen()),
                                // );
                              },
                              icon: Icon(Icons.history, color: Colors.white,),
                              label: Text('Перевести', style: TextStyle(color: Colors.white),),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                alignment: Alignment.centerLeft,
                              ),
                            ),

                            SizedBox(height: 8),

                            // Кнопка "Схожие товары"
                            TextButton.icon(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   // MaterialPageRoute(builder: (context) => SimilarProductsScreen()),
                                // );
                              },
                              icon: Icon(Icons.shopping_bag, color: Colors.white,),
                              label: Text('Выдать', style: TextStyle(color: Colors.white),),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => HistoryScreen()),
                                // );
                              },
                              icon: Icon(Icons.history, color: Colors.white,),
                              label: Text('ЛОкации', style: TextStyle(color: Colors.white)),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Expanded(
              // child:
              Container(
                child: ListView.builder(
                
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return AdaptiveBrandSelector(
                          selectedBrand: selectedBrands[0],
                          brands: ['Apple', 'Samsung', 'Xiaomi'],
                          textOfBrand: 'Brend',
                          onBrandSelected: (brand) {
                            setState(() {
                              selectedBrands[0] = brand;
                            });
                          });
                    }),
              ),
              // ),

              Container(
                color:  const Color(0xFF1E1E1E),
                child: ListView.builder(
                    
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AdaptiveBrandSelector(
                        
                          selectedBrand: selectedBrands[1],
                          brands: [
                            'Comp',
                            'Mouse',
                            'Keyboard',
                            'Micropphone'
                          ],
                          textOfBrand: 'Brend',
                          onBrandSelected: (brand) {
                            setState(() {
                              selectedBrands[1] = brand;
                            });
                          });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color:  const Color(0xFF1E1E1E),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0), // высота кнопки
                    child: Text(
                      'Готово',
                      style:
                          TextStyle(color: Colors.blue), // так как фон белый
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              )
            ],
          ),
        ),
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
                children: brands.map((b) => Text(b,)).toList(),
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
  const CustomCuertinoButtom({super.key,});

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


