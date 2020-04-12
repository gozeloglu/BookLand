import 'package:flutter/foundation.dart';

/// This class contains the objects which is the same in GET allBooks method

class Book {
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
  // TODO price will be added here

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
});

  Book.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    bookName = json['bookName'];
    author = json['author'];
    description = json['description'];
    category = json['category'];
    subCategory = json['subCategory'];
    inHotList = json['inHotList'];
    status = json['status'];
    quantity = json['quantity'];
    bookImage = json['bookImage'];
    releasedTime = json['releasedTime'];
  }
  /*
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'] as int,
      bookName: json['bookName'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      subCategory: json['subCategory'] as String,
      inHotList: json['inHotList'] as int,
      status: json['status'] as int,
      quantity: json['quantity'] as int,
      bookImage: json['bookImage'] as String,
      releasedTime: json['releasedTime'] as DateTime,
    );
  }*/
}
/*class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    @required this.userId,
    @required this.id,
    @required this.title,
    @required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}*/