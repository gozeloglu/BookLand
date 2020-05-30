import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:bookland/bookview.dart';
import 'package:bookland/customerBookView.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/main.dart';
import 'package:bookland/adminOrders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_paginator/flutter_paginator.dart';

int total = 0;
SplayTreeSet customerSet = new SplayTreeSet();
var globalAdmin_customerManageContext;
int deletedCustId = -1;

final List<Color> colors = <Color>[Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange,Colors.indigo, Colors.purple,Colors.pink,Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange,Colors.indigo,Colors.purple,Colors.pink,Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange,Colors.indigo,Colors.purple,Colors.pink];

class Admin_customerManageStateless extends StatelessWidget {
  Admin_customerManageStateless(int custId) {
    deletedCustId = custId;
    if (customerSet.contains(deletedCustId)) {
      customerSet.remove(deletedCustId);
    }
  }

  @override
  Widget build(BuildContext context) {
    globalAdmin_customerManageContext = context;
    GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
    return Scaffold(
      appBar: MyAppBar(pageTitle: "Customer Manage", back: true,filter_list:false ),
      body: Paginator.listView(
        key: paginatorGlobalKey,
        pageLoadFuture: sendCustomerDataRequest,
        pageItemsGetter: listCustomerGetter,
        listItemBuilder: listCustomerBuilder,
        loadingWidgetBuilder: loadingWidgetMaker,
        errorWidgetBuilder: errorWidgetMaker,
        emptyListWidgetBuilder: emptyListWidgetMaker,
        totalItemsGetter: totalPagesGetter,
        pageErrorChecker: pageErrorChecker,
        scrollPhysics: BouncingScrollPhysics(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          paginatorGlobalKey.currentState.changeState(
              pageLoadFuture: sendCustomerDataRequest, resetState: true);
        },
        child: Icon(Icons.refresh),
      ),


      bottomNavigationBar: MyBottomNavigatorBar(),

    );
  }

  void getTotalCount() async {
    try {
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var urlBookCount = "http://10.0.2.2:8080/getCustomerCount";

      String _urlBookCount = Uri.encodeFull(urlBookCount);
      http.Response responseCount = await http.get(
        _urlBookCount,
        headers: <String, String>{'authorization': basicAuth},
      );

      if (responseCount.statusCode == 200) {
        total = json.decode(responseCount.body);

      } else {
        print(responseCount.statusCode);
        throw Exception("Customers are not retrieved!");
      }
    } catch (e) {
      print("SocketException");
      throw Exception(e);
    }
  }

  Future<CustomerData> sendCustomerDataRequest(int page) async {
    try {
      getTotalCount();
      var url = "http://10.0.2.2:8080/manageCustomers/$page/10";
      print(url);
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String _url = Uri.encodeFull(url);
      http.Response response = await http.get(
        _url,
        headers: <String, String>{'authorization': basicAuth},
      );

      return CustomerData.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return CustomerData.withError("Please check your internet connection.");
      } else {
        print(e.toString());
        return CustomerData.withError("Something went wrong.");
      }
    }
  }

  List<dynamic> listCustomerGetter(CustomerData customerData) {
    List<dynamic> customerList = [];
    List<int> isbnList = [];
    for (int i = 0; i < customerData.customerIds.length; i++) {
      String val = "Customer ID:\t" +
          customerData.customerIds[i] +
          "\n" +
          "E-Mail:\t" +
          customerData.emails[i] +
            "|" +
          customerData.avatarIcon[i] ;

      customerList.add(val);
    }

    return customerList;
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget listCustomerBuilder(value, int index) {
    List<String> valueList = value.split("|");
    String customerInfo = valueList[0];
    String mailAvatar = valueList[1].toUpperCase();

    return Card(

        child :ListTile(
          leading:  CircleAvatar(
            backgroundColor: colors[(index% 23)],
            child: Text(mailAvatar),
          ),
          title: Text(customerInfo,style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),) ,
          dense: false,

          onTap: () {
            /*
            BuildContext context;
            Navigator.push(
                globalAdmin_customerManageContext,
                MaterialPageRoute(
                  builder: (context) =>
                  // new BookView(isbn: isbnSet.elementAt(index).toString()),
                  new BookView(isbn: bookid_send),
                ));
          */},
        ),);

  }

  Widget errorWidgetMaker(CustomerData customerData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(customerData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text("Retry"),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(CustomerData customerData) {
    customerSet.clear();
    customerData.customerIds.clear();
    customerData.emails.clear();
    customerData.avatarIcon.clear();

    return Center(
      child: Text("No customer in the app"),
    );
  }

  int totalPagesGetter(CustomerData booksData) {
    return total;
  }

  bool pageErrorChecker(CustomerData booksData) {
    return booksData.statusCode != 200;
  }
}

class CustomerData {
  List<dynamic> customerIds = new List<dynamic>();
  List<dynamic> emails = new List<dynamic>();
  List<dynamic> avatarIcon = new List<dynamic>();



  int statusCode;
  String errorMessage;
  int nItems;

  int customerid;
  String customerMail;


  CustomerData.fromResponse(http.Response response) {
    this.statusCode = response.statusCode;
    List jsonData = json.decode(response.body);

    if (customerSet.contains(deletedCustId)) {
      customerSet.remove(deletedCustId);
    }

    for (int i = 0; i < jsonData.length; i++) {
      customerIds.add(jsonData[i]["customerId"]);
      emails.add(jsonData[i]["email"]);
      String firstname = jsonData[i]["firstName"].toString();
      String lastname = jsonData[i]["surname"].toString();
      avatarIcon.add(firstname.substring(0,1).toString()+ lastname.substring(0,1).toString());

    }

    nItems = customerIds.length;
  }

  CustomerData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}
