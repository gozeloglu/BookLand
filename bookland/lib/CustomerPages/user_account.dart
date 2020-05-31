import 'package:bookland/CustomerPages/customerPersonalInfo.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/main.dart';
import 'package:bookland/CustomerPages/address_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookland/CustomerPages/my_orders.dart';
String username;

class AccountPageStateless extends StatelessWidget {
  AccountPageStateless(String name) {
    username = name;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: MyAppBar(
        pageTitle: "Account",
        loginIcon: true,
        back: false,
        filter_list: false,
        search: true,
      ),
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 120.0,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(
                            fit: StackFit.loose,
                            children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(

                                    width: 250.0,
                                    height: 70,
                                    margin: const EdgeInsets.fromLTRB(
                                        0,0,0,0),
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(60, 214, 253, 255),
                                      border: Border.all(color: Colors.blue),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Text(
                                      "Hello $username",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(top:30.0),
                  decoration: new BoxDecoration(
                    //color: Colors.green,
                  ),
                  //padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(children: <Widget>[
                    /* Padding(
                          padding: EdgeInsets.only(
                              left: 40.0, right: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    "User Account",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                              )
                            ],
                          ),
                        ), */
                    Padding(
                      padding: EdgeInsets.only(
                          left: 125.0, right: 25.0, top: 2.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new FlatButton(
                                onPressed: () {
                                  print("FIRST BUTTON");
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(builder: (context) => new MyOrders()),
                                  );

                                },
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "My Orders",
                                  style: TextStyle(fontSize: 24.0),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 115.0, right: 25.0, top: 25.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    print("SECOND ");
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => customerPersonalInfo(customerId: customerID)));
                                  },
                                  child: Text(
                                    "Personal Info",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 110.0, right: 25.0, top: 25.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => MyAddresses(),
                                      ),
                                    );
                                    print("THIRD BUTTON");
                                  },
                                  child: Text(
                                    "My Addresses",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                  ),

                ),

                new Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 190),
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      new Padding(
                          padding: EdgeInsets.only(top:10),
                          child: Text("Bookland - 2020",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                              )
                          )
                      )
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      ),
      /*body: Stack(
        children: <Widget>[
          nameWidget(username),
          accountContainer(),
        ],
      ),*/
    );
  }

  /// @param name represents user name
  /// @return Container widget
  Widget nameWidget(String name) {
    /// This function creates and returns text field
    /// that show user name and "Hello" message
    return Container(
      margin: const EdgeInsets.fromLTRB(100, 50, 100, 10),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(
        "Hello $name",
        textScaleFactor: 2,
      ),
    );
  }

  Widget accountContainer() {
    return Container(
      child: Stack(
        children: <Widget>[
          myOrdersCard(),
        ],
      ),
      margin: const EdgeInsets.fromLTRB(70, 190, 70, 10),
      padding: const EdgeInsets.fromLTRB(10, 40, 90, 40),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }

  Widget myOrdersCard() {
    return FlatButton(
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.red),
        ),
        //padding: const EdgeInsets.fromLTRB(10, 10, 40, 10),
        padding: const EdgeInsets.only(left: 10, right: 55),
        onPressed: () {
          print("My Orders is pressed!");

        },
        child: Column(children: <Widget>[
          /*Padding(
            padding: const EdgeInsets.all(16),
              child:
              Icon(Icons.arrow_forward_ios),
              Text(
                "My Orders",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),),*/
        ])
      /*child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          print("My Orders Card is tapped");
        },

        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
          child: Text(
            "My Orders"
          ),
        ),
      ),*/
    );
  }
}
