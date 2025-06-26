part of 'new_type_bloc.dart';

abstract class NewTypeEvent {}

class NewTypeStarted extends NewTypeEvent {}

class NewTypeEdite<T> extends NewTypeEvent {
  final T oldItem;
  final T newItem;
  NewTypeEdite({required this.oldItem, required this.newItem});
}

class NewTypeDelete<T> extends NewTypeEvent {
    final T item;
  NewTypeDelete(this.item);
}

class NewTypeCreate<T> extends NewTypeEvent {
    final T item;
  NewTypeCreate(this.item);
}
