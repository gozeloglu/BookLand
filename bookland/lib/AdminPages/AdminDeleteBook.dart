//ignore: avoid_web_libraries_in_flutter
//import 'dart:html';

import 'file:///C:/Users/User/Desktop/1/bbm384-project-spring2020-nef-gb/bookland/lib/AdminPages/adminAddBook.dart';
import 'file:///C:/Users/User/Desktop/1/bbm384-project-spring2020-nef-gb/bookland/lib/AdminPages/adminDiscount.dart';
import 'file:///C:/Users/User/Desktop/1/bbm384-project-spring2020-nef-gb/bookland/lib/AdminPages/adminUpdateBook.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/User/Desktop/1/bbm384-project-spring2020-nef-gb/bookland/lib/services/http_admin.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DeletePage(),
  ));
}
/*
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
}*/

class DeletePage extends StatefulWidget {
  @override
  _DeletePageState createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpAdmin httpAdmin = HttpAdmin();
  String isbn;
  TextEditingController isbnController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(pageTitle: "Delete Book", back: true,),
      body: Container(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: isbnController,
              onChanged: (value) {},
              decoration: InputDecoration(
                  labelText: "ISBN",
                  hintText: "Enter the ISBN",
                  prefixIcon: Icon(Icons.delete),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: FlatButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.red,
              onPressed: () {
                isbn = isbnController.text;
                var result = httpAdmin.adminDeleteBook(isbn);
                print(result);
              },
              child: Text("Delete", style: TextStyle(fontSize: 22)),
            ),
          )
        ]),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("Hello, Admin", style: TextStyle(fontSize: 35)),
              decoration: new BoxDecoration(color: Colors.red),
              margin: const EdgeInsets.only(bottom: 10.0),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new adminAddBook()),
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new adminUpdateBook()),
                );
              },
              child: ListTile(
                title: Text("Update Book", style: TextStyle(fontSize: 18)),
                leading: Icon(Icons.update),
              ),
            ),
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
                onPressed: () {},
                child: Text("Logout", style: TextStyle(fontSize: 22)),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            height: 50.0,
            child: Row(children: <Widget>[
              Text("           "),
              IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                  }),
              Text("           "),
              IconButton(
                  icon: Icon(Icons.category),
                  onPressed: () {
                  }),
              Text("           "),
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                  //  openPage(context);
                  }),
              Text("           "),
              IconButton(
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () {
                  }),
            ])),
        color: Colors.red,
      ),
    );
  }
}
