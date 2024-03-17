import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User{
  final int? id;
  final String email;
  final String password;
  final String name;

  User(this.id, this.email, this.password,this.name);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id']??0,
      json['email']??"",
      json['password']??"",
      json['name']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
    };
  }

   static Future<User> userFromSharedPreference() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      if (userJson == null) {
        throw Exception('Login Expired');
      }
      final user = User.fromJson(json.decode(userJson));
      return user;
    }
  
}