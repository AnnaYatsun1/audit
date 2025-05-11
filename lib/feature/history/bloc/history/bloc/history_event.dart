part of 'history_bloc.dart';

abstract class HistoryEvent {}

class HistoryStarted extends HistoryEvent {
    final String inventoryId;
  HistoryStarted({required this.inventoryId});
}
