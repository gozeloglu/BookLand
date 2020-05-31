import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AdminPages/AdminDeleteBook.dart';
import '../AdminPages/AdminOrders.dart';
import '../AdminPages/adminAddBook.dart';
import '../AdminPages/adminCampaign.dart';
import '../AdminPages/adminDiscount.dart';
import '../main.dart';
import '../AdminPages/Admin_CustomerManage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class MyDrawer extends StatelessWidget {
  final String drawerHeader;

  const MyDrawer({Key key, this.drawerHeader}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(drawerHeader, style: TextStyle(fontSize: 35)),
            decoration: new BoxDecoration(color: Colors.red),
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new adminAddBook()),
              );
            },
            child: ListTile(
              title: Text("Add Book", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.add),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new DeletePage()),
              );
            },
            child: ListTile(
              title: Text("Delete Book", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.delete),
            ),
          ),
          /*
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new adminUpdateBook(book: null)),
              );
            },
            child: ListTile(
              title: Text("Update Book", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.update),
            ),
          ),*/
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new adminDiscount()),
              );
            },
            child: ListTile(
              title: Text("Discount", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.arrow_drop_down),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AdminOrders()),
              );
            },
            child: ListTile(
              title: Text("Orders", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.check),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new adminCampaign() ),
              );
            },
            child: ListTile(
              title: Text("Campaigns", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.money_off),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Admin_customerManageStateless(-1) ),
              );
            },
            child: ListTile(
              title: Text("Customer Manage", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.people),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: FlatButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.red,
              onPressed: () {
                isAnyUserLogin = false;

                logout();
                ///FIRSTNAME = "Please LogIn";
    Timer(Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new MyApp()),
                );});
              },
              child: Text("Logout", style: TextStyle(fontSize: 22)),
            ),
          )
        ],
      ),
    );
  }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("customerId", "-1");
    sharedPreferences.setString("customerName", "Please Login");
    sharedPreferences.setBool("isLogin", false);
    sharedPreferences.setInt("isAdmin", 0);
    customerFirstName = "Please Login";
    customerID = "-1";
    isAdmin = 0;

    //FIRSTNAME = "Please Login";
  }
}
