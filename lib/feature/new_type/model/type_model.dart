import 'package:equatable/equatable.dart';

class Catogory extends Equatable {
  final String id;
  final String name;

    const Catogory({required this.id, required this.name});

  @override
  List<Object?> get props => [id];

    factory Catogory.fromJson(Map<String, dynamic> json) {
    return Catogory(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
