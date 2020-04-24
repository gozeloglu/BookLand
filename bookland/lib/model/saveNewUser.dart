// TODO Implement this library.
import 'package:flutter/foundation.dart';


class SaveNewUser{
  String FirstName;
  String SurName;
  String Password;
  int IsAdmin = 0;
  String Email;
  String DateOfBirth;
  String PhoneNumber;

  SaveNewUser({
    this.FirstName,
    this.SurName,
    this.Password,
    this.IsAdmin,
    this.Email,
    this.DateOfBirth,
    this.PhoneNumber
  });

  factory SaveNewUser.fromJson(Map<String, dynamic> json) {
    return SaveNewUser(
        FirstName: json['firstName'],
        SurName: json['surname'],
        Email: json['email'],
        Password: json['password'],
        IsAdmin: json['isAdmin'],
        DateOfBirth: json['dateOfBirth'],
        PhoneNumber: json['phoneNumber'],

    );
  }

}