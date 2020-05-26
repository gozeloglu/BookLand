import 'dart:async';
import 'dart:ffi';

import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/services/HTTP.dart';

import 'package:flutter/foundation.dart';
import 'package:bookland/http_book.dart';
import 'package:bookland/model/model_order.dart';

class OrderViewAdmin extends StatelessWidget {
  final String orderid;
  OrderViewAdmin({Key key, @required this.orderid}) : super(key: key);
  final  HTTPAll httporder = HTTPAll();



  static const String _title = 'OrderViewAdmin';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: MyAppBar(
          pageTitle: "Admin Order Details",
          // backgroundColor: Color(0xFFFF1744),
          back: true,
        ),
        body: FutureBuilder(

          future: httporder.getOrderAdmin(orderid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print("snapshot has data");

              print("Here");
              //print(snapshot.data.orderDate,snapshot.data.orderId,snapshot.data.orderAdressline,snapshot.data.city,snapshot.data.country);
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: new SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      orderSummary( context,snapshot.data.orderDate.toString(),snapshot.data.companyName.toString(),snapshot.data.orderAdressline.toString(),snapshot.data.city.toString(),snapshot.data.country.toString()),
                      SizedBox(
                        height: (snapshot.data.bookList.length).toDouble() * 200 ,
                        child: new ListView.builder(
                          //scrollDirection: Axis.vertical,
                          itemCount:  snapshot.data.bookList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return  orderBooks( snapshot.data.bookList[index]) ;
                          },
                        ),
                      ),
                      costTotal(snapshot.data.totalPrice.toString(),snapshot.data.shippingPrice.toString()),
                      status(snapshot.data.status.toString())
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              print("Snapshot has error*");
              return Text("${snapshot.error}");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        bottomNavigationBar: MyBottomNavigatorBar()
    );
  }

  Widget imageorder(String url) {
    return new Stack(
      children: <Widget>[
        /**Image.asset(
            'assets/ordering/order1.jpg',
            height: 300,
            width: 200,
            ),**/
        Image.network(url)
      ],
    );
  }

  Widget orderCustomer(String orderdate,String orderid, String addressline,String city ,String country) {
    String allAdress = addressline +"\t" + city +"\t" + country;
    return  Container(
      width: 500,
      height: 300,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text("\t\tOrder Date:" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t" + orderdate ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),

          Text("\t\tOrder Number/ID" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t" +orderid ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),


          Text("\t\tDelivery Address" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t" +allAdress ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),

          RaisedButton(child: Text("Information Contract",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)), onPressed: () {}),
          RaisedButton(child: Text("Sales Contract",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)), onPressed: () {}),

        ],
      ),
    );
  }

  Widget orderSummary(BuildContext context,String orderdate,String shippingComp, String addressline,String city ,String country) {
    String allAdress = addressline +"\t" + city +"\t" + country;
    return  Container(
      width: 500,
      height: 300,
      //color: Colors.greenAccent,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
        //border: new Border.all(color: Colors.grey[500]),
        //color: Colors.indigo,
        image: DecorationImage(
          image: AssetImage("assets/orderdetails/background1.jpg"),
          fit: BoxFit.fill,

        ),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("\t\t\t\t\t\t\t\t\t\tOrder Summary\n" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22), ),
          Text("\t\tOrder Date:" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t" + orderdate ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),

          Text("\t\tShipping Company" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t" +shippingComp ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),


          Text("\t\tDelivery Address" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t" +allAdress ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),

          RaisedButton(child: Text("Information Contract",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)), onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                // new BookView(isbn: isbnSet.elementAt(index).toString()),
                new TextFull(),
              ));}),
          RaisedButton(child: Text("Sales Contract",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)), onPressed: () {   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                // new BookView(isbn: isbnSet.elementAt(index).toString()),
                new TextFull(),
              ));}),

        ],
      ),
    );
  }

  Widget orderBooks(Book book_obj) {
    print("HEREEE");
    return  Container(
        width: 100,
        height: 200,
        //color: Colors.green,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(5.0),
        decoration: new BoxDecoration(
          //border: new Border.all(color: Colors.grey[500]),
          //color: Colors.indigo,
          image: DecorationImage(
            image:AssetImage("assets/orderdetails/background3.jpg"),
            fit: BoxFit.fill,

          ),),

        child : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Image.network(book_obj.bookImage , width: 100, height:200),
            Text("\t"),
            Column(
                children: <Widget>[
                  Text("\t\tOrdered Tracking No:" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15), ),
                  Text("\t\t" + book_obj.trackingNo ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13), ),
                  Text("\t\tOrdered Book Name:" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15), ),
                  Text("\t\t" + book_obj.bookName ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13), ),
                  Text("\t\tAuthor:" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15), ),
                  Text("\t\t" + book_obj.author ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13), ),
                  Text("\t\tQuantity:" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15), ),
                  Text("\t\t" + book_obj.quantity ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13), ),
                  Text("\t\tPrice" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15), ),
                  Text("\t\t\$" + book_obj.price ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13), ),
                  Spacer()])
          ],

        ));

  }
  Widget costTotal(String totalCost,String shippingCost) {
    return  Container(
      width: 500,
      height: 200,
      //color: Colors.lime,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
        //border: new Border.all(color: Colors.grey[500]),
        //color: Colors.indigo,
        image: DecorationImage(
          image: AssetImage("assets/orderdetails/background1.jpg"),
          fit: BoxFit.fill,

        ),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text("\t\tOrder Cost" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t\$" + totalCost ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),

          Text("\t\tShipping Cost" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t\$" + shippingCost ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),

          Text("\t\tTotal Cost" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
          Text("\t\t\$" +( double.parse(totalCost) + double.parse(shippingCost) ).toString(),style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),


        ],
      ),
    );
  } Widget status(String status) {
    return  Container(
      width: 500,
      height: 100,
      //color: Colors.lime,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
        //border: new Border.all(color: Colors.grey[500]),
        //color: Colors.indigo,
        image: DecorationImage(
          image:AssetImage("assets/orderdetails/background0.jpg"),
          fit: BoxFit.fill,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(1.0),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("\t\t\t\t\t\t\t\t\t\tRecent Status" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25), ),
          Text("\t\t\t\t\t\t\t\t\t\t" + status.toUpperCase() ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25 ), ),

        ],
      ),
    );
  }

}


class TextFull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: Text( "This is an Contract"),
      ),
    );
  }
}

