import 'package:bookland/adminOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../explore.dart';
import '../main.dart';

class MyBottomNavigatorBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
          height: 50.0,
          child: Row(children: <Widget>[
            Text("           "), //TODO Değiştirilmesi gerek bu şekilde boşluk koymamalıyız
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new AdminOrders()),
                  );
                }),
            Text("           "),
            IconButton(
                icon: Icon(Icons.category),
                onPressed: () {
                  print("Icon category Pressed !!");
                }),
            Text("           "),
            IconButton(
                icon: Icon(Icons.search),
                onPressed :() {
                  Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new ExploreStateless(-1)),
                  );
                }),
            Text("           "),
            IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () {
                  print("Icon shopping_basket Pressed !!");
                }),
          ])
      ),
      color: Colors.red,

    );
  }

}