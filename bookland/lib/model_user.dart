// TODO Implement this library.
import 'package:flutter/foundation.dart';


class User{
  String name;
  String password;

  User({
    this.name,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        password: json['password']
    );
  }

}