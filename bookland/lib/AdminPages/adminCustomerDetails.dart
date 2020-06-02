
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/services/http_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';



class adminCustomerDetails extends StatelessWidget {

  final String customerId;
  String customerIDLast;
  adminCustomerDetails({Key key, @required this.customerId}) : super(key: key);

  final HttpAdmin httpAdmin = HttpAdmin();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          pageTitle: customerId.toString(),
          // backgroundColor: Color(0xFFFF1744),
          back: false,
          loginIcon: false,
          filter_list: false,
          search: false,
        ),
        body: FutureBuilder(
          future: httpAdmin.adminGetCustomerDetails(customerId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: new SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      fullName((snapshot.data.FirstName).toString(),
                          (snapshot.data.customerSurname).toString()),
                      Text("\n"),
                      customerPhotoWidget(),
                      Text("\n"),
                      customerEmail((snapshot.data.customerEmail).toString()),
                      customerPhone((snapshot.data.customerPhone).toString()),
                      customerDoB((snapshot.data.customerDoB).toString()),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          ((snapshot.data.customerStatus) == 1 ? deactivateCustomer(context, snapshot) : activateCustomer(context, snapshot))
                      ],)
                      //customerPassword((snapshot.data.Password).toString()),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              print("Snapshot has error*");
              return Text("${snapshot.error}");
            } else {
              print("datam yok error de yok");
              print(snapshot.data.toString() + "detail");
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        bottomNavigationBar: MyBottomNavigatorBar());
  }


  Widget customerPhotoWidget() {
    return Container(
        child: Image.asset(
          'assets/logo.png',
          width: 200,
          height: 200,
        )
    );
  }


  Widget fullName(String text1, String text2) {
    String _customerName = text1;
    String _customerSurname = text2;
    String fullName = text1 + " " + text2;
    return Text(
      fullName,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customerIdWidget(String text) {
    return Text(
      '\nID: ' + text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customerEmail(String text) {
    return Text(
      'E-mail: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customerPhone(String text) {
    return Text(
      'Phone: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customerDoB(String text) {
    return Text(
      'Date Of Birth: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /*Widget customerPassword(String text) {
    return Text(
      'Password: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }*/


  Widget deactivateCustomer(BuildContext context, AsyncSnapshot snapshot) {
      return new Container(
          margin: EdgeInsets.only(top: 56.0, right: 18.0),
          child: new RaisedButton(
            onPressed: () {
              var result = httpAdmin.deactivateCustomer(customerId.toString());
              Navigator.of(context).pop();
            },
            padding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
            textColor: Colors.white,
            color: Colors.redAccent,
            child: const Text('Deactivate', style: TextStyle(fontSize: 20)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.deepOrange)
              )
          )
      );
  }

  Widget activateCustomer(BuildContext context, AsyncSnapshot snapshot) {
    return new Container(
        margin: EdgeInsets.only(top: 56.0, right: 18.0),
        child: new RaisedButton(
            onPressed: () {
              var result = httpAdmin.activateCustomer(customerId.toString());
              Navigator.of(context).pop();
            },
            padding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
            textColor: Colors.white,
            color: Colors.green,
            child: const Text('Activate', style: TextStyle(fontSize: 20)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.greenAccent)
            )
        )
    );
  }

  Widget emptyWidget() {
    mainAxisSize:
    MainAxisSize.min;
    return new Container(
      width: 100.0,
      height: 50,
      margin: const EdgeInsets.fromLTRB(
          0,56,20,0),
      padding: const EdgeInsets.fromLTRB(
          2, 15, 2, 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(60, 194, 70, 43),
        border: Border.all(color: Colors.red),
        borderRadius:
        BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        "Deactivated",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 122, 25, 4)
        ),
      ),
    );
  }

}
