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
        OrderId: json['shippingCompanyId'],
        OrderDate: json['shippingPrice'].toString(),
        OrderAddress: json['website'],
        Status: json['companyName'],
        TotalPrice: json['companyName']
    );

  }
}