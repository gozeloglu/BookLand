import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';

class Model_ShippingCompany {
  final int shippingCompanyId;
  final String shippingPrice;
  final String website;
  final String companyName;

  Model_ShippingCompany({
    this.shippingCompanyId,
    this.shippingPrice,
    this.website,
    this.companyName,
  });


  factory Model_ShippingCompany.fromJson(Map<String, dynamic> json) {

    return Model_ShippingCompany(
        shippingCompanyId: json['shippingCompanyId'],
        shippingPrice: json['shippingPrice'].toString(),
        website: json['website'],
        companyName: json['companyName']
    );

  }
}