import 'package:flutter/material.dart';
import 'dart:async';

class MyAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Addresses",
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Addresses"),
        ),
        body: MyAddressLayout(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            print("Action button");
          },
        ),
      ),
    );
  }
}

class MyAddressLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAddressLayoutState();
}

class MyAddressLayoutState extends State<MyAddressLayout> {
  List<String> addressList = [
    "Fatih mahallesi 3389 sokak no:14 kepez/antalya",
    "Beytepe Kampus"
  ];
  @override
  Widget build(BuildContext context) {
    return _addressListView(context);
  }

  Widget _addressListView(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
        itemCount: addressList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(30, 16, 30, 16),
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text(addressList[index]),
              onTap: () {
                print(addressList[index]);
              },
            ),
          );
        });
  }
}
/*
class MyAddress extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyAddress>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
        backgroundColor: Colors.red,
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Card(
                child: new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Column(
                    children: <Widget>[
                      new Text('Hello World'),
                      new Text('How are you?')
                    ],
                  ),
                ),
              ),
              new Card(
                child: new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Column(
                    children: <Widget>[
                      new Text('Hello World'),
                      new Text('How are you?')
                    ],
                  ),
                ),
              ),
              new Card(
                child: new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Column(
                    children: <Widget>[
                      new Text('Hello World'),
                      new Text('How are you?')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*
class MyAddresses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Addresses",
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blue)
      ),
      home: MyAddressesStateful(),
    );
  }
}

class MyAddressesStateful extends StatefulWidget {
  //MyAddressesStateful({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAddressesState();
}

class MyAddressesState extends State<MyAddressesStateful> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("My Addresses"),
      ),
      body: new ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, i) {
            return Container(
              height: 130,
              child: Card(
                elevation: 10,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          // TODO Fill it
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          }
      ),
    );
  }
}*/
