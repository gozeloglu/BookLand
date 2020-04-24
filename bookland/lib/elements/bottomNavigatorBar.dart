import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomNavigatorBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
          height: 50.0,
          child: Row(children: <Widget>[
            Text("           "),
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  print("Icon home Pressed !!");
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
                onPressed: () {
                  //openPage(context);
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