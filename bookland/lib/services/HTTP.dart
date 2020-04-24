import 'dart:convert';
import 'package:bookland/model/model_user.dart';
import 'package:bookland/model/error.dart';
import 'package:http/http.dart' as http;
import 'package:bookland/services/globalVariable.dart';


class HTTPAll{
  static String basicAuth = 'Basic ' + base64Encode(utf8.encode('Daryl:WalkingDead'));
  Future getUser(String _email, String _password) async {
    http.Response response = await http.post('http://10.0.2.2:8080/login',
      headers: <String, String>{
        'Authorization': HTTPAll.basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': 'admin@a',//_email,
        'password':'12345678', // _password,
      }
      ),
    );

    if (response.statusCode < 400) {
      User obj = User.fromJson(json.decode(response.body));
      CUSTOMERID = obj.CustomerId;
      FIRSTNAME = obj.FirstName;
      ISADMIN =  obj.IsAdmin;
      isAnyUserLogin = true;
    } else {
      Error msg = Error.fromJson(json.decode(response.body));
      errorMessage = msg.error;
      isAnyUserLogin = false;

    }
  }


  Future<String> saveCustomer(String isbn) async {
    http.Response response = await http.post('http://10.0.2.2:8080/saveCustomer',
      headers: <String, String>{
        'Authorization': HTTPAll.basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, dynamic>{
      "firstName": "kassa",
      "surname": "Grimes",
      "email": "admin@a",
      "password": "12345678",
      "isAdmin": "1",
      "dateOfBirth": null,
      "phoneNumber": "05426547869",
      }
      ),
    );

    print(response.statusCode);
    if (response.statusCode < 400) {
      print(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("Bloweddd");
      throw Exception('Failed to load album');
      return "SORRRY" ;
    }
  }





}