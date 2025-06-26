
   import 'package:sound_level_meter/feature/history/model/history_model.dart';

abstract class UserRepository {
  Future<List<User>> loadUsers();
}
   

  class ImplementUserRepository implements UserRepository {
 final List<User> _users = [
      User('1', "Олег", null, TypeWorker.admin),
      User('2', "Анна", null, TypeWorker.user),
      User('3', "Ігор", null, TypeWorker.zavscladom),
  ];

  @override
  Future<List<User>> loadUsers() async {
    // тут в будущем будет реальный API-запрос
    return List<User>.from(_users);
  }
}