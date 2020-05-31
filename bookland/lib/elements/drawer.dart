import 'package:bookland/CustomerPages/my_orders.dart';
import 'package:bookland/CustomerPages/user_account.dart';
import 'package:bookland/CustomerPages/wishList.dart';
import 'package:bookland/manual.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AdminPages/AdminDeleteBook.dart';
import '../AdminPages/AdminOrders.dart';
import '../AdminPages/adminAddBook.dart';
import '../AdminPages/adminCampaign.dart';
import '../AdminPages/adminDiscount.dart';
import '../login.dart';
import '../main.dart';
import '../AdminPages/Admin_CustomerManage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class MyDrawer extends StatelessWidget {
  final String drawerHeader;

  const MyDrawer({Key key, this.drawerHeader}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(isAdmin == 1){
      return adminDrawer(context);
    }
    else{
      return customerDrawer(context);
    }
  }

  Widget customerDrawer(BuildContext context){
    return Drawer(
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
            trailing: new Icon(Icons.account_circle,color : Colors.blue),
            onTap: () {
              if (isLogin) {
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
            trailing: new Icon(Icons.add_shopping_cart,color: Colors.green,),
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
            title: new Text("Wish List"),
            trailing: new Icon(Icons.favorite,color: Colors.red,),
            onTap: () {
              Navigator.push(
                context, new MaterialPageRoute(builder: (context) => new WishListStateless(-1)),
              );


            },
          ),

          new Divider(),
          new ListTile(
            title: new Text("Campaigns"),
            trailing: new Icon(Icons.notifications_active,color: Colors.yellow,),
            onTap: () {},
          ),
          new Divider(),
          new ListTile(
            title: new Text("Manual"),
            trailing: new Icon(Icons.help,color:  Colors.purple,),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => Manual()),
              );
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
    );
  }
  Widget adminDrawer(BuildContext context){
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("Admin", style: TextStyle(fontSize: 35)),
            decoration: new BoxDecoration(color: Colors.red),
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new adminAddBook()),
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
          /*
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new adminUpdateBook(book: null)),
              );
            },
            child: ListTile(
              title: Text("Update Book", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.update),
            ),
          ),*/
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
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AdminOrders()),
              );
            },
            child: ListTile(
              title: Text("Orders", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.check),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new adminCampaign() ),
              );
            },
            child: ListTile(
              title: Text("Campaigns", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.money_off),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Admin_customerManageStateless(-1) ),
              );
            },
            child: ListTile(
              title: Text("Customer Manage", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.people),
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
              onPressed: () {
                isAnyUserLogin = false;

                logout();
                ///FIRSTNAME = "Please LogIn";
                Timer(Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new MyApp()),
                  );});
              },
              child: Text("Logout", style: TextStyle(fontSize: 22)),
            ),
          )
        ],
      ),
    );
  }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("customerId", "-1");
    sharedPreferences.setString("customerName", "Please Login");
    sharedPreferences.setBool("isLogin", false);
    sharedPreferences.setInt("isAdmin", 0);
    customerFirstName = "Please Login";
    customerID = "-1";
    isAdmin = 0;

    //FIRSTNAME = "Please Login";
  }
  void updateUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    customerFirstName = sharedPreferences.getString("customerName");
    isLogin = sharedPreferences.getBool("isLogin");
    isAdmin = sharedPreferences.getInt("isAdmin");
    customerID = sharedPreferences.getString("customerId");
  }
}
