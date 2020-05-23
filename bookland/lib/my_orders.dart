import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_paginator/flutter_paginator.dart';

int total = 0;
SplayTreeSet orderIDset = new SplayTreeSet();
var globalExploreContext;
int deletedOrderId = -1;

class MyOrders extends StatelessWidget {
  ExploreStateless(int bookId) {
    deletedOrderId = bookId;
    if (orderIDset.contains(deletedOrderId)) {
      orderIDset.remove(deletedOrderId);
    }
  }

  @override
  Widget build(BuildContext context) {
    globalExploreContext = context;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      title: 'My Orders Page',
      home: MyOrdersPage(),
    );
  }
}

class MyOrdersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyOrdersState();
  }
}

class MyOrdersState extends State<MyOrdersPage> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(pageTitle: "My Orders" ),
      body: Paginator.listView(
        key: paginatorGlobalKey,
        pageLoadFuture: sendBooksDataRequest,
        pageItemsGetter: listBooksGetter,
        listItemBuilder: listBookBuilder,
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
              pageLoadFuture: sendBooksDataRequest, resetState: true);
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
      var urlBookCount = "http://10.0.2.2:8080/getBookCount";

      String _urlBookCount = Uri.encodeFull(urlBookCount);
      http.Response responseCount = await http.get(
        _urlBookCount,
        headers: <String, String>{'authorization': basicAuth},
      );

      if (responseCount.statusCode == 200) {
        total = json.decode(responseCount.body);
        print(total);
      } else {
        print(responseCount.statusCode);
        throw Exception("Books are not retrieved!");
      }
    } catch (e) {
      print("SocketException");
      throw Exception(e);
    }
  }

  Future<OrderData> sendBooksDataRequest(int page) async {
    try {
      //getTotalCount();
      page = 1;
      var url = "http://10.0.2.2:8080/myOrders/1/10/103";
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
      return OrderData.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return OrderData.withError("Please check your internet connection.");
      } else {
        print(e.toString());
        return OrderData.withError("Something went wrong.");
      }
    }
  }

  List<dynamic> listBooksGetter(OrderData ordersData) {
    List<dynamic> orderNameList = [];
    List<int> isbnList = [];
    for (int i = 0; i < ordersData.ordersList.length; i++) {
      String val = "Order Date:\t" +
          ordersData.orderdatesList[i] +
          "\n" +
          "Order ID:\t" +
          ordersData.ordersList[i].toString() +
          "\n" +
          "Total Cost:\t" +
          ordersData.orderpricesList[i] +
          "\n" +
          "Order Status:\t" +
          ordersData.orderStatusList[i];
      orderNameList.add(val);
    }

    return orderNameList;
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget listBookBuilder(value, int index) {


    return ListTile(
      //  leading:  Image.network(img_part),
        title: Text(value),
        onTap: () {
          /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                // new BookView(isbn: isbnSet.elementAt(index).toString()),
                new BookView(isbn: bookid_send),
              ));*/
        });
  }

  Widget errorWidgetMaker(OrderData booksData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(booksData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text("Retry"),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(OrderData booksData) {
    orderIDset.clear();
    booksData.ordersList.clear();
    booksData.orderdatesList.clear();
    booksData.orderpricesList.clear();
    booksData.ordersadresstitleList.clear();
    booksData.orderStatusList.clear();
    return Center(
      child: Text("No order"),
    );
  }

  int totalPagesGetter(OrderData booksData) {
    // TODO This should be fixed
    return total =2 ;
  }

  bool pageErrorChecker(OrderData booksData) {
    return booksData.statusCode != 200;
  }
}

class OrderData {
  List<dynamic> ordersList = new List<dynamic>();
  List<dynamic> orderdatesList = new List<dynamic>();
  List<dynamic> orderpricesList = new List<dynamic>();
  List<dynamic> ordersadresstitleList = new List<dynamic>();
  List<dynamic> orderStatusList = new List<dynamic>();

  int statusCode;
  String errorMessage;
  int nItems;

  String orderId;
  String OrderId;
  String OrderDate;
  String OrderAddress;
  String Status;
  String TotalPrice;

  OrderData.fromResponse(http.Response response) {
    this.statusCode = response.statusCode;
    List jsonData = json.decode(response.body);
    print(jsonData);

    if (orderIDset.contains(deletedOrderId)) {
      orderIDset.remove(deletedOrderId);
    }

    for (int i = 0; i < jsonData.length; i++) {
      ordersList.add(jsonData[i]["orderId"].toString());
      orderdatesList.add(jsonData[i]["orderDate"].toString());
      orderpricesList.add(jsonData[i]["totalAmount"].toString());
      ordersadresstitleList.add(jsonData[i]["addressTitle"].toString());
      orderStatusList.add(jsonData[i]["status"]);
    }

    nItems = ordersList.length;
  }

  OrderData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}
