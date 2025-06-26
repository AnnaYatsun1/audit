import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/ui/theme/theme.dart';
import 'package:sound_level_meter/router/router.dart';

@RoutePage()
class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App bar'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 10,
        itemBuilder: (context, index) {
          // if (index != 0) {
          //   // need to fix when added items (index == _items.length)
          //   return Center(
          //     child: Padding(
          //       padding: EdgeInsets.all(16),
          //       child: CircularProgressIndicator(),
          //     ),);
          // }
          // SizedBox(height: 10);
          return Placeholder();
          // InventoryListTile();
        },
      ),
    );
  }
}

class InventoryCard extends StatefulWidget {
  final String name;
  final String brand;
  final int totalQuantity;
  final int workingQuantity;
  final int brokenQuantity;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onDetail;
  final VoidCallback onGenerateBarcode;

  const InventoryCard({
    super.key,
    required this.name,
    required this.brand,
    required this.totalQuantity,
    required this.workingQuantity,
    required this.brokenQuantity,
    required this.onEdit,
    required this.onDelete,
    required this.onDetail,
    required this.onGenerateBarcode,
  });

  @override
  State<InventoryCard> createState() => _InventoryCardState();
}

class _InventoryCardState extends State<InventoryCard> {
  void onDeteilItem(InventoryItemView item) async {
    final updatedItem = await AutoRouter.of(context).push<InventoryItemView>(
      DetailRoute(item: item),
    );

    // if (updatedItem != null) {
    //   _homeBloc.add(HomeItemUdate(updatedItem));
    // }
  }

  @override
  Widget build(BuildContext context) {
    /// Карточка товара
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 10,
        color: Color(0xFF2C2C2C),

        // Темный фон для карточки
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Верхний блок с названием и брендом
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

                  /// Название и бренд
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Имя объекта
                        Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        /// Бренд
                        Text(
                          'Бренд: ${widget.brand}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: widget.onDetail,
                      // AutoRouter.of(context).push(DetailRoute(item: ));
                      // print('Открываем экран ');
                      // },
                      icon: Icon(Icons.visibility, color:  Color(0xFFFFD700).withOpacity(0.5),)),
                ],
              ),
              const SizedBox(height: 12),

              Divider(color: Colors.grey[700]),

              /// Данные о количестве
              _buildRowInfo('Загальна кількість', '${widget.totalQuantity}'),
              _buildRowInfo('Кількість робочих', '${widget.workingQuantity}'),
              _buildRowInfo('Кількість зламаних', '${widget.brokenQuantity}'),

              const SizedBox(height: 12),

              /// Кнопки действий
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Кнопка генерации баркода
                  _buildActionButton(
                    icon: Icons.qr_code,
                    label: 'Баркод',
                    onTap: widget.onGenerateBarcode,
                    color: const Color.fromARGB(255, 78, 240, 83).withOpacity(0.5),
                  ),

                  /// Кнопка редактирования
                  _buildActionButton(
                    icon: Icons.edit,
                    label: 'Редагувати',
                    onTap: widget.onEdit,
                    color: const Color.fromARGB(255, 99, 175, 238),
                  ),

                  /// Кнопка удаления
                  _buildActionButton(
                    icon: Icons.delete,
                    label: 'Видалити',
                    onTap: widget.onDelete,
                    color: const Color.fromARGB(255, 232, 84, 73),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Метод для построения строки данных
  Widget _buildRowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Метод для построения кнопки действия
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.27,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
