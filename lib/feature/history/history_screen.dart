import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/history/bloc/history/bloc/history_bloc.dart';
import 'package:sound_level_meter/feature/history/bloc/history/repository/history_repository.dart';
import 'package:intl/intl.dart';
import 'package:sound_level_meter/feature/home/filter/view/filtre_screen.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryBloc _historyBloc = HistoryBloc(HistoryRepository());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _historyBloc.add(HistoryStarted(inventoryId: '1'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
        bloc: _historyBloc,
        builder: (context, state) {
          if (state is HistoryInitial) {
         return Center(child: CustomLoadingIndicator());
          } else if (state is HistoryLoaded) {
            return CustomScaffold(
              appBarIsVisible: true,
              child: ListView.builder(
                itemCount: state.inventoryHistory.length,
            
                itemBuilder: (context, index) {
                  final item = state.inventoryHistory[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    color: Color(0xFF1E1E1E),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Дата изменения
                          Text(
                            DateFormat('yyyy-MM-dd – kk:mm').format(item.date),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Описание изменения
                          Text(
                            'Cтатус обьекта: ${item.status.name}',
                            // item["change"] ?? 'Зміна невідома',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Пользователь, который сделал изменение
                          Text(
                            'Користувач: ${item.typeWorker.toString()}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Divider между изменениями
                          Divider(color: Colors.grey[700]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
