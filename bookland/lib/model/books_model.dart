import 'package:flutter/foundation.dart';

/// This class contains the objects which is the same in GET allBooks method
class Book {

  // TODO Real_Isbn should be added here
  int bookId;
  String bookName;
  String author;
  String description;
  String category;
  String subCategory;
  int inHotList;
  int status;
  int quantity;
  String bookImage;
  DateTime releasedTime;
  List<double> priceList;

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
    this.priceList,
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
      releasedTime: json['releasedTime'],
      priceList: json['priceList'],);
  }
}