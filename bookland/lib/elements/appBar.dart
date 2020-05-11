import 'package:bookland/adminOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget{
  final String pageTitle;
  final bool back;



  MyAppBar({Key key, this.pageTitle, this.back}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(back == true){
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