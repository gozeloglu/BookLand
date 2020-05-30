import 'dart:async';
import 'dart:ffi';

import 'package:bookland/adminDiscount.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/material.dart';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/http_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bookland/http_book.dart';
import 'package:bookland/model_book.dart';
import 'package:bookland/AdminDeleteBook.dart';
import 'package:bookland/adminUpdateBook.dart';

import 'package:bookland/explore.dart';

/// This class contains the objects which is the same in GET allBooks method

class BookView extends StatelessWidget {
  final String isbn;
  BookView({Key key, @required this.isbn}) : super(key: key);

  final HttpBook httpBook = HttpBook();
  final HttpAdmin httpAdmin = HttpAdmin();
  static const String _title = 'BookView';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: MyAppBar(
          pageTitle: "Book",
         // backgroundColor: Color(0xFFFF1744),
          back: true,


        ),
        body: FutureBuilder(

          future: httpBook.getBook(isbn),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print("snapshot has data");
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: new SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      real_isbn((snapshot.data.details.real_isbn).toString()),
                      Text("\n"),
                      name((snapshot.data.details.bookName).toString()),
                      Text("\n"),
                      imageBook((snapshot.data.details.bookImage).toString()),
                      Text("\n"),
                      stars(),
                      author((snapshot.data.details.author).toString()),
                      Text("\n"),
                      category((snapshot.data.details.category).toString()),
                      Text("\n"),
                      quantity((snapshot.data.details.quantity).toString()),
                      Text("\n"),
                      priceBook((snapshot.data.details.price).toString()),
                      description((snapshot.data.details.description).toString()),
                      Text("\n"),
                      Row(children: <Widget>[
                        Text(
                            "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"),
                        updateButton(context, snapshot),
                        Text("      \t\t\t"),
                        deleteButton(
                            context, (snapshot.data.details.bookId).toString()),
                      ]),
                      Text("\n"),
                      discountButton(context, snapshot)
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

  Widget imageBook(String url) {
    return new Stack(
      children: <Widget>[
        /**Image.asset(
          'assets/booking/book1.jpg',
          height: 300,
          width: 200,
        ),**/
        Image.network(url)
      ],
    );
  }

  Widget stars() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
    );
  }

  Widget name(String text) {
    return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget author(String text) {
    return Text(
      '\nAuthor-' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget description(String text) {
    return Text(
      '\nDescription:\n' + text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
  Widget real_isbn(String text) {
    return Text(
      '\n\nISBN:' + text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }  Widget quantity(String text) {
    return Text(
      'Quantity: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Widget category(String text) {
    return Text(
      'Category: ' + text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget priceBook(String price) {
    //price = '9.99';
    //String full_part = price;
    //String fractional_part = "00";
    /*if (price.contains(".")) {
      full_part = price.split(".")[0];
      fractional_part = price.split(".")[1];
    }*/
    String stringPrice;
    double realPrice = double.parse(price); //Convert to double the string price that comes from parameters
    stringPrice = realPrice.toStringAsFixed(2); //Convert to string with 2 digits fractional part.

    var fiyatNum = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          stringPrice,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          '\$',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
    var fiyat = Text(
      'Price : ',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

    return new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      fiyat,
      fiyatNum,
    ]);
  }

  Widget updateButton(BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        print(snapshot.data.details.bookId.toString());
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new adminUpdateBook(book: snapshot)),
        );
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(15.0),
        child: const Text('Update', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget deleteButton(BuildContext context, String bookId) {
    return RaisedButton(
      onPressed: () {
        var result = httpAdmin.adminDeleteBook(bookId);


        Timer(Duration(seconds: 1), () {
          if (errorControl == false){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Delete Book"),
                  content: new Text("Deleting Book is Successful!"),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ExploreStateless(int.parse(bookId))),
            );
          } else {
            errorControl = false;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Delete Book"),
                  content: new Text(errorMessage),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );

          }
        });


        //Navigator.pop(context, true);
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: Colors.orangeAccent,
        padding: const EdgeInsets.all(15.0),
        child: const Text('Delete', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget discountButton(BuildContext context, AsyncSnapshot snapshot){
    return RaisedButton(
      onPressed: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new adminDiscount(book: snapshot)),
        );
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: Colors.blueGrey,
        padding: const EdgeInsets.all(15.0),
        child: const Text('Discount', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget comments() {
    // TODO comments gelecek ama nasıl olacak emin değilim
  }
}
