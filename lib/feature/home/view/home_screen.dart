import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/router/router.dart';

import '../../info/view.dart';

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
  // EmailValidatorFlutter validator = EmailValidatorFlutter();

  List<Map<String, dynamic>> items = [
    {
      'name': 'iPhone 13',
      'brand': 'Apple',
      'totalQuantity': 25,
      'workingQuantity': 20,
      'brokenQuantity': 5,
    },
    {
      'name': 'Samsung S22',
      'brand': 'Samsung',
      'totalQuantity': 30,
      'workingQuantity': 28,
      'brokenQuantity': 2,
    },
    {
      'name': 'Google Pixel 7',
      'brand': 'Google',
      'totalQuantity': 15,
      'workingQuantity': 12,
      'brokenQuantity': 3,
    },
    {
      'name': 'iPhone 16',
      'brand': 'Apple',
      'totalQuantity': 5,
      'workingQuantity': 2,
      'brokenQuantity': 3,
    },
  ];

  void toogleToPasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
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
      child: Column(
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
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InventoryListTile(
                          name: item['name'],
                          brand: item['brand'],
                          totalQuantity: item['totalQuantity'],
                          workingQuantity: item['brokenQuantity'],
                          brokenQuantity: item['workingQuantity'],
                          onEdit: () {
                            AutoRouter.of(context).push(SattingsRoute());

                            print('Редагувати');
                          },
                          onDelete: () {
                            print('Видалити');
                            deleteItem(index);
                          },
                          onGenerateBarcode: () {
                            AutoRouter.of(context).push(QrCraterRoute());
                            print('Генерація баркоду');
                          },
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

// class _CustomSearchBarState extends State<CustomSearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: InkWell(
//         onTap: () {
//           print('Откритие нового окна ');
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => SearchScreen()),
//           );
//           //
//         },
//         child: Container(
//           decoration: BoxDecoration(
//               color: const Color(0xFF4D4D4D),
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                     color:
//                         const Color.fromARGB(255, 179, 10, 10).withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(0, 2))
//               ]),
//           // color: Colors.white,
//           child: TextField(
//             onChanged: (value) {
//               // метод поиска
//             },
//             style: TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               hintText: 'Поиск',
//               border: InputBorder.none,
//               prefixIcon: Icon(Icons.search, color: Colors.grey),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: () {
          print('Откритие нового окна');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF4D4D4D),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 179, 10, 10).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: const [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                'Поиск',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          ),
          child: SafeArea(
            child: Row(
              children: [
                // Поле пошуку
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 195, 185, 185),
                            width: 2), // Синя рамка при фокусі
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Поиск...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon:
                                  const Icon(Icons.clear, color: Colors.white),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                // Кнопка "Відмінити"
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Повертаємося назад
                  },
                  child: const Text(
                    'Отменить',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 195, 185, 185),
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: _searchText.isEmpty
          ? const Center(
              child: Text(
                'Введите запрос для поиска...',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : _buildSearchResults(),
    );
  }

  /// Функція для побудови результатів пошуку
  Widget _buildSearchResults() {
    // Тимчасово хардкодимо результати
    final List<String> results = ['iPhone 13', 'MacBook Pro', 'AirPods Pro'];

    // Фільтрація результатів
    final List<String> filteredResults = results
        .where((item) => item.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.device_hub, color: Colors.white),
          title: Text(
            filteredResults[index],
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            print('Вибрано: ${filteredResults[index]}');
            Navigator.pop(context); // Повертаємося назад після вибору
          },
        );
      },
    );
  }
}

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Длительность анимации
    )..repeat(reverse: true);

    // Tween — это линейная интерполяция значений для движения индикатора
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сканер QR-кодов'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  final String code = barcode.rawValue!;
                  print('QR-код обнаружен: $code');
                  Navigator.pop(context, code); // Возвращаемся с данными
                }
              }
            },
            errorBuilder: (context, error, child) {
              return Center(
                child: Text(
                  'Ошибка камеры: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            },
          ),
          _buildOverlay(context),
        ],
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12)),
                ),
              )
            ],
          ),
        ),

        Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Анимированная линия внутри рамки
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  top: 300 * _animation.value, // Движение вверх-вниз
                  child: Container(
                    width: 280,
                    height: 2,
                    color: Colors.redAccent,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

@RoutePage()
class QrCraterScreen extends StatefulWidget {
  const QrCraterScreen({super.key});

  @override
  State<QrCraterScreen> createState() => _QrCraterScreenState();
}

class _QrCraterScreenState extends State<QrCraterScreen> {
  final controller = TextEditingController();
  Widget _buildTeftField(BuildContext context) => TextField(
        controller: controller,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            hintText: 'Enter the data',
            helperStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.white)),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(
                  Icons.done,
                  size: 30,
                ))),
      );
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBarIsVisible: true,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                QrImageView(
                  data: controller.text,
                  size: 200,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 40,
                ),
                _buildTeftField(context),
              ],
            ),
          ),
        ));
  }
}

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key});
// [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 28, 26, 26)];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 28, 26, 26),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black
                // backgroundBlendMode: BlendMode.colorDodge
                ),
            onDetailsPressed: () {
              print('open detail Screen');
            },
            accountName: Text(''),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(Icons.supervised_user_circle),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.white,
            ),
            title: Text(
              'Languages',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              print('open settings screen');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Text('Setting', style: TextStyle(color: Colors.white)),
            onTap: () {
              print('open settings screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.white,),
            title: Text('Exit', style: TextStyle(color: Colors.white)),
            onTap: () {
              print('open settings screen');
            },
          ),
        ],
      ),
    );
  }
}
