import 'package:bookland/CustomerPages/my_orders.dart';
import 'package:bookland/elements/drawer.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:bookland/CustomerPages/user_account.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bookland/login.dart';
import 'package:bookland/CommonPages/list_main.dart';
import 'package:bookland/CommonPages/category.dart';
import 'package:bookland/CustomerPages/basket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookland/CustomerPages/Campaigns.dart';
import 'CommonPages/Search.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/CustomerPages/wishList.dart';

String customerID;
bool isLogin;
int isAdmin = 0;

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
  try {
    if (isLogin) {
      customerID = sharedPreferences.getString("customerId");
      customerFirstName = sharedPreferences.getString("firstName");
      isAdmin = sharedPreferences.getInt("isAdmin");
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

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //key: scaffoldKey,
      appBar: MyAppBar(pageTitle: "BookLand",
        loginIcon: true,
        back: false,
        filter_list: false,
        search: true,
      ),
      body: SingleChildScrollView(
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
                  //////
                  assets/mainPage/NBS.png
                  - assets/mainPage/NC.png
                  - assets/mainPage/NLR.png
                  - assets/mainPage/NRFY.png
                  - assets/mainPage/NTL.png
               */

              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset(
                    'assets/mainPage/NBS.png',
                    width: 500,
                  ),
                  padding: EdgeInsets.all(1.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 1)),
                    );
                  },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 100.0,
              ),
              Container(
                child: new FlatButton(
                  onPressed: () { },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 10.0,
              ),
              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset(
                    'assets/mainPage/NC.png',
                    width: 500,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CampaignsStateless(-1)),
                    );
                  },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 100.0,
              ),  Container(
                child: new FlatButton(
                  onPressed: () { },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 10.0,
              ),
              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset(
                    'assets/mainPage/NLR.png',
                    width: 500,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 3)),
                    );
                  },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 100.0,
              ),  Container(
                child: new FlatButton(
                  onPressed: () { },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 10.0,
              ),
              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset(
                    'assets/mainPage/NRFY.png',
                    width: 500,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 4)),
                    );
                  },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 100.0,
              ),    Container(
                child: new FlatButton(
                  onPressed: () { },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 10.0,
              ),
              Container(
                child: new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Image.asset(
                    'assets/mainPage/NTL.png',
                    width: 500,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new List_MainStateless(-1, 5)),
                    );
                  },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 100.0,
              ),
              Container(
                child: new FlatButton(
                  onPressed: () { },
                  color: Colors.blueGrey.shade100,
                ),
                width: 600.0,
                height: 100.0,
              ),
            ]),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: MyBottomNavigatorBar(),
    );
  }

  /// This function log outs the user
  /// Shared preferences updated with default variables
  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("customerId", "-1");
    sharedPreferences.setString("customerName", "Please Login");
    sharedPreferences.setBool("isLogin", false);
    sharedPreferences.setInt("isAdmin", 0);
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
    isAdmin = sharedPreferences.getInt("isAdmin");
    customerID = sharedPreferences.getString("customerId");
  }
}