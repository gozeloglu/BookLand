import 'package:bookland/customer_address_add.dart';
import 'package:bookland/http_address.dart';
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
            // TODO Add new address page
            print("Action button");
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new CustomerAddressAdd()
                ),
            );
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
  Address _address = new Address();

  @override
  Widget build(BuildContext context) {
    return _addressListView(context);
  }

  Widget _addressListView(BuildContext context) {
    var ll = _address.getAddresses(1);
    //_address.getAddressList();
    print("********************************** $ll");
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<dynamic>>(
        future: _address.getAddresses(1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> addressLineList = List();
            List<String> cityCountryList = List();
            List<Icon> iconList = List();
            for (int i = 0; i < snapshot.data.length; i++) {
              addressLineList.add(snapshot.data[i]["addressLine"]);
              String cityCountry = snapshot.data[i]["postalCodeCity"]["city"]["city"];
              cityCountry += ", ";
              cityCountry += snapshot.data[i]["postalCodeCity"]["city"]["country"];
              cityCountryList.add(cityCountry);
              if (snapshot.data[i]["addressTitle"] == "School") {
                iconList.add(Icon(Icons.school));
              } else if (snapshot.data[i]["addressTitle"] == "Home") {
                iconList.add(Icon(Icons.home));
              } else if (snapshot.data[i]["addressTitle"] == "Office") {
                iconList.add(Icon(Icons.work));
              } else {
                iconList.add(Icon(Icons.local_post_office));
              }
            }
            return ListView.builder(
            //padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
            itemCount: addressLineList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ListTile(
                  leading: iconList[index],
                  trailing: Icon(Icons.arrow_right),
                  subtitle: Text(cityCountryList[index]),
                  title: Text(addressLineList[index]),
                  onTap: () {
                    // TODO Call address page
                    // TODO Alert dialog can be opened
                    print(addressLineList[index]);
                  },
            ),
          );
        });}
        return CircularProgressIndicator();
        })
    );
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
