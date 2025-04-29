import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

@RoutePage()
class SimilarProductScreen extends StatefulWidget {
  const SimilarProductScreen({super.key});

  @override
  State<SimilarProductScreen> createState() => _SimilarProductScreenState();
}

class _SimilarProductScreenState extends State<SimilarProductScreen> {
  // Список для демонстрации схожих товаров
  final List<Map<String, String>> similarProducts = [
    {"title": "Product A", "brand": "Brand X"},
    {"title": "Product B", "brand": "Brand Y"},
    {"title": "Product C", "brand": "Brand Z"},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: similarProducts.length,
          itemBuilder: (context, index) {
            final product = similarProducts[index];
            return ProductCard(product: product);
          },
        ),
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
    return Card(
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
