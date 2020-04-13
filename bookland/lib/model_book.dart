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
  double price;

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
    this.price
  });

  factory Book.fromJson(Map<String, dynamic> json) {
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
        price: json['priceList'][0]['price']
    );
  }
}