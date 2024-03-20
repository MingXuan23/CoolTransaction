import 'dart:convert';

import 'package:cool_transaction/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  var users = [
    User(1, "mx@test.com", "abc123","Mingxuan"),
    User(2, "choonfei@test.com", "abc123","Fei"),
    User(3, "yisheng@test.com", "abc123","Yisheng"),
  ];

  Future<bool> login(String email, String password) async {
    bool loginStatus = users
        .any((user) => user.email == email && user.password == password);
    if(loginStatus){
        User user = users.firstWhere((user) => user.email == email && user.password == password);
        String userJson = json.encode(user.toJson());

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', userJson);

    } 
    return loginStatus;
  }

  Future<bool> register(String email, String password) async {
    bool loginStatus = users
        .any((user) => user.email == email && user.password == password);
    if(loginStatus){
      User user = users.firstWhere((user) => user.email == email && user.password == password);
      String userJson = json.encode(user.toJson());

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', userJson);

    }
    return loginStatus;
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
