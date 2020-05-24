import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';


class Model_Order {
  final String OrderId;
  final String OrderDate;
  //final String CardNo;
  //final String CustomerId;
  final String OrderAddress;
  final String Status;
  final String TotalPrice;


  Model_Order({
    this.OrderId,
    this.OrderDate,
    this.OrderAddress,
    this.Status,
    this.TotalPrice,
  });


  factory Model_Order.fromJson(Map<String, dynamic> json) {

    return Model_Order(
        OrderId: json['orderId'].toString(),
        OrderDate: json['orderDate'].toString(),
        OrderAddress: json['addressTitle'].toString(),
        Status: json['status'].toString(),
        TotalPrice: json['totalAmount'].toString()
    );

  }
}
class Model_Order_Details {
  final String orderId;
  final String orderDate;

  final String status;
  final String totalPrice;

  final String country;
  final String city;
  final String order_customer ;

  final String cardNo ;
  final String orderAdressline ;

  final String companyName ;

  final String shippingPrice ;
  final List<Book> bookList;


  Model_Order_Details({
    this.orderId,
    this.orderDate,

    this.status,
    this.totalPrice,
    this.order_customer,
    this.country,
    this.city,

    this.cardNo,
    this.orderAdressline,
    this.companyName,
    this.shippingPrice,
    this.bookList
  });


  factory Model_Order_Details.fromJson(Map<String, dynamic> json) {
    var list = json['difference'] as List;
    print(list.toString());
    //List<Book> difference = list.map((i) => Book.fromJson(i)).toList();
    //print(difference.toString());

    List<Book> difference = list.map((i) => Book.fromJson(i)).toList();
    print("HERE I AM");
    return Model_Order_Details(
      //orderId:  json[],
       //order_customer : json['firstname'] + "\t" + json['surname'] ,
       orderDate: json['orderedTime'].toString(),
       orderAdressline: json['addressLine'].toString(),
       country:  json['country'].toString(),
       city: json['city'].toString(),
       companyName:  json['companyName'].toString(),
       bookList : difference,
        totalPrice: json['totalAmount'].toString(),
        shippingPrice:json['shippingPrice'].toString(),
      status:   json['status'].toString(),
    );

  }
}
class Book {
  final String bookName;
  final String author;
  final String quantity;
  final String bookImage;
  final String price ;
  final String trackingNo ;

  Book({
    this.bookName,
    this.author,
    this.quantity,
    this.bookImage,
    this.price,
    this.trackingNo
  });


  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        bookName: json['bookName'].toString(),
        author: json['author'].toString(),
        quantity: json['quantity'].toString(),
        bookImage: json['bookImage'].toString(),
        price: json['price'].toString(),
        trackingNo: json['trackingNumber'].toString()

    );

  }
}