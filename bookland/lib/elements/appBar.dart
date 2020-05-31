import 'package:bookland/AdminPages/adminOrders.dart';
import 'package:bookland/CommonPages/filtering_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bookland/CommonPages/Search.dart';
import '../login.dart';
import '../main.dart';
// appbar hata verirse 4 bool değişkeninin değerleri yerleştirilmeli

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String pageTitle;
  bool back = false;
  bool filter_list = false;
  bool loginIcon  = false;
  bool search = false;

  MyAppBar({Key key, this.pageTitle, this.back, this.filter_list, this.loginIcon, this.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   // if (isAdmin == 1) {
     // return adminAppBar(context);
   // } else {
      return customerAppBar(context);
   // }
  }
  Widget customerAppBar(BuildContext context){
    print("burasıııııııııııııııııııııııııııııııı");
    return AppBar(
      title: Text(pageTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: <Widget>[
        Visibility(
          visible: back,
          child : IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Visibility(
          visible: loginIcon,
          child: IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new Login()),
              );
              // TODO Login page will be here
            },
          ) ,
        ),

        //Text('PROFILE', style: new TextStyle(color: Colors.white)),
        Visibility(
          visible: filter_list,
          child : IconButton(
            //child: new Text('OK', style: new TextStyle(color: Colors.white)),
            icon: new Icon(Icons.filter, color: Colors.white),
            color: Colors.green,
            padding: EdgeInsets.all(1.0),
            onPressed: () {
              print(pageTitle);
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new FilterStatefulWidget(pageTitle)), //TO
              );
            },
          ),),
        Visibility(
          visible: search,
          child: IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Page',
            onPressed: () {
              //Search s = new Search();
              //s.openPage(context);
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new Search()),
              );
            },
          ),
        ),

      ],
    );
  }

/*

  Widget adminAppBar(BuildContext context) {
    if (back == true) {
      if (filter_list == true) {
        return AppBar(
          //backgroundColor: Colors.blue,
          title: Text(pageTitle,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            // action button
            new IconButton(
              //child: new Text('OK', style: new TextStyle(color: Colors.white)),
              icon: new Icon(Icons.filter, color: Colors.white),
              color: Colors.green,
              padding: EdgeInsets.all(1.0),
              onPressed: () {
                print(pageTitle);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new FilterStatefulWidget(pageTitle)), //TO
                );
              },
            ),
          ],
        );
      }
      return AppBar(
        title: Text(pageTitle,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        //title: Text("Sign Up"),
        centerTitle: true,
        //drawer: ISADMIN == 1 ? MyDrawer(drawerHeader: "Hello Admin",) : MyDrawer(drawerHeader: "Hello User",),

        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    } else {
      return AppBar(
        title: Text(pageTitle,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        //title: Text("Sign Up"),
        centerTitle: true,
        //drawer: ISADMIN == 1 ? MyDrawer(drawerHeader: "Hello Admin",) : MyDrawer(drawerHeader: "Hello User",),
      );
    }
  }*/

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
