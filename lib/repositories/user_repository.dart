import 'package:cool_transaction/models/user.dart';

class UserRepository {
  var users = [
    User(1, "mx@test.com", "abc123"),
    User(2, "choonfei@test.com", "abc123"),
    User(3, "yisheng@test.com", "abc123"),
  ];

  Future<bool> login(String email, String password) async {
    return users
        .any((user) => user.email == email && user.password == password);
  }
}
