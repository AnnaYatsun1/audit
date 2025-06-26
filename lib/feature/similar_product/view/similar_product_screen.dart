import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/similar_product/bloc/similar/bloc/similar_bloc.dart';
import 'package:sound_level_meter/feature/similar_product/bloc/similar/repository/similar_repository.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/router/router.dart';

@RoutePage()
class SimilarProductScreen extends StatefulWidget {
  const SimilarProductScreen({super.key});

  @override
  State<SimilarProductScreen> createState() => _SimilarProductScreenState();
}

class _SimilarProductScreenState extends State<SimilarProductScreen> {
  final SimilarBloc _similarBloc = SimilarBloc(SimilarRepository());

  @override
  void initState() {
    super.initState();
    _similarBloc.add(SimilarStarted(brand: 'Apple'));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<SimilarBloc, SimilarState>(
          bloc: _similarBloc,
          builder: (context, state) {
            if (state is SimilarInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SimilarLoaded) {
              return ListView.builder(
                itemCount: state.similarInventoryItem.length,
                itemBuilder: (context, index) {
                  final item = state.similarInventoryItem[index];
                  return ProductCard(
                      onDelivery: () async {
                        final inventoryItemView = item.toInventoryItemView();
                        await AutoRouter.of(context).push<InventoryItemView>(
                          DetailRoute(item: inventoryItemView),
                        );
                      },
                      product: {"title": item.name, "brand": item.brand});
                },
              );
            } else if (state is SimilarError) {
              return Text(
                  'Error: ${state.toString() ?? "Something happened. Please try again."}');
            }
            return const SizedBox(height: 16);
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onDelivery,
  });

  final Map<String, String> product;
  final VoidCallback onDelivery;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6, // Тень для карточки
      color: const Color(0xFF2C2C2C), // Темный фон для карточки
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            // Название и бренд
            Row(
              children: [
                CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.inventory, // Иконка по умолчанию
                      color: Colors.black,
                    ),
                  ),
                  
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product["title"] ?? 'Product Name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Brand: ${product["brand"] ?? "Unknown"}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Кнопка "View Details"
            Center(
              child: ElevatedButton(
                onPressed: onDelivery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 149, 0), // Цвет фона
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'View Details',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
