import 'package:bookland/AdminDeleteBook.dart';
import 'package:bookland/admin_drawer_update_book.dart';

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
                  onChanged: (value) {
                  },
                  //controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('book'), //https://blog.usejournal.com/flutter-search-in-listview-1ffa40956685
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


class adminOrders extends StatelessWidget{
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

class adminOrdersStatefulWidget extends StatefulWidget{
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
          appBar: AppBar(
            title: const Text('Orders',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            //title: Text("Sign Up"),
            centerTitle: true,
          ),

          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: Text("Hello, Admin", style: TextStyle(fontSize: 35)),
                  decoration: new BoxDecoration(
                      color: Colors.red
                  ),
                  margin: const EdgeInsets.only(bottom: 10.0),
                ),


                InkWell(
                  onTap: (){Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new adminAddBook()),
                  );},
                  child: ListTile(
                    title: Text("Add Book", style: TextStyle(fontSize: 18)), leading: Icon(Icons.add),

                  ),
                ),

                InkWell(
                  onTap: (){Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new DeletePage()),
                  );},
                  child: ListTile(
                    title: Text("Delete Book", style: TextStyle(fontSize: 18)), leading: Icon(Icons.delete),

                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => new admin_drawer_update_book()),
                    );
                  },
                  child: ListTile(
                    title: Text("Update Book", style: TextStyle(fontSize: 18)), leading: Icon(Icons.update),

                  ),
                ),

                InkWell(
                  onTap: (){Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new adminDiscount()),
                  );},
                  child: ListTile(
                    title: Text("Discount", style: TextStyle(fontSize: 18)), leading: Icon(Icons.arrow_drop_down),

                  ),
                ),

                InkWell(
                  onTap: (){Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new adminOrders()),
                  );},
                  child: ListTile(
                    title: Text("Orders", style: TextStyle(fontSize: 18)), leading: Icon(Icons.check),

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
                    onPressed: (){},
                    child: Text("Logout", style: TextStyle(fontSize: 22)),
                  ),
                )
              ],

            ),
          ),


          body:  Container(
            child : ListView(
              children: <Widget>[
                new ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      children: <Widget>[
                        Expanded(child:new IconButton(
                            icon: Icon(Icons.check_circle_outline, color: Colors.green, size: 30,),
                            tooltip: 'Confirm',
                            onPressed: () {}),
                        ),
                        Expanded(child: new IconButton(
                            icon: Icon(Icons.highlight_off, color: Colors.red, size:30),
                            tooltip: 'Decline',
                            onPressed: () {}))
                      ],
                    ),


                  ),


              ],

            )

            ),



          bottomNavigationBar: BottomAppBar(
            child : Container(
                height : 50.0,

                child : Row(
                    children : <Widget>[
                      Text("           "),
                      IconButton(
                          icon :  Icon(Icons.home),
                          onPressed :() {
                            print("Icon home Pressed !!");
                          }
                      ),
                      Text("           "),
                      IconButton(
                          icon : Icon(Icons.category),
                          onPressed :() {
                            print("Icon category Pressed !!");
                          }
                      ),
                      Text("           "),
                      IconButton(
                          icon : Icon(Icons.search),
                          onPressed :() {
                            openPage(context);
                          }
                      ),
                      Text("           "),
                      IconButton(
                          icon : Icon(Icons.shopping_basket),
                          onPressed :() {
                            print("Icon shopping_basket Pressed !!");
                          }
                      ),
                    ]
                )
            ),
            color : Colors.red,
          ),

        )
    );





  }




}
