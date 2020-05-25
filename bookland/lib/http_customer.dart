import 'dart:convert';
import 'dart:io';
import 'package:bookland/adminAddBook.dart';
import 'package:bookland/adminUpdateBook.dart';
import 'package:bookland/model_book.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:sprintf/sprintf.dart';
import 'package:bookland/model/error.dart';

import 'model/model_user.dart';

class HttpCustomer {
  Future<String> updateCustomerProfile (String customerId, String firstname, String surname, /*String password,*/
      String DateofBirth, String phoneNumber, String email) async {

    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    http.Response response;
    response = await http.post(
      'http://10.0.2.2:8080/updateCustomer/$customerId',
      headers: <String, String>{
        'Authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, dynamic>{
        "FirstName": firstname,
        "surname": surname,
        "dateOfBirth": DateofBirth,
        "phoneNumber": phoneNumber,
        "email": email,
        //"Password":  password
      }
      ),
    );
    print(response.statusCode);
    if (response.statusCode < 400) {
      print(response.body);
      return  "PERFECT";
    } else {
      errorControl = true;
      errorMessage = "Updating Profile has Failed";
      return "SORRRY" ;
    }
  }
}