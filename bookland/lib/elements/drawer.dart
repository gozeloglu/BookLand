import 'package:bookland/adminUpdateBook.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AdminDeleteBook.dart';
import '../adminAddBook.dart';
import '../adminDiscount.dart';
import '../admin_drawer_update_book.dart';
import '../main.dart';

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
            onTap: () {},
            child: ListTile(
              title: Text("Orders", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.check),
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
                ISADMIN = 0;
                ///FIRSTNAME = "Please LogIn";
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new MyApp()),
                );
              },
              child: Text("Logout", style: TextStyle(fontSize: 22)),
            ),
          )
        ],
      ),
    );
  }
}
