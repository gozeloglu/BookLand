// TODO Implement this library.
import 'package:flutter/foundation.dart';


class User{
  String FirstName;
  String CustomerId;
  String Password;
  int IsAdmin;

  User({
    this.FirstName,
    this.CustomerId,
    this.Password,
    this.IsAdmin
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        FirstName: json['firstname'],
        CustomerId: json['customerId'],
        Password: json['password'],
      IsAdmin: json['isAdmin']

    );
  }

}