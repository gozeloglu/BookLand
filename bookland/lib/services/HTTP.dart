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
        'email': _email,
        'password': _password,
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
      //print(response.body);

     // Error msg = Error.fromJson(json.decode(response.body));
     // print(msg.errors[0].toString());
      isAnyUserLogin = false;

    }
  }


  Future<String> saveCustomer(String firstName, String surname, String email,
      String password, int isAdmin, String phoneNumber) async {
    http.Response response = await http.post('http://10.0.2.2:8080/saveCustomer',
      headers: <String, String>{
        'Authorization': HTTPAll.basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, dynamic>{
      "firstName": firstName,
      "surname": surname,
      "email": email,
      "password": password,
      "isAdmin": isAdmin,
      "dateOfBirth": null,
      "phoneNumber": phoneNumber,
      }
      ),
    );

    //print(response.statusCode);
   // print(response.body);
    if (response.statusCode < 400) {

    } else {
      Error msg = Error.fromJson(json.decode(response.body));
      errorControl == true;
      errorMessage = msg.errors[0].toString();
    }
  }





}