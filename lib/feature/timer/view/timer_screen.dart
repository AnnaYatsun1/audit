import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

import '../../../router/router.dart';

@RoutePage()
class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TimerScreen> {
  final ScrollController _scrollController = ScrollController();
  List<String> objectTypes = ["Смартфон", "Ноутбук", "Планшет"];
  List<String> objectTypes2 = ["Смартфон", "Не тест", "Tets"];

  List<Map<String, dynamic>> sections = [
    {
      'title': 'Типы объектов',
      'items': ['Смартфон', 'Ноутбук', 'Планшет'],
    },
    {
      'title': 'Статусы объектов',
      'items': ['В использовании', 'На складе', 'В ремонте'],
    }
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBarIsVisible: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CupertinoButton(
                // alignment: Alignment.topCenter,
                
                color: Colors.green,
                  child: Text('добавить новый тип', style: TextStyle(color: Colors.white, fontSize: 22),),
                  onPressed: () {
                    setState(() {
                      sections.add({
                      'title': 'Новая секция', // Новая секция с дефолтным названием
                      'items': <String>[],
                      });
                    });
                  }),
                  SizedBox(height: 12,),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...sections.map((section) {
                      return _createteNewNDIView(
                          section['items'], section['title']);
                    })
                    // _createteNewNDIView(objectTypes, 'Заголовок 1'),
                    // _createteNewNDIView(objectTypes2, 'Заголовок 2'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _createteNewNDIView(List<String> items, String sectionTitle) {
    return Column(
      children: [
      _buildHeaderView(sectionTitle),
      _buildListItem(items),
      _buildDivider(),
      Padding(
        padding: EdgeInsets.all(10),
        child: CupertinoButton(
          color: Colors.blue,
          
          onPressed: () {
            setState(() {
              items.add('Tets');
            });
          },
          child: Text('добавить новый $sectionTitle', style: TextStyle(fontSize: 18, color: Colors.white),),
        ),
      )
    ]);
  }
  Widget _buildHeaderView(String? title) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        title ?? '',
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }

  
  Widget _buildListItem(List<String> items) {
    return Column(
      children: items.map((item) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF4D4D4D), // Фон ячейки
            borderRadius: BorderRadius.circular(12), // Закругление углов
          ),
          child: ListTile(
            title: Text(
              item,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        items.remove(item); // Удаление элемента
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.white12);
  }
}
