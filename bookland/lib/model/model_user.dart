// TODO Implement this library.
import 'package:flutter/foundation.dart';


class User{
  String FirstName;
  String CustomerId;
  String Password;
  int IsAdmin;
  String customerSurname;
  String customerEmail;
  String customerDoB;
  String customerPhone;

  User({
    this.FirstName,
    this.CustomerId,
    this.Password,
    this.IsAdmin,
    this.customerSurname,
    this.customerEmail,
    this.customerDoB,
    this.customerPhone
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      FirstName: json['firstName'],
      CustomerId: json['customerId'],
      Password: json['password'],
      IsAdmin: json['isAdmin'],
      customerSurname: json['surname'],
      customerEmail: json['email'],
      customerDoB: json['dateOfBirth'],
      customerPhone: json['phoneNumber'],
    );
  }

}