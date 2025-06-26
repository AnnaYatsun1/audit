
import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final String id;
  final String name;

  Brand(this.id, this.name);


  @override
  List<Object?> get props => [id];
   @override
  String toString() => 'Brand(id: $id, name: $name)';
}