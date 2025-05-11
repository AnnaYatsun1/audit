import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/similar_product/bloc/similar/bloc/similar_bloc.dart';
import 'package:sound_level_meter/feature/similar_product/bloc/similar/repository/similar_repository.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

@RoutePage()
class SimilarProductScreen extends StatefulWidget {
  const SimilarProductScreen({super.key});

  @override
  State<SimilarProductScreen> createState() => _SimilarProductScreenState();
}

class _SimilarProductScreenState extends State<SimilarProductScreen> {
  final SimilarBloc _similarBloc = SimilarBloc(SimilarRepository());
  // Список для демонстрации схожих товаров


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
        child:    Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<SimilarBloc, SimilarState>(
              bloc: _similarBloc,
              builder: (context, state) {
                if (state is SimilarInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SimilarLoaded) {
                  return  ListView.builder(
                 itemCount: state.similarInventoryItem.length,
              itemBuilder: (context, index) {
              final item = state.similarInventoryItem[index];
                return ProductCard(product: {
                  "title": item.name,
                  "brand": item.brand
                });
          },
        );
                } else if (state is SimilarError) {
                  return Text(
                      'Error: ${state.toString() ?? "Smth happend pls try again"}');
                }
                return SizedBox(
                  height: 16,
                );
              })),
  
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Map<String, String> product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final String typeName = "";
  final String subypeName = "";
  
  @override
  Widget build(BuildContext context) {
    return   Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: const Color(0xFF1E1E1E), // Темный фон для карточки
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Название и бренд
            Row(
              children: [
                Icon(Icons.inventory, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product["title"] ?? 'Product Name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Бренд: ${widget.product["brand"] ?? "Unknown"}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Кнопка "Переглянути"
            Center(
              child: TextButton(
                onPressed: () {
                  // Ваше действие
                },
                child: Text(
                  'Переглянути',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
