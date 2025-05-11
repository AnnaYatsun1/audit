import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/location/bloc/location/bloc/location_bloc.dart';
import 'package:sound_level_meter/feature/location/bloc/location/repository/location_repository.dart';
import 'package:sound_level_meter/feature/similar_product/bloc/similar/bloc/similar_bloc.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

// @RoutePage()
// class LocationScreen extends StatefulWidget {
//   final InventoryType productType;
//   const LocationScreen({super.key, required this.productType});

//   @override
//   State<LocationScreen> createState() => _LocationState();
// }

// class _LocationState extends State<LocationScreen> {
//   final LocationBloc _locationBloc = LocationBloc(LocationRepository());
//   final List<Map<String, String>> locations = [
//     {"location": "Склад 1", "available": "10"},
//     {"location": "Склад 2", "available": "5"},
//     {"location": "Склад 3", "available": "8"},
//     {"location": "Склад 4", "available": "12"},
//   ];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _locationBloc.add(LocationStarted(type: InventoryType.laptop));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//         appBarIsVisible: false,
//         child: BlocBuilder<LocationBloc, LocationState>(
//             bloc: _locationBloc,
//             builder: (context, state) {
//               if (state is SimilarInitial) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is LocationLoaded) {
//                 return ListView.builder(
//                   itemCount: state.locations.length,
//                   //   return ProductCard(product: {
//                   //   "title": item.name,
//                   //   "brand": item.brand
//                   // })
//                   itemBuilder: (context, index) {
//                     final location = state.locations[index];
//                     return Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 4,
//                       color: Color(0xFF1E1E1E),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Row(
//                           children: [
//                             Icon(Icons.location_on, color: Colors.white),
//                             SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     location.locationName.cityName,
//                                     // location["location"] ?? 'Невідома локація',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     location.locationName.cityName,
//                                     // location["location"] ?? 'Невідома локація',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Кількість: ${location.locationName.warehouses.length}',
//                                     // ${location["available"] ?? "0"}',
//                                     style: TextStyle(
//                                       color: Colors.grey[400],
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.chevron_right,
//                                   color: Colors.white),
//                               onPressed: () {
//                                 // Действие при нажатии
//                                 print('Перейти до детальної локації');
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else if (state is LocationError) {
//                 return Text(
//                     'Error: ${state.toString() ?? "Smth happend pls try again"}');
//               }
//               return SizedBox(
//                 height: 16,
//               );
//             }));
//   }
// }

@RoutePage()
class LocationScreen extends StatefulWidget {
  final InventoryType productType;
  const LocationScreen({super.key, required this.productType});

  @override
  State<LocationScreen> createState() => _LocationState();
}

class _LocationState extends State<LocationScreen> {
  final LocationBloc _locationBloc = LocationBloc(LocationRepository());

  @override
  void initState() {
    super.initState();
    _locationBloc.add(LocationStarted(type: widget.productType));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: false,
      child: BlocBuilder<LocationBloc, LocationState>(
        bloc: _locationBloc,
        builder: (context, state) {
          if (state is LocationInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocationLoaded) {
            return ListView.builder(
              itemCount: state.locations.length,
              itemBuilder: (context, index) {
                final location = state.locations[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  color: Color(0xFF1E1E1E),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Город
                              Text(
                                'Город: ${location.locationName.cityName}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),

                              // Перебор складов в этом городе
                              for (var warehouse
                                  in location.locationName.warehouses)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Название склада
                                    Text(
                                      'Склад: ${warehouse.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),

                                    // Перебор товаров на складе
                                    for (var item in warehouse.inventoryItems)
                                      if (item.type == widget.productType)
                                        Row(
                                          children: [
                                            Icon(Icons.shopping_cart,
                                                color: Colors
                                                    .white), // Иконка товара
                                            SizedBox(width: 8),
                                            Text(
                                              '${item.type.toString().split('.').last}: ${item.quantity}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                    SizedBox(height: 12),
                                  ],
                                ),
                              // Переход на детальный экран
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right, color: Colors.white),
                          onPressed: () {
                            // Действие при нажатии (переход на экран склада)
                            print('Перейти на детальную информацию о складе');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is LocationError) {
            return Center(
                child: Text('Error: ${state ?? "Something went wrong"}'));
          }
          return SizedBox(height: 16);
        },
      ),
    );
  }
}
