import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bookland/http_book.dart';
import 'package:bookland/model_book.dart';
/// This class contains the objects which is the same in GET allBooks method


class BookView extends StatelessWidget {
  final String isbn;
  BookView({Key key, @required this.isbn}) : super(key: key);
  final HttpBook httpBook = HttpBook();
  static const String _title = 'BookView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book"),
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
                    name((snapshot.data.bookName).toString()),
                    imageBook((snapshot.data.bookImage).toString()),
                    Text("\n"),
                    stars(),
                    author((snapshot.data.author).toString()),
                    Text("\n"),
                    priceBook((snapshot.data.price).toString()),
                    Text("\n"),
                    sepeteEkleButton(),
                    description((snapshot.data.description).toString()),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print("HEREERROROO");
            return Text("${snapshot.error}");
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
        bottomNavigationBar: BottomAppBar(
          child : Container(
              height : 50.0,

              child : Row(
                  children : <Widget>[
                    Text("           "),
                    IconButton(
                        icon :  Icon(Icons.home),

                        onPressed :() {
                          print("Icon home Pressed !!");
                        }
                    ),
                    Text("           "),
                    IconButton(
                        icon : Icon(Icons.category),

                        onPressed :() {
                          print("Icon category Pressed !!");
                        }
                    ),
                    Text("           "),
                    IconButton(
                        icon : Icon(Icons.explore),

                        onPressed :() {

                        }
                    ),
                    Text("           "),
                    IconButton(
                        icon : Icon(Icons.shopping_basket),

                        onPressed :() {
                          print("Icon shopping_basket Pressed !!");
                        }
                    ),
                  ]

              )

          ),
          color : Colors.blue,
        ));
  }Widget imageBook(String url){
    return new Stack(
      children: <Widget>[
        //Image.asset('assets/image/book.jpg', height: 300, width: 200,)
    Image.network(url)
      ],
    );
  }
  Widget stars(){
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
  Widget name(String text){
    return Text(
      text,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,

      ),);
  }
  Widget author(String text){
    return Text(
      'Author-'+text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,

      ),);
  }
  Widget description(String text){
    return Text(
      '\n\nDescription:\n'+text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,

      ),);
  }
  Widget priceBook(String price){
    print("*****");
    print(price);
    //price = '9.99';
    String full_part = price;
    String fractional_part = "00";
    if(price.contains(".")){
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
    var fiyat =
    Text(
      'Fiyat : ',
      style: TextStyle(
        fontSize: 25,
      ),
    );

    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          fiyat,
          fiyatNum,
        ]
    );
  }

  Widget sepeteEkleButton(){
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10.0),
        child: const Text(
            'Sepete Ekle',
            style: TextStyle(fontSize: 20)
        ),
      ),
    );
  }
  Widget comments(){
    // TODO comments gelecek ama nasıl olacak emin değilim
  }
}

