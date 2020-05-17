import 'dart:ffi';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/http_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bookland/http_book.dart';


/// This class contains the objects which is the same in GET allBooks method


class CustomerBookView extends StatelessWidget {
  final String isbn;
  CustomerBookView({Key key, @required this.isbn}) : super(key: key);

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
                      addBasketButton(context),
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
    String full_part = price;
    String fractional_part = "00";
    if (price.contains(".")) {
      full_part = price.split(".")[0];
      fractional_part = price.split(".")[1];
    }
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


  Widget addBasketButton(BuildContext context){
    return RaisedButton(
      onPressed: (){


      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),

      child: Container(

        color: Colors.orangeAccent,
        padding: const EdgeInsets.all(10.0),
        child: const Text(
            'Add Basket',
            style: TextStyle(fontSize: 20)
        ),

      ),
    );
  }

}

