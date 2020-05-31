import 'dart:convert';
import 'dart:io';
import 'file:///C:/Users/User/Desktop/1/bbm384-project-spring2020-nef-gb/bookland/lib/model/books_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;


/*
class HttpService {
  final String getAllBooksURL = "http://localhost:8080/";

  Future<List<Book>> getAllBooks() async {
    Response response = await get(getAllBooksURL);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Book> books = body.map((dynamic item) => Book.fromJson(item),
      ).toList();
      return books;
    } else {
      throw "Books are not get!";
    }
  }

}*/


class HttpService {


  Future<List<Book>> getBooks(int pageNum) async {
    /*var client = http_auth.BasicAuthClient('Daryl', 'WalkingDead');
    var url = "http://localhost:8080/allBooks";
    print(url);
    var response = await client.get('http://localhost:8080/allBooks/basic-auth/Daryl/WalkingDead');*/
    var client = http.Client();
    var url = "http://10.0.2.2:8080/allBooks/";
    String page = pageNum.toString();
    url += page;
    url += "/5/";
    print(url);
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("Before GET");
    //127.0.0.1:8554
    final response = await http.get(url,
    headers: <String, String>{'authorization': basicAuth},);
    /*http.Response response = await http.get('10.0.2.2:8080/allBooks',
      headers: {HttpHeaders.authorizationHeader: basicAuth},);*/
    print("Geçti");
    //http.Response responseJSON = json.decode(response.body);
    print("Geçti");
    print(response.statusCode);
    print("Response body : $response.body");
    if (response.statusCode == 200) {
      print("just after if");

      ////Map<String, dynamic> body = jsonDecode(response.body);
      List bookResponse = jsonDecode(response.body);
      print("Before return");
      // print(bookResponse[0]);
      List<Book> books = new List();
      for (int i = 0; i < 5; i++) {
        books.add(bookResponse[i]);
      }
      print(books.length);
      print(books);
      return books;
      /// return bookResponse.map((book) => new Book.fromJson(book)).toList();
      //var book = Book.fromJson(json.decode(bookResponse));
      /*print("after jsonDecode");
      print(response.body.length);
      print(response.body);
      print("******************");*/
      // TODO Below line should be fixed
      /////List<Book> books = body.map((String item) => Book.fromJson(item),).toList();
      /*print("After List");
      print("RESPONSE ==>");
      print(response.body);
      print("=========");*/
      // print(book.length);
      //return book;
    } else {
      throw Exception("Can't get books.");
    }
  }
}