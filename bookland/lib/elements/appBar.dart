import 'package:bookland/adminOrders.dart';
import 'package:bookland/filtering_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget{
  final String pageTitle;
  final bool back;
  final filter_list;



  MyAppBar({Key key, this.pageTitle, this.back ,this.filter_list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(back == true){
      if(filter_list == true){
        return AppBar(
          //backgroundColor: Colors.blue,
          title: Text( pageTitle,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed:() {Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new adminOrdersStatefulWidget()),//TODO kullanıcıya göre değişcek
            );},
          ),
          actions: <Widget>[
            // action button
            new FlatButton(
              //child: new Text('OK', style: new TextStyle(color: Colors.white)),
              child: new Text("FILTER"),
              color: Colors.green,
              padding: EdgeInsets.all(1.0),
              onPressed:() {
                print(pageTitle);
                Navigator.push(
                context, new MaterialPageRoute(builder: (context) => new FilterStatefulWidget(pageTitle)),//TO
              );},
            ),
          ],);
      }
      return AppBar(
        title: Text( pageTitle,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        //title: Text("Sign Up"),
        centerTitle: true,
        //drawer: ISADMIN == 1 ? MyDrawer(drawerHeader: "Hello Admin",) : MyDrawer(drawerHeader: "Hello User",),

        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed:() {Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new adminOrders()),
          );},
        ),
      );

    }else{
      return AppBar(
        title: Text( pageTitle,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        //title: Text("Sign Up"),
        centerTitle: true,
        //drawer: ISADMIN == 1 ? MyDrawer(drawerHeader: "Hello Admin",) : MyDrawer(drawerHeader: "Hello User",),
      );
    }

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}