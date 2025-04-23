import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name}}/feature/{{feature_name.snakeCase()}}/repository/{{feature_name.snakeCase()}}_repository.dart';

part '{{bloc_name.snakeCase()}}_event.dart';
part '{{bloc_name.snakeCase()}}_state.dart';

class {{bloc_name.pascalCase()}}Bloc extends Bloc<{{bloc_name.pascalCase()}}Event, {{bloc_name.pascalCase()}}State> {
  {{bloc_name.pascalCase()}}Bloc(this._repository) : super(const {{bloc_name.pascalCase()}}Initial()) {
    on<{{bloc_name.pascalCase()}}Started>((event, emit) async {
      // TODO: Implement logic here
    });
  }

  final {{feature_name.pascalCase()}}Repository _repository;
}
