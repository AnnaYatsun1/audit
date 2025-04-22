import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/ui/custom_adaptive_button.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/router/router.dart';

@RoutePage()
class SavesScreen extends StatefulWidget {
  const SavesScreen({super.key});

  @override
  State<SavesScreen> createState() => _SavesScreenState();
}

class _SavesScreenState extends State<SavesScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isLocationChosing = false;
   String? selectedBrand;
  String buttonTitle = "Select Location";
  Color buttonColor = Colors.blue;

  List<Map<String, dynamic>> items = [
    {
      'name': 'Location1',
      'charge_of': 'Apple',
      'location': 'Kiev',
    },
    {
      'name': 'Location2',
      'charge_of': 'Apple',
      'location': 'Lviv',
    },
    {
      'name': 'Location3',
      'charge_of': 'Apple',
      'location': 'Dniro',
    },
    {
      'name': 'Location4',
      'charge_of': 'Apple',
      'location': 'Donetsk',
    },
    {
      'name': 'Location5',
      'charge_of': 'Apple',
      'location': 'Odessa',
    },
  ];

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void choseLocation() {
    setState(() {
      isLocationChosing = true;
      buttonTitle = "Location Chosen";  // Изменение текста кнопки
      buttonColor = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: false,
      child: GridView.builder(
        itemCount: items.length + 1, // +1 for the "Add Store" card
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return LocationCard(
              location: Location(name: item['name'], location: item['location']),
              isSelected: true,
              onTap: () => deleteItem(index),
              onSelect: () {
                choseLocation();
              },
            );
          } else {
            return AddStoreCard(onTap: () {});
          }
        },
      ),
    );
  }
}

class Location {
  final String name;
  final String location;

  Location({required this.name, required this.location});
}

class LocationCard extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onTap;
  final Location location;
 

  const LocationCard({
    super.key,
    required this.isSelected,
    required this.onSelect,
    required this.onTap,
    required this.location,
  });

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
   String? selectedBrand;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF1E1E1E), // Adjust the background color here
      ),
      child: Card(
        color: const Color(0xFF1E1E1E),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () => _showPlatformMenu(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.location.name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                widget.location.location,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              // Use SingleChildScrollView to enable scrolling within the card
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AdaptiveBrandSelector(
                        selectedBrand: selectedBrand,
                        brands: [
                          'Comp',
                          'Monitor',
                          'Mouse',
                          'Keyboard',
                          'Microphone',
                        ],
                        textOfBrand: 'Brand',
                        onBrandSelected: (brand) {
                           setState(() {
                            selectedBrand = brand;  // обновляем выбранный бренд
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomAdaptiveButton(
                title: 'Select',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPlatformMenu(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                print('Edit');
              },
              child: Text('Edit'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                widget.onTap();
                Navigator.pop(context);
                print('Delete');
              },
              child: Text('Delete'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ),
      );
    } else {
      showMenu(
        context: context,
        color: Colors.white,
        position: RelativeRect.fromLTRB(100, 100, 0, 0),
        items: [
          PopupMenuItem(value: 'Edit', child: Text('Edit')),
          PopupMenuItem(value: 'Delete', child: Text('Delete')),
        ],
      );
    }
  }
}

class AddStoreCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddStoreCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              Text(
                'Add Stores',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
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
                children: brands.map((b) => Text(b)).toList(),
              ),
            ),
            CupertinoButton(
              child: Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return ListTile(
        title: Text(
          textOfBrand,
          style: TextStyle(color: Colors.white),
        ),
        titleAlignment: ListTileTitleAlignment.center,
        subtitle: Padding(
          padding: const EdgeInsets.only(),
          child: Text(
            selectedBrand ?? 'No brand selected',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => _showCupertinoPicker(context),
      );
    } else {
      return ListTile(
        title: Text(
          textOfBrand,
          style: TextStyle(color: Colors.white),
        ),
        titleAlignment: ListTileTitleAlignment.center,
        subtitle: Padding(
          padding: const EdgeInsets.only(),
          child: Text(
            selectedBrand ?? 'No brand selected',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => _showCupertinoPicker(context),
      );
    }
  }
}
