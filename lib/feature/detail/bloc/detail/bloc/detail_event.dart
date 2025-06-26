part of 'detail_bloc.dart';

abstract class DetailEvent {}

class DetailStarted extends DetailEvent {
  final String id;

  DetailStarted({required this.id});
}

class MoveItem extends DetailEvent {
  final ItemTransferModel transferModel;

  MoveItem({required this.transferModel});
}

class DeliveryOfGoods extends DetailEvent {
  final DeliveryItemModel deliveryModel;

  DeliveryOfGoods({required this.deliveryModel});
}

class DetailWarehouseSearch extends DetailEvent {
  final String query;

  DetailWarehouseSearch({required this.query});
}

class ClearSearchResults  extends DetailEvent {
  
}

class DetailReceiverSearch extends DetailEvent {
  final String query;

  DetailReceiverSearch({required this.query});
}
