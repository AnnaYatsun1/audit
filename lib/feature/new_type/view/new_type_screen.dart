import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/new_type/bloc/new_type/bloc/new_type_bloc.dart';
import 'package:sound_level_meter/feature/new_type/bloc/new_type/repository/new_type_repository.dart';

import 'package:sound_level_meter/feature/ui/custom_action_button.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

import '../../../router/router.dart';
import '../view.dart';

@RoutePage()
class NewTypeScreen extends StatefulWidget {
  const NewTypeScreen({super.key});

  @override
  State<NewTypeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewTypeScreen> {
  final ScrollController _scrollController = ScrollController();
  final NewTypeBloc _newTypeBloc = NewTypeBloc(NewTypeRepository());
  // List<String> objectTypes = ["Смартфон", "Ноутбук", "Планшет"];
  // List<String> objectTypes2 = ["Смартфон", "Не тест", "Tets"];

  // List<Map<String, dynamic>> sections = [
  //   {
  //     'title': 'Типы объектов',
  //     'items': ['Смартфон', 'Ноутбук', 'Планшет'],
  //   },
  //   {
  //     'title': 'Статусы объектов',
  //     'items': ['В использовании', 'На складе', 'В ремонте'],
  //   }
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newTypeBloc.add(NewTypeStarted());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: false,
      child: BlocBuilder<NewTypeBloc, NewTypeState>(
          bloc: _newTypeBloc,
          builder: (context, state) {
            if (state is NewTypeInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewTypeLoaded) {
              final brands = state.brands;
              final types = state.types;
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          _createSection<Brand>(state.brands, 'Бренды',
                              onDelete: (brand) {
                            // setState(() {
                            _newTypeBloc.add(NewTypeDelete<Brand>(brand));
                            //   state.brands
                            //       .remove(brand); // или вызовем событие в блок
                            // });
                          }),
                          _createSection<Catogory>(state.types, 'Типы',
                              onDelete: (type) {
                            _newTypeBloc.add(NewTypeDelete<Catogory>(type));
                            // setState(() {
                            //   state.types
                            //       .remove(type); // временно через setState
                            // });
                          }),
                        ],
                      ), /*  */
                    )
                  ],
                ),
              );
            } else if (state is NewTypeError) {
              return Center(
                  child: Text('Error: ${state ?? "Something went wrong"}'));
            }
            return SizedBox(height: 16);
          }),
    );
  }

  Widget _buildHeaderView(String? title) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          title ?? '',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }

  Widget _buildListItem<T>(List<T> items) {
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
              item.toString(),
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

  Widget _createSection<T>(List<T> items, String title,
      {required void Function(T) onDelete}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderView(title),
        ...items.map((e) => _buildListTile(e, onDelete)).toList(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: GoldenButton(
              label: 'Добавить новый $title',
              // padding: EdgeInsets.all(12),
              // color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    final controller = TextEditingController();

                    return EditAddDialog<T>(
                      title: 'Добавить новый $title',
                      existingNames: items
                          .map(
                              (e) => e is Brand ? e.name : (e as Catogory).name)
                          .toList(),
                      onConfirm: (newName) {
                        final id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        if (T == Brand) {
                          _newTypeBloc
                              .add(NewTypeCreate<Brand>(Brand(id, newName)));
                        } else if (T == Catogory) {
                          _newTypeBloc.add(
                              NewTypeCreate<Catogory>(Catogory(id: id, name: newName)));
                        }
                      },
                    );
                  },
                );
              },
              // l:
              //        Text(
              //         'добавить новый $title',
              //         style: TextStyle(fontSize: 18, color: Colors.white),
              //       ),
            ),
          ),
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildListTile<T>(T item, void Function(T) onDelete) {
    final name = item is Brand ? item.name : (item as Catogory).name;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit,
                  color: const Color.fromARGB(255, 99, 175, 238)),
              onPressed: () {
                final controller = TextEditingController(text: name);

                if (item is Brand) {
                  newMethod<Brand>(name, item);
                } else if (item is Catogory) {
                  newMethod<Catogory>(name, item);
                }
              },
            ),
            //  _buildActionButton(
            //     icon: Icons.delete,
            //     label: 'Видалити',
            //     onTap: () => onDelete(item),
            //     color: const Color.fromARGB(255, 232, 84, 73),
            //   ),
            IconButton(
              icon: const Icon(Icons.delete,
                  color: const Color.fromARGB(255, 232, 84, 73)),
              onPressed: () => onDelete(item),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> newMethod<T>(String name, item) {
    return showDialog(
      context: context,
      builder: (_) {
        return EditAddDialog<T>(
          title: 'Редактировать $name',
          initialValue: name,
          existingNames: (() {
            final state = _newTypeBloc.state;
            if (state is NewTypeLoaded) {
              final list = T == Brand ? state.brands : state.types;
              return list
                  .map((e) =>
                      T == Brand ? (e as Brand).name : (e as Catogory).name)
                  .where((n) => n != name)
                  .toList();
            } else {
              return <String>[];
            }
          })(),
          onConfirm: (newName) {
            print('Редактирование: $newName');
            final id = item is Brand ? item.id : (item as Catogory).id;
            if (T == Brand) {
              _newTypeBloc.add(NewTypeEdite<Brand>(
                oldItem: item as Brand,
                newItem: Brand(id, newName),
              ));
            } else if (T == Catogory) {
              _newTypeBloc.add(NewTypeEdite<Catogory>(
                oldItem: item as Catogory,
                newItem: Catogory(id: id, name: newName),
              ));
            }
          },
        );
      },
    );
  }

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

extension on Object {
  where(bool Function(dynamic n) param0) {}
}

typedef OnConfirm<T> = void Function(String newValue);

class EditAddDialog<T> extends StatelessWidget {
  final String title;
  final String? initialValue;
  final List<String> existingNames;
  final OnConfirm<T> onConfirm;

  const EditAddDialog({
    super.key,
    required this.title,
    required this.onConfirm,
    required this.existingNames,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialValue);
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Название',
            hintText: 'Введите название',
          ),
          validator: (value) {
            final text = value?.trim() ?? '';
            if (text.isEmpty) return 'Поле не может быть пустым';
            if (existingNames.contains(text) && text != initialValue) {
              return 'Такое значение уже существует';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              onConfirm(controller.text.trim());
              Navigator.of(context).pop();
            }
          },
          child: const Text('Сохранить'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
