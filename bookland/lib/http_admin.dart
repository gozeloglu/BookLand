import 'dart:convert';
import 'dart:io';
import 'package:bookland/adminAddBook.dart';
import 'package:bookland/model_book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:sprintf/sprintf.dart';

class HttpAdmin {
  Future<String> adminAddBook(String isbn,String book_name,String book_category,String book_sub_category,String book_author,String book_img,String book_description ,String book_price) async {
    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post('http://10.0.2.2:8080/addBook',
      headers: <String, String>{'Authorization': basicAuth,'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'bookId': isbn,
        "bookName": book_name,
        "bookImage": book_img,
        "author": book_author,
        "price": book_price,
        "description": book_description,
        "category" : book_category,
        "subCategory" : book_sub_category
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
      print("YEHUUUU");
      return  "PERFECT";
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("Bloweddd");
      throw Exception('Failed to load album');
      return "SORRRY" ;
    }
  }
}