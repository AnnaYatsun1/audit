import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
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

// class InventoryListTile extends StatelessWidget {
//   const InventoryListTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//         child: Card(
//           borderOnForeground: true,

//             color: themeDark.primaryColor,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                               Text(
//                           'General',
//                           style: themeDark.textTheme.labelSmall,
//                           textAlign: TextAlign.right,
//                         ),
//                                 Text(
//                           'General',
//                           style: themeDark.textTheme.labelSmall,
//                           textAlign: TextAlign.right,
//                         ),
//                     ],),
//                     // child: Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Text(
//                     //       'Simple',
//                     //       style: themeDark.textTheme.bodyMedium,
//                     //       textAlign: TextAlign.right,

//                     //     ),
//                     //     Text(
//                     //       'General',
//                     //       style: themeDark.textTheme.labelSmall,
//                     //       textAlign: TextAlign.right,
//                     //     ),
//                     //   ],
//                     // ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         verticalDirection: VerticalDirection.up,
//                         children: [
//                           Row(children: [
//                               Text(
//                             'Item1',
//                             style: themeDark.textTheme.bodyMedium,
//                             // TextStyle(color: Colors.white, fontSize: 18),
//                             textAlign: TextAlign.right,
//                            ),

//                           ],)

//                           // Text(
//                           //   'qty-9',
//                           //   style: themeDark.textTheme.labelSmall,
//                           //   textAlign: TextAlign.right,
//                           // ),
//                         ]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0, right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                                 IconButton(
//                                   onPressed: () {
//                                       print('some action1');
//                                    },
//                                   icon: Icon(Icons.barcode_reader),
//                                   color: Colors.black,
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                       print('some action1');
//                                    },
//                                   icon: Icon(Icons.edit),
//                                   color: Colors.blue,
//                               ),

//                               IconButton(
//                                   onPressed: () {
//                                       print('some action1');
//                                    },
//                                   icon: Icon(Icons.delete),
//                                   color: Colors.red,
//                               ),
//                           ],
//                         ),
//                         Row(children: [
//                           Text(
//                             'cst: 100',
//                             style: themeDark.textTheme.labelSmall,
//                             textAlign: TextAlign.right,),
//                           Text(
//                             'prs: 100',
//                             style: themeDark.textTheme.labelSmall,
//                             textAlign: TextAlign.right,)
//                           ],)
//                       ],
//                     ),
//                   ),
//                   Padding(padding: EdgeInsets.all(10), child:
//                   Container(

//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                                 IconButton(
//                                   onPressed: () {
//                                       print('some action1');
//                                    },
//                                   icon: Icon(Icons.barcode_reader),
//                                   color: Colors.white,
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                       print('some action1');
//                                    },
//                                   icon: Icon(Icons.edit),
//                                   color: Colors.blue,
//                               ),

//                               IconButton(
//                                   onPressed: () {
//                                       print('some action1');
//                                    },
//                                   icon: Icon(Icons.delete),
//                                   color: Colors.red,
//                               ),
//                           ],
//                         ),)
//                   ),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }

class InventoryListTile extends StatelessWidget {
  final String name;
  final String brand;
  final int totalQuantity;
  final int workingQuantity;
  final int brokenQuantity;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onGenerateBarcode;

  const InventoryListTile({
    super.key,
    required this.name,
    required this.brand,
    required this.totalQuantity,
    required this.workingQuantity,
    required this.brokenQuantity,
    required this.onEdit,
    required this.onDelete,
    required this.onGenerateBarcode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
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
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        /// Бренд
                        Text(
                          'Бренд: $brand',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

  
              Divider(color: Colors.grey[700]),

              /// Данные о количестве
              _buildRowInfo('Загальна кількість', '$totalQuantity'),
              _buildRowInfo('Кількість робочих', '$workingQuantity'),
              _buildRowInfo('Кількість зламаних', '$brokenQuantity'),

              const SizedBox(height: 12),

              /// Кнопки действий
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Кнопка генерации баркода
                  _buildActionButton(
                    icon: Icons.qr_code,
                    label: 'Баркод',
                    onTap: onGenerateBarcode,
                    color: Colors.green,
                  ),

                  /// Кнопка редактирования
                  _buildActionButton(
                    icon: Icons.edit,
                    label: 'Редагувати',
                    onTap: onEdit,
                    color: Colors.blue,
                  ),

                  /// Кнопка удаления
                  _buildActionButton(
                    icon: Icons.delete,
                    label: 'Видалити',
                    onTap: onDelete,
                    color: Colors.red,
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
        width: 100,
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
