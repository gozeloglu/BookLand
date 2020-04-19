// TODO Implement this library.
import 'package:flutter/foundation.dart';


class User{
  String firstName;
  String CustomerId;
  String Password;
  int IsAdmin;

  User({
    this.firstName,
    this.CustomerId,
    this.Password,
    this.IsAdmin
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['firstname'],
        CustomerId: json['customerId'],
        Password: json['password'],
      IsAdmin: json['isAdmin']

    );
  }

}