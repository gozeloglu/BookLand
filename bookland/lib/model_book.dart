import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';

class Book {
  final int bookId;
  final int real_isbn;
  final String bookName;
  final String author;
  String description;
  String category;
  String subCategory;
  int inHotList;
  int status;
  int quantity;
  String bookImage;
  DateTime releasedTime;
  List<String> priceList;
  String price ;
  String firstPrice;
  int inDiscount;

  Book({
    this.bookId,
    this.real_isbn,
    this.bookName,
    this.author,
    this.description,
    this.category,
    this.subCategory,
    this.quantity,
    this.inHotList,
    this.status,
    this.bookImage,
    this.releasedTime,
    this.price,
    this.priceList,
    this.firstPrice,
    this.inDiscount
  });



  factory Book.fromJson(Map<String, dynamic> json) {
    print(json['priceList']);
    int lenOfList =  '{'.allMatches(json['priceList'].toString()).length  ;
    print(lenOfList);
    String real_price = json['priceList'][lenOfList-1]['price'].toString();
    print(real_price);
    String first_price = json['priceList'][0]['price'].toString();
    print(first_price);
    String discountTest = json['inDiscount'].toString();
    print("6666666666666666666666");
    print(discountTest);
    return Book(
        bookId: json['bookId'],
        real_isbn: json['realIsbn'],
        bookName: json['bookName'],
        author: json['author'],
        description: json['description'],
        category: json['category'],
        subCategory: json['subCategory'],
        quantity: json['quantity'],
        inHotList: json['inHotList'],
        status: json['status'],
        bookImage: json['bookImage'],
        price: real_price,
        firstPrice: first_price,
        inDiscount: json['inDiscount']
    );

  }
}
