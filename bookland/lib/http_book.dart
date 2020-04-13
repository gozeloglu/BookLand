import 'dart:convert';
import 'dart:io';
import 'package:bookland/model_book.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:sprintf/sprintf.dart';
class HttpBook {

  Future<Book> getBook(String isbn) async {
    /*var client = http_auth.BasicAuthClient('Daryl', 'WalkingDead');
    var url = "http://localhost:8080/allBooks";
    print(url);
    var response = await client.get('http://localhost:8080/allBooks/basic-auth/Daryl/WalkingDead');*/
    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("Before GET");
    //127.0.0.1:8554
    http.Response response = await http.get('http://10.0.2.2:8080/getBookDetails/2',
      headers: <String, String>{'authorization': basicAuth});
    /*http.Response response = await http.get('10.0.2.2:8080/allBooks',
      headers: {HttpHeaders.authorizationHeader: basicAuth},);*/
    print("Geçti");
    //http.Response responseJSON = json.decode(response.body);
    print("Geçti");
    print(response.statusCode);
    print("Response body : $response.body");
    if (response.statusCode == 200) {
      print("just after if");
      Book obj = Book.fromJson(json.decode(response.body));
      print("******");
      print(obj.bookId);
      print("------");
      return obj;
    } else {
      throw "Can't get posts.";
    }
  }
}