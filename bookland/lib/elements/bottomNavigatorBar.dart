import 'package:bookland/adminOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../basket.dart';
import '../category.dart';
import '../explore.dart';
import '../login.dart';
import '../main.dart';

class MyBottomNavigatorBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("---------" + isAdmin.toString());
    if(isAdmin == 1){
      return adminbootomNavi(context);
    }
    else{
      return customerbottomNavi(context);
    }
  }
  Widget customerbottomNavi(BuildContext context){
    return BottomAppBar(
      child: Container(
          height: 50.0,
          child: Row(children: <Widget>[
            Text("           "),
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            Text("           "),
            IconButton(
                icon: Icon(Icons.category),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new NT()),
                  );
                }),
            Text("           "),
            IconButton(
                icon: Icon(Icons.explore),
                onPressed: () {
                  /* Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ExploreStateless(-1)),
                    );*/
                }),
            Text("           "),
            IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () async {
                  if (isLogin) {
                    Basket basket = new Basket(0);
                    SharedPrefBooks _sharedPrefBooks = new SharedPrefBooks();
                    _sharedPrefBooks.getOrdersFromSharedPref(customerID);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Basket(0)));
                  } else {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Login()));
                  }
                }),
          ])),
      color: Colors.blue,
    );
  }
  Widget adminbootomNavi(BuildContext context){
    print("admiiiiin");
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

          ])
      ),
      color: Colors.red,

    );
  }

}