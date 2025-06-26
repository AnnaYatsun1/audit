import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/bloc/history/bloc/history_bloc.dart';
import 'package:sound_level_meter/feature/home/filter/view/filtre_screen.dart';
import 'package:sound_level_meter/feature/locations/bloc/all_locations/bloc/all_locations_bloc.dart';
import 'package:sound_level_meter/feature/locations/bloc/all_locations/repository/all_locations_repository.dart';
import 'package:sound_level_meter/feature/locations/location/bloc_selection/bloc_selection.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/ui/custom_adaptive_button.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/router/router.dart';

@RoutePage()
class AllLocationScreen extends StatefulWidget {
  const AllLocationScreen({super.key});

  @override
  State<AllLocationScreen> createState() => _AllLocationState();
}

class _AllLocationState extends State<AllLocationScreen> {
  final ScrollController _scrollController = ScrollController();
  final AllLocationsBloc _locationsBloc =
      AllLocationsBloc(AllLocationsRepository());

  // bool isLocationChosing = false;
  // String? selectedBrand;
  // String buttonTitle = "Select Location";
  // Color buttonColor = Colors.blue;

  @override
  void initState() {
    _locationsBloc.add(AllLocationsStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllLocationsBloc, AllLocationsState>(
        bloc: _locationsBloc,
        builder: (context, state) {
          if (state is AllLocationsInitial) {
            return Center(child: CustomLoadingIndicator());
          } else if (state is AllLocationLoaded) {
            final location = state.warehouses;
            return CustomScaffold(
                appBarIsVisible: true,
                child: GridView.builder(
                  itemCount: location.length + 1, // +1 for the "Add Store" card
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    if (index < location.length) {
                      final item = location[index];
                      return LocationCard(
                        location: item,
                        // Location(name: item['name'], location: item['location']),
                        isSelected: true,
                        // onTap: () => deleteItem(index),
                        moveTo: () => {
                          AutoRouter.of(context)
                              .push(EditWarehouseRoute(model: item)),
                          AutoRouter.of(context).pop()
                        },
                        onTap: () {
                          _locationsBloc.add(DeleteLocation(item.id));
                        },
                        onSelect: () {
                          // choseLocation();
                        },
                      );
                    } else {
                      return AddStoreCard(onTap: () {});
                    }
                  },
                ));
          } else if (state is LocationsError) {
            // надо сделать обработчик обибок обьект
            return Text(
                'Error: ${state.toString() ?? "Smth happend pls try again"}');
          }
          return const SizedBox.shrink();
        });
  }
}

class LocationCard extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onTap;
  final Warehouse location;
  final VoidCallback moveTo;
  const LocationCard({
    super.key,
    required this.isSelected,
    required this.onSelect,
    required this.onTap,
    required this.location,
    required this.moveTo,
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
                    color: Color(0xFFF1C40F),
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
                widget.location.cityNameCode,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              // Use SingleChildScrollView to enable scrolling within the card
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // AdaptiveBrandSelector(
                      //   selectedBrand: selectedBrand,
                      //   brands: [
                      //     'Comp',
                      //     'Monitor',
                      //     'Mouse',
                      //     'Keyboard',
                      //     'Microphone',
                      //   ],
                      //   textOfBrand: 'Brand',
                      //   onBrandSelected: (brand) {
                      //     setState(() {
                      //       selectedBrand = brand; // обновляем выбранный бренд
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              BlocBuilder<WarehouseSelectionBloc, WarehouseSelectionState>(
                builder: (context, state) {
                  final selected =
                      state.selectedWarehouse?.id == widget.location.id;

                  return CustomAdaptiveButton(
                    title: selected ? 'Selected' : 'Select',
                    color: selected ? Colors.green : Colors.blue,
                    isActivated: true,
                    onPressed: () {
                      context.read<WarehouseSelectionBloc>().add(
                            SelectWarehouse(widget.location),
                          );
                    },
                  );
                },
              ),
              // CustomAdaptiveButton(
              //   title: 'Select',
              //   onPressed: () {},
              // ),
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
              onPressed: widget.moveTo,
              // () async {

              // await AutoRouter.of(context).push(EditWarehouseRoute());
              // AutoRouter.of(context).pop();
              // print('Edit');
              // },
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
