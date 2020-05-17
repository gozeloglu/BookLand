import 'package:bookland/AdminDeleteBook.dart';
import 'package:bookland/adminOrders.dart';
import 'package:bookland/adminUpdateBook.dart';
import 'package:flutter/material.dart';
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


class adminDiscount extends StatelessWidget{
  static const String _title = 'AdminDiscount';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: _title,
      home: adminDiscountStatefulWidget(),
    );
  }

}

class adminDiscountStatefulWidget extends StatefulWidget{
  adminDiscountStatefulWidget({Key key}) : super(key: key);

  @override
  _AdminDiscountState createState() => _AdminDiscountState();
}

class _AdminDiscountState extends State<adminDiscountStatefulWidget> {
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
              title: const Text('Discount Book',
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
                        context, new MaterialPageRoute(builder: (context) => new adminUpdateBook()),
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


            body: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: new Stack(
                children: <Widget>[
                  _showForm()
                ],
              ),


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
                          }
                      ),
                      Text("           "),
                      IconButton(
                          icon : Icon(Icons.category),
                          onPressed :() {
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
  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(1.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showISBNInput(),
            showDiscountInput(),
            showDiscountButton()
          ],
        ),
      ),
    );
  }

  Widget showISBNInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Book ISBN',
          icon: new Icon(
            Icons.label_important,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) => value.isEmpty ? 'Book ISBN cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showDiscountInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Discount',
          icon: new Icon(
            Icons.arrow_downward,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),

        //onSaved: (value) => _email = value.trim(),
      ),
    );

  }

  Widget showDiscountButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          color: Colors.red,
          disabledColor: Colors.redAccent,
          //add this to your code,
          child: new Text("Apply Discount",
              //asdfgh
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
            _formKey.currentState.validate();
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new MyApp(),
                )
            );
          }),
    );
  }
}
