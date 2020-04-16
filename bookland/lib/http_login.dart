import 'dart:convert';
import 'dart:io';
import 'package:bookland/model_user.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:sprintf/sprintf.dart';

class HttpLogin {
  Future<User> getUser(String name, String pass) async {
    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post('http://10.0.2.2:8080/login',
        headers: <String, String>{'Authorization': basicAuth,'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': 'a@a',
          'password':'buralarhepsifre',
        }
        ),
    );

    print(response.statusCode);
    if (response.statusCode < 400) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
     // User user = User.fromJson(json.decode(response.body));
      //print(user.FirstName);
      print(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}