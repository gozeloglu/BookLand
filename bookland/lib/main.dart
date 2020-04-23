import 'package:flutter/material.dart';
import 'package:bookland/login.dart';
import 'package:bookland/explore.dart';
import 'package:bookland/bookview.dart';
import 'package:bookland/adminAddBook.dart';

import 'package:bookland/adminOrders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'BookLand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyStatelessWidget(),


    );
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
var items = List<String>();



void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
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


/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {

  MyStatelessWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:  const Text('BookLand', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        actions: <Widget>[
          Container(
              child :IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,

                ),
                onPressed: () {
                  Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new Login()),
                  );
                  // TODO Login page will be here
                },
              )
              /***child : FlatButton(

                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/person.jpg'),
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {},
                  color: Colors.blue,
                  )*/,width: 30.0, height: 30.0),
          //Text('PROFILE', style: new TextStyle(color: Colors.white)),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Page',
            onPressed: () {
              openPage(context);
            },
          ),
        ],
      ),
      body: Center(
        child : Column(
            mainAxisAlignment: MainAxisAlignment.start ,
            children: <Widget>[
              /***
               *
                  - assets/last_r.jpg
                  - assets/look_l.png
                  - assets/best_seller.jpg
                  - assets/toplist.png
                  - assets/campaign.png

               */

              Container(

                child : new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/toplist.png'),
                  padding: EdgeInsets.all(1.0),
                  onPressed: () {},
                  color: Colors.black,

                )
                ,width: 400.0, height: 100.0,),
              Text(" "),
              Container(
                child : new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/campaign.png'),
                  onPressed: () {},
                  color: Colors.pink,

                )
                ,width: 400.0, height: 100.0,),
              Text(" "),
              Container(
                child : new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/last_r.jpg'),
                  onPressed: () {},
                  color: Colors.orange,

                )
                ,width: 400.0, height: 100.0,)
              ,
              Text(" "),
              Container(
                child : new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/look_l.png'),
                  onPressed: () {/*
                    Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => new BookView() )  ,
                    );*/

                  },
                  color: Colors.lightBlueAccent,

                )
                ,width: 400.0, height: 100.0,),

              Container(
                child : new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/best_seller.png'),
                  onPressed: () {},
                  color: Colors.red,

                )
                ,width: 400.0, height: 100.0,)]),


      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
          //  if(isAnyUserLogin == true)
            new UserAccountsDrawerHeader(accountName: new  Text('Nurbüke TEKER'),
              accountEmail: new Text('nurbuke.teker7@gmail.com'),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bookland__pp.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new ListTile(
              title: new Text("Account"),
              trailing: new Icon(Icons.account_circle),
              onTap: (){

              },
            ),
//Section Line
            new Divider(),
            new ListTile(
              title: new Text("Orders"),
              trailing: new Icon(Icons.add_shopping_cart),
              onTap: (){
            },
            ),
//Section Line
            new Divider(),

            new ListTile(
              title: new Text("Library"),
              trailing: new Icon(Icons.library_books),
              onTap: (){
              },
            ),

            new Divider(),
            new ListTile(
              title: new Text("Campaigns"),
              trailing: new Icon(Icons.notifications_active),
              onTap: (){
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Manuels"),
              trailing: new Icon(Icons.help),
              onTap: (){
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Exit"),
              trailing: new Icon(Icons.exit_to_app),
              onTap: (){
              },
            ),
            new Divider(),

          ],
        ),),
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
                      icon : Icon(Icons.explore),

                      onPressed :() {
                        Navigator.push(
                          context, new MaterialPageRoute(builder: (context) => new ExploreStateless()),
                        );
                      }
                  ),
                  Text("           "),
                  IconButton(
                      icon : Icon(Icons.shopping_basket),

                      onPressed :() {
                        Navigator.push(
                          context, new MaterialPageRoute(builder: (context) => new adminOrders ()), //adminAddBook()
                        );
                        print("Icon shopping_basket Pressed !!");
                      }
                  ),
                ]

            )

        ),
        color : Colors.blue,
      ),
    );
  }

}
