part of 'edit_bloc.dart';

abstract class EditEvent {}

class EditStarted extends EditEvent {}

class EditApplay extends EditEvent {
  final TechniqueList updateModel;

  EditApplay({required this.updateModel});
}
