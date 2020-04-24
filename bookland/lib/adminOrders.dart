import 'package:bookland/AdminDeleteBook.dart';
import 'package:bookland/admin_drawer_update_book.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/elements/drawer.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adminDiscount.dart';
import 'main.dart';
import 'adminAddBook.dart';
import 'dart:io';
import 'dart:convert';

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Search'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {},
                  //controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'book'), //https://blog.usejournal.com/flutter-search-in-listview-1ffa40956685
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  ));
}

class adminOrders extends StatelessWidget {
  static const String _title = 'AdminOrders';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: _title,
      home: adminOrdersStatefulWidget(),
    );
  }
}

class adminOrdersStatefulWidget extends StatefulWidget {
  adminOrdersStatefulWidget({Key key}) : super(key: key);

  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<adminOrdersStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          appBar: MyAppBar(
            pageTitle: "Order",
          ),
          drawer: MyDrawer(
            drawerHeader: "Hello Admin",
          ),
          //drawer: ISADMIN == 1 ? MyDrawer(drawerHeader: "Hello Admin",) : MyDrawer(drawerHeader: "Hello User",),

          body: Container(
              child: ListView(
            children: <Widget>[
              new ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: new IconButton(
                          icon: Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 30,
                          ),
                          tooltip: 'Confirm',
                          onPressed: () {}),
                    ),
                    Expanded(
                        child: new IconButton(
                            icon: Icon(Icons.highlight_off,
                                color: Colors.red, size: 30),
                            tooltip: 'Decline',
                            onPressed: () {}))
                  ],
                ),
              ),
            ],
          )),

          bottomNavigationBar: MyBottomNavigatorBar(),
        )
    );
  }
}
