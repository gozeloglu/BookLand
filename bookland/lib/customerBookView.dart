import 'dart:ffi';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/http_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bookland/http_book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookland/basket.dart';
import 'package:bookland/main.dart';
import 'package:bookland/login.dart';

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
              print(snapshot.data.price);
              print(snapshot.data.firstPrice);
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
                      Post(),
                      stars(),
                      author((snapshot.data.author).toString()),
                      Text("\n"),
                      category((snapshot.data.category).toString()),
                      Text("\n"),
                      quantity((snapshot.data.quantity).toString()),
                      Text("\n"),
                      (snapshot.data.inDiscount == 1) ? firstPrice((snapshot.data.firstPrice).toString()) : emptyWidget(),
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
    var title = Container(
      margin: EdgeInsets.only(top: 15.0),
        child: Text(
        "Description",
        style: TextStyle(fontSize: 22, decoration: TextDecoration.underline),
        textAlign: TextAlign.center,
        )
        );
    var description = Container(
      padding: EdgeInsets.all(10.0),
        child: Text(
        text,
        style: TextStyle(fontSize: 18)));

    return Column(
      children: <Widget>[
        title, description
      ],
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

  //BU WIDGET'I SİLMEYİN, İNDİRİMİ KONTROL EDİYOR
  Widget emptyWidget (){
    mainAxisSize: MainAxisSize.min;
    return new Row(
      children: <Widget>[
        Text(" ")
      ],
    );
  }

  //Discountsuz hali
  Widget firstPrice(String price) {
    String stringPrice;
    double realPrice = double.parse(price); //Convert to double the string price that comes from parameters
    stringPrice = realPrice.toStringAsFixed(2); //Convert to string with 2 digits fractional part.

    var fiyatNum = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          stringPrice,
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            decorationThickness: 2.5,
            decorationColor: Colors.red,
            color: Color.fromARGB(140, 0, 0, 0),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '\$',
          style: TextStyle(
            color: Color.fromARGB(140, 0, 0, 0),
            decoration: TextDecoration.lineThrough,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
    var fiyat = Text(
      '             ',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          fiyat,
          fiyatNum,
    ]);
  }

  //Discount varsa discount hali
  Widget priceBook(String price) {
    //price = '9.99';
    String stringPrice;
    double realPrice = double.parse(price); //Convert to double the string price that comes from parameters
    stringPrice = realPrice.toStringAsFixed(2); //Convert to string with 2 digits fractional part.

    var fiyatNum = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          stringPrice,
          style: TextStyle(
            color: Colors.green,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '\$',
          style: TextStyle(
            color: Colors.green,
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
        // If customer log in the system
        if (_customerId != null) {
          addBasketPref(_customerId);
          getBasket(_customerId);
        } else {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new Login()),
          );
        }
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
    for (int i = 0;
        i < sharedPreferences.getStringList(_customerId).length;
        i++) {
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


// Bu satırdan aşağısı kitabı beğenip wishlist'e eklemek için.
// Kalp oluşturabilmek için bir widget oluşturdum.
// Post methodunu da yukarda widget arrayinde 53.satır'da çağırdım.
// Backend'i yazıldıktan sonra eklemeler buraya yapılabilir.

class Post extends StatefulWidget {
  @override
  PostState createState() => new PostState();
}

class PostState extends State<Post> {
  bool liked = false;

  _pressedLikeButton(){
    setState(() {
      liked = !liked;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        iconSize: 48,
        icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
        color: liked ? Colors.red : Colors.grey),
        onPressed: () => _pressedLikeButton(),
      )
    );
  }
}
class PostHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  }
}