import 'dart:ffi';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/http_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bookland/http_book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookland/basket.dart';
import 'package:bookland/main.dart';
import 'package:bookland/login.dart';


class customerPersonalInfo extends StatelessWidget {

  final String customerId;
  customerPersonalInfo({Key key, @required this.customerId}) : super(key: key);

  final HttpAdmin httpAdmin = HttpAdmin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          pageTitle: "Personal Info",
          // backgroundColor: Color(0xFFFF1744),
          back: true,
        ),
        body: FutureBuilder(
          future: httpAdmin.adminGetCustomerDetails(customerId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {

              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: new SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      fullName((snapshot.data.FirstName).toString(),
                          (snapshot.data.customerSurname).toString()),
                      Text("\n"),
                      customerIdWidget((snapshot.data.CustomerId).toString()),
                      Text("\n"),
                      customerEmail((snapshot.data.customerEmail).toString()),
                      customerPhone((snapshot.data.customerPhone).toString()),
                      customerDoB((snapshot.data.customerDoB).toString()),
                      updateProfileButton(context, customerID),
                    ],

                  ),
                ),
              );
            } else if (snapshot.hasError) {
              print("Snapshot has error*");
              return Text("${snapshot.error}");
            } else {
              print("datam yok error de yok");
              print(snapshot.data.toString());
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        bottomNavigationBar: MyBottomNavigatorBar());
  }


  Widget fullName(String text1, String text2) {
    String _customerName = text1;
    String _customerSurname = text2;
    String fullName = text1 + " " + text2;
    return Text(
      fullName,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customerIdWidget(String text) {
    return Text(
      '\nID: ' + text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customerEmail(String text) {
    return Text(
      'E-mail: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customerPhone(String text) {
    return Text(
      'Phone: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customerDoB(String text) {
    return Text(
      'Date Of Birth: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }


  Widget updateProfileButton(BuildContext context, String _customerId) {
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: Colors.orangeAccent,
        padding: const EdgeInsets.all(10.0),
        child: const Text('Update Profile', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
