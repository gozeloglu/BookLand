import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/elements/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:bookland/AdminPages/OrderViewAdmin.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:bookland/services/HTTP.dart';
import 'package:bookland/services/globalVariable.dart';



Map<String, IconData> iconMapping = {
  'Shipped' : Icons.local_shipping,
  'Delivered' : Icons.done_outline,
  'Cancelled' : Icons.cancel,
  'Waiting Confirmation' : Icons.watch_later,
};

int total = 0;
SplayTreeSet orderIDset = new SplayTreeSet();
var globalExploreContext;
int deletedOrderId = -1;
List<String> choosenIcons = [];


class AdminOrders extends StatelessWidget {
  AdminOrdersStateless(int orderId) {
    deletedOrderId = orderId;
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
      title: 'Admin  Orders Page',
      home: AdminOrdersPage(),
    );
  }
}

class AdminOrdersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminOrdersState();
  }
}

class AdminOrdersState extends State<AdminOrdersPage> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(
        pageTitle: "Order",
        loginIcon: false,
        back: false,
        filter_list: false,
        search: true,
      ),
      drawer: MyDrawer(
        drawerHeader: "Hello Admin",
      ),
      body: Paginator.listView(
        key: paginatorGlobalKey,
        pageLoadFuture: sendordersDataRequest,
        pageItemsGetter: listordersGetter,
        listItemBuilder: listorderBuilder,
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
              pageLoadFuture: sendordersDataRequest, resetState: true);
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
      var urlorderCount = "http://10.0.2.2:8080/getOrderCountTotal";

      String _urlorderCount = Uri.encodeFull(urlorderCount);
      http.Response responseCount = await http.get(
        _urlorderCount,
        headers: <String, String>{'authorization': basicAuth},
      );

      if (responseCount.statusCode == 200) {
        total = json.decode(responseCount.body);
        print(total);
      } else {
        print(responseCount.statusCode);
        throw Exception("orders are not retrieved!");
      }
    } catch (e) {
      print("SocketException");
      throw Exception(e);
    }
  }

  Future<OrderData> sendordersDataRequest(int page) async {
    try {
      getTotalCount();

      var url = "http://10.0.2.2:8080/showAllOrdersAdmin/$page/50";
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

  List<dynamic> listordersGetter(OrderData ordersData) {
    List<dynamic> orderNameList = [];
    List<int> isbnList = [];
    choosenIcons = [];
    for (int i = 0; i < ordersData.ordersList.length; i++) {
      String val = "Order Date:\t" +
          ordersData.orderdatesList[i] +
          "\n\n" +
          "Order ID:\t" +
          ordersData.ordersList[i].toString() +
          "\n\n" +
          "Total Cost:\t\$" +
          ordersData.orderpricesList[i] +
          "\n\n" +
          "Order Customer:\t" +
          ordersData.orderCustomerList[i] +
          "\n\n" +
          "Order Status:\t" +
          ordersData.orderStatusList[i] + '\n\n' + "|"+   ordersData.ordersList[i].toString() ;
      orderNameList.add(val);
      choosenIcons.add(ordersData.orderStatusList[i].toString());
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

  Widget listorderBuilder(value, int index) {

    HTTPAll httpObj = new HTTPAll();
    String choseniconStr = choosenIcons[index].toString();

    var value_list = value.toString().split("|");
    String text_part = value_list[0];
    String orderidPar = value_list[1];
    if(choseniconStr == 'Waiting Confirmation'){
      return Card(
        child: ListTile(
          leading: new Icon(iconMapping[choseniconStr], color: Colors.black) ,
          title:  Text(text_part),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>new OrderViewAdmin(orderid : orderidPar),
                ));
          }, trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.beenhere),
                tooltip: 'Approve Order',
                onPressed: () {
                  var result = httpObj.adminApproveOrder(orderidPar);

                  Timer(Duration(seconds: 1), () {
                    if (errorControl == false) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: new Text("Order Approved"),
                            content: new Text("Approving order is successful"),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );


                    }
                    else {
                      errorControl = false;
                      Timer(Duration(seconds: 1), () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Can't Approve"),
                              content: new Text(errorMessage),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                  });


                  /*Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new MyApp(),
            )
            );*/
                },color: Colors.green
            ),// icon-1
            IconButton(
                icon: Icon(Icons.cancel),
                tooltip: 'Deny Order',
                onPressed: () {
                  var result = httpObj.adminDenyOrder(orderidPar);

                  Timer(Duration(seconds: 1), () {
                    if (errorControl == false) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: new Text("Order Cancelled"),
                            content: new Text("Order Denied"),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );


                    }
                    else {
                      errorControl = false;
                      Timer(Duration(seconds: 1), () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Can't Approve"),
                              content: new Text(errorMessage),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                  });

                },color: Colors.red
            ),// icon-2
          ],
        ),

        ),);
    }else{
      return Card(
          child: ListTile(
          leading: new Icon(iconMapping[choseniconStr], color: Colors.black) ,
    title:  Text(text_part),
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>new OrderViewAdmin(orderid : orderidPar),
    ));
    },));
    }

  }

  Widget errorWidgetMaker(OrderData ordersData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(ordersData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text("Retry"),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(OrderData ordersData) {
    orderIDset.clear();
    ordersData.ordersList.clear();
    ordersData.orderdatesList.clear();
    ordersData.orderpricesList.clear();
    ordersData.orderStatusList.clear();
    ordersData.orderCustomerList.clear();
    choosenIcons = [];
    return Center(
      child: Text("No order"),
    );
  }

  int totalPagesGetter(OrderData ordersData) {
    // TODO This should be fixed
    return total  ;
  }

  bool pageErrorChecker(OrderData ordersData) {
    return ordersData.statusCode != 200;
  }
}

class OrderData {
  List<dynamic> ordersList = new List<dynamic>();
  List<dynamic> orderdatesList = new List<dynamic>();
  List<dynamic> orderpricesList = new List<dynamic>();
  List<dynamic> orderStatusList = new List<dynamic>();
  List<dynamic> orderCustomerList = new List<dynamic>(); //TODO same process with others


  int statusCode;
  String errorMessage;
  int nItems;

  String OrderID;
  String OrderDate;
  String OrderOwner;
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
      orderdatesList.add(jsonData[i]["orderedDate"].toString());
      orderpricesList.add(jsonData[i]["totalAmount"].toString());
      orderStatusList.add(jsonData[i]["status"].toString());
      orderCustomerList.add((jsonData[i]["customerName"].toString() + "\t" + jsonData[i]["customerSurname"].toString()).toUpperCase());
    }

    nItems = ordersList.length;
  }

  OrderData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}