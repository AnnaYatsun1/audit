import 'package:sound_level_meter/feature/history/model/history_model.dart';

class HistoryRepository {
  List<HistoryModel> items = [
    HistoryModel(
        date: DateTime(2025, 5, 11, 14, 17, 0),
        status: ItemStatus.fixed,
        typeWorker: TypeWorker.user),
    HistoryModel(
        date: DateTime(2025, 1, 11, 14, 17, 0),
        status: ItemStatus.fixed,
        typeWorker: TypeWorker.admin),
    HistoryModel(
        date: DateTime(2025, 1, 03, 14, 17, 0),
        status: ItemStatus.fixed,
        typeWorker: TypeWorker.admin),
           HistoryModel(
        date: DateTime(2025, 1, 03, 14, 17, 0),
        status: ItemStatus.fixed,
        typeWorker: TypeWorker.zavscladom)
  ];
  Future<List<HistoryModel>> loadHistoryInformation(String byId) async {
    return items;
  }
}
