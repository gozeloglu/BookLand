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