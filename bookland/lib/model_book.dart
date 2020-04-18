import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';

class Book {
  final int bookId;
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

  Book({
    this.bookId,
    this.bookName,
    this.author,
    this.description,
    this.category,
    this.subCategory,
    this.inHotList,
    this.status,
    this.quantity,
    this.bookImage,
    this.releasedTime,
    this.price,
    this.priceList
  });


  factory Book.fromJson(Map<String, dynamic> json) {
    print(json['priceList']);
    int lenOfList =  '{'.allMatches(json['priceList'].toString()).length  ;
    print(lenOfList);
    String real_price = json['priceList'][lenOfList-1]['price'].toString();
    print(real_price);
    return Book(
        bookId: json['bookId'],
        bookName: json['bookName'],
        author: json['author'],
        description: json['description'],
        category: json['category'],
        subCategory: json['subCategory'],
        inHotList: json['inHotList'],
        status: json['status'],
        quantity: json['quantity'],
        bookImage: json['bookImage'],
        price: real_price

    );

  }
}
/**class Price {
  String price;

  Price({
    this.price
  });
  factory Price.fromJson(List<dynamic> json) {
    return Price(
      //price :json['price']
    );
  }

}**/