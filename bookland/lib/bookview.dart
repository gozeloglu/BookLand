import 'dart:ffi';

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
              //Book returnedBook = snapshot.data;
              print("Here");
              //return Text(snapshot.data.bookName);
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: new SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      real_isbn((snapshot.data.real_isbn).toString()),
                      Text("\n"),
                      name((snapshot.data.bookName).toString()),
                      Text("\n"),
                      imageBook((snapshot.data.bookImage).toString()),
                      Text("\n"),
                      stars(),
                      author((snapshot.data.author).toString()),
                      Text("\n"),
                      category((snapshot.data.category).toString()),
                      Text("\n"),
                      quantity((snapshot.data.quantity).toString()),
                      Text("\n"),
                      priceBook((snapshot.data.price).toString()),
                      description((snapshot.data.description).toString()),
                      Text("\n"),
                      Row(children: <Widget>[
                        Text(
                            "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"),
                        updateButton(context, snapshot),
                        Text("      \t\t\t"),
                        deleteButton(
                            context, (snapshot.data.bookId).toString()),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              print("HEREERROROO");
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
    return Text(
      text,
      style: TextStyle(
        fontSize: 50,
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
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
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
    print("*****");
    print(price);
    //price = '9.99';
    String full_part = price;
    String fractional_part = "00";
    if (price.contains(".")) {
      full_part = price.split(".")[0];
      fractional_part = price.split(".")[1];
    }
    print(full_part);
    print(fractional_part);
    var fiyatNum = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          full_part + ",",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          fractional_part,
          style: TextStyle(
            fontSize: 15,
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
        print("------");
        print(snapshot.data.bookId.toString());
        print("------");
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
        print(result);
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ExploreStateless(int.parse(bookId))),
        );
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

  Widget comments() {
    // TODO comments gelecek ama nasıl olacak emin değilim
  }
}
