import 'dart:ffi';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/http_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bookland/http_book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookland/basket.dart';
import 'package:bookland/main.dart';

/// This class contains the objects which is the same in GET allBooks method
SharedPreferences pref;
class CustomerBookView extends StatelessWidget {
  String _bookName;
  int _quantity;
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
                      addBasketButton(context, customerID),
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
        bottomNavigationBar: MyBottomNavigatorBar());
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
    _bookName = text;
    return Text(
      text,
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
  }

  Widget quantity(String text) {
    _quantity = int.parse(text);
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

  Widget addBasketButton(BuildContext context, String _customerId) {
    return RaisedButton(
      onPressed: () {
        // TODO Call Basket class
        print(_quantity);
        print(_bookName);
        print(isbn);
        addBasketPref(_customerId);
        getBasket(_customerId);
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: Colors.orangeAccent,
        padding: const EdgeInsets.all(10.0),
        child: const Text('Add Basket', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  void getBasket(String _customerId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for (int i = 0; i < sharedPreferences.getStringList(_customerId).length; i++) {
      print(sharedPreferences.getStringList(_customerId)[i]);
    }
  }
  void addBasketPref(String _customerId) async {
    // TODO quantity should be updated
    print("ADD BASKET");
    pref = await SharedPreferences.getInstance();
    List bookList = pref.getStringList(_customerId);
    bookList.add("13321");
    pref.setStringList(_customerId, bookList);
    print(pref.getStringList(_customerId));
    /*print(bookList.length);
    for (int i = 0; i < bookList.length; i += 2) {
      if (bookList[i] == isbn) {
        int tmpQuantity = int.parse(bookList[i+1]);
        tmpQuantity++;
        bookList[i+1] = tmpQuantity.toString();
        pref.setStringList(_customerId, bookList);
        print("PREF");
        print(pref.getStringList(_customerId));
        return;
      }
    }*/
    /*bookList.add(isbn);
    bookList.add("1");
    pref.setStringList(_customerId, bookList);
    print(pref.getStringList(_customerId));*/
  }
}
