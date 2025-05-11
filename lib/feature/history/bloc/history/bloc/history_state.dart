part of 'history_bloc.dart';

abstract class HistoryState {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoaded extends HistoryState {
  final List<HistoryModel> inventoryHistory;
  const HistoryLoaded(this.inventoryHistory);
}

class HistoryError extends HistoryState {
  final Object massage;
  const HistoryError(this.massage);
}
