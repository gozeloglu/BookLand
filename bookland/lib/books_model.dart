import 'package:flutter/foundation.dart';

/// This class contains the objects which is the same in GET allBooks method

/*class Book {
  final int bookId;
  final String bookName;
  final String author;
  final String description;
  final String category;
  final String subCategory;
  final int inHotList;
  final int status;
  final String image;
  final DateTime releasedTime;
  // TODO price will be added here

  Book({
    @required this.bookId,
    @required this.bookName,
    @required this.author,
    @required this.image,
    @required this.category,
    @required this.description,
    @required this.subCategory,
    @required this.inHotList,
    @required this.status,
    @required this.releasedTime,
});

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
      image: json['bookImage'] as String,
      releasedTime: json['releasedTime'] as DateTime,
    );
  }
}*/
class Post {
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
}