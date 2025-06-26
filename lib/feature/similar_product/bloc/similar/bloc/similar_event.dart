part of 'similar_bloc.dart';

abstract class SimilarEvent {}

class SimilarStarted extends SimilarEvent {
  //TODO: 

  final String brand;
  SimilarStarted({required this.brand});

}

class SimilartemDetail extends SimilarEvent {
  InventoryItemView _inventoryItem;
  SimilartemDetail(this._inventoryItem);
}
