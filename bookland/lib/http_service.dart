import 'dart:convert';
import 'package:bookland/books_model.dart';
import 'package:http/http.dart';
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
  final String postsURL = "https://localhost:8080/allBooks";

  Future<List<Post>> getPosts() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
      )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}