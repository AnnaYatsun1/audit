import 'package:sound_level_meter/feature/history/model/history_model.dart';
import 'package:sound_level_meter/feature/location/model/location_model.dart';

class ItemTransferModel {
  final String id;
  final Warehouse warehouse;

  ItemTransferModel(this.id, this.warehouse);
}

class DeliveryItemModel {
  final String id;
  final LocationModel fromLocation;
  final LocationModel toLocation;
  final User receiver;
   final DateTime deliveryDate;

  DeliveryItemModel(this.deliveryDate, {required this.id, required this.fromLocation, required this.toLocation, required this.receiver});

  //   Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'fromLocation': fromLocation.toJson(),
  //     'toLocation': toLocation.toJson(),
  //     'receiver': receiver.toJson(),
  //     'deliveryDate': deliveryDate.toIso8601String(),
  //   };
  // }

  // // Метод для создания модели из JSON (если нужно для ответа от API)
  // factory DeliveryItemModel.fromJson(Map<String, dynamic> json) {
  //   return DeliveryItemModel(
  //     id: json['id'],
  //     fromLocation: LocationModel.fromJson(json['fromLocation']),
  //     toLocation: LocationModel.fromJson(json['toLocation']),
  //     receiver: User.fromJson(json['receiver']),
  //     deliveryDate: DateTime.parse(json['deliveryDate']),
  //   );
  // }
}
