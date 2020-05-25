import 'dart:convert';
import 'package:http/http.dart' as http;
import '../books_model.dart';

class HttpBook {

  Future<Book> getBook(int pageNo) async {
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get(
        'http://10.0.2.2:8080/Search/$pageNo/1/9',
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      Book obj = Book.fromJson(json.decode(response.body));
      print(obj.bookId);
      return obj;
    } else {
      throw "Can't get books.";
    }
  }
}