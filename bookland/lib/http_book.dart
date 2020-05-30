import 'dart:convert';
import 'package:bookland/main.dart';
import 'package:bookland/model_book.dart';
import 'package:http/http.dart' as http;

class HttpBook {

  Future<Customer_Book_Model> getBook(String isbn) async {
    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get(
        'http://10.0.2.2:8080/getBookDetails/$isbn/$customerID',
      headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      Customer_Book_Model obj = Customer_Book_Model.fromJson(json.decode(response.body));

      return obj;
    } else {
      throw "Can't get books.";
    }
  }
}