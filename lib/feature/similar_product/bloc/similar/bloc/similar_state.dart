part of 'similar_bloc.dart';

abstract class SimilarState {
  const SimilarState();
}

class SimilarInitial extends SimilarState {
  const SimilarInitial();
}


class SimilarLoaded extends SimilarState {
  final List<SimilarInventoryItem> similarInventoryItem;
  const SimilarLoaded(this.similarInventoryItem);
}

class SimilarError extends SimilarState {
  final Object massage;
  const SimilarError(this.massage);
}
