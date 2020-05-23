import 'package:bookland/my_orders.dart';
import 'dart:math';
import 'package:bookland/services/globalVariable.dart';
import 'package:bookland/user_account.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bookland/login.dart';
import 'package:bookland/explore.dart';
import 'package:bookland/list_dynamic.dart';
import 'package:bookland/list_main.dart';
import 'package:bookland/bookview.dart';
import 'package:bookland/category.dart';
import 'package:bookland/adminAddBook.dart';
import 'package:bookland/payment.dart';
import 'package:bookland/adminOrders.dart';
import 'package:bookland/ShippingCompany.dart';
import 'package:bookland/basket.dart';
import 'package:shared_preferences/shared_preferences.dart';

String customerID;
bool isLogin;

void main() {
  mainFuture();
  runApp(MyApp());
}

/// This function controls the login situation
/// Reads shared preferences and assign to variables
/// isLogin : Boolean variable that shows the user logged in or not
/// customerId : String variable that shows the user's id
/// firstName : String variable that represents the user's name
Future<void> mainFuture() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  isLogin = sharedPreferences.getBool("isLogin");
  print(isLogin);
  print(sharedPreferences.getKeys());
  try {
    if (isLogin) {
      customerID = sharedPreferences.getString("customerId");
      //FIRSTNAME = sharedPreferences.getString("firstName");
      customerFirstName = sharedPreferences.getString("firstName");
      //print(FIRSTNAME);
    } else {
      customerID = "-1";
      customerFirstName = "Please Login";
    }
  } catch (Exception) {
    isLogin = false;
    customerID = "-1";
    sharedPreferences.setBool("isLogin", isLogin);
    sharedPreferences.setString("customerId", "-1");
    customerFirstName = "Please Login";
  }
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

//final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        title: const Text('BookLand',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          Container(
              child: IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new Login()),
                  );
                  // TODO Login page will be here
                },
              ),
              width: 30.0,
              height: 30.0),
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/toplist.png'),
                  padding: EdgeInsets.all(1.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 1)),
                    );
                  },
                  color: Colors.black,
                ),
                width: 400.0,
                height: 100.0,
              ),
              Text(" "),
              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/campaign.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 2)),
                    );
                  },
                  color: Colors.pink,
                ),
                width: 400.0,
                height: 100.0,
              ),
              Text(" "),
              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/last_r.jpg'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 3)),
                    );
                  },
                  color: Colors.orange,
                ),
                width: 400.0,
                height: 100.0,
              ),
              Text(" "),
              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/look_l.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 4)),
                    );
                  },
                  color: Colors.lightBlueAccent,
                ),
                width: 400.0,
                height: 100.0,
              ),
              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset('assets/best_seller.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 5)),
                    );
                  },
                  color: Colors.red,
                ),
                width: 400.0,
                height: 100.0,
              )
            ]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //  if(isAnyUserLogin == true)
            new UserAccountsDrawerHeader(
              accountName: new Text("HELLO\n" + customerFirstName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              // accountEmail: new Text('nurbuke.teker7@gmail.com'),
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
              onTap: () {
                if (isLogin) {
                  print(customerID == null);
                  print(customerFirstName);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new AccountPageStateless(customerFirstName)));
                } else {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new Login()),
                  );
                }
              },
            ),
//Section Line
            new Divider(),
            new ListTile(
              title: new Text("Orders"),
              trailing: new Icon(Icons.add_shopping_cart),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new MyOrders()),
                );
              },
            ),
//Section Line
            new Divider(),

            new ListTile(
              title: new Text("Library"),
              trailing: new Icon(Icons.library_books),
              onTap: () {},
            ),

            new Divider(),
            new ListTile(
              title: new Text("Campaigns"),
              trailing: new Icon(Icons.notifications_active),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ShippingCompany()),
                );
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Manuels"),
              trailing: new Icon(Icons.help),
              onTap: () {


              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.exit_to_app),
              onTap: () {
                isAnyUserLogin = false;
                //FIRSTNAME = "Please LogIn";
                customerFirstName = "Please Login";
                logout();
                updateUser();
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new MyApp()),
                );
              },
            ),
            new Divider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                  onPressed: () {
                    if (isLogin) {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Basket()));
                    } else {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Login()));
                    }
                  }),
            ])),
        color: Colors.blue,
      ),
    );
  }

  /// This function log outs the user
  /// Shared preferences updated with default variables
  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("customerId", "-1");
    sharedPreferences.setString("customerName", "Please Login");
    sharedPreferences.setBool("isLogin", false);
    customerFirstName = "Please Login";
    customerID = "-1";
    //FIRSTNAME = "Please Login";
  }

  /// This function updates the first name, isLogin and customerID
  /// with shared preferences values
  void updateUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    customerFirstName = sharedPreferences.getString("customerName");
    isLogin = sharedPreferences.getBool("isLogin");
    customerID = sharedPreferences.getString("customerId");
  }
}
