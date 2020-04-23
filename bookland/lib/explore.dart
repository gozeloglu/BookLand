import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:bookland/bookview.dart';
import 'package:bookland/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_paginator/flutter_paginator.dart';
int total = 0;
SplayTreeSet isbnSet = new SplayTreeSet();
var globalExploreContext;

class ExploreStateless extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    globalExploreContext = context;
    return MaterialApp(
      title: 'Explore Page',
      home: ExplorePage(),
    );
  }
}

class ExplorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExploreState();
  }
}

class ExploreState extends State<ExplorePage> {
  GlobalKey<PaginatorState> paginatorGlobalKey  = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        centerTitle: true,
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(globalExploreContext)
        ),

      ),
      body: Paginator.listView(
        key: paginatorGlobalKey,
          pageLoadFuture: sendBooksDataRequest,
          pageItemsGetter: listBooksGetter,
          listItemBuilder: listBookBuilder,
          loadingWidgetBuilder: loadingWidgetMaker,
          errorWidgetBuilder: errorWidgetMaker,
          emptyListWidgetBuilder: emptyListWidgetMaker,
          totalItemsGetter: totalPagesGetter,
          pageErrorChecker: pageErrorChecker,
          scrollPhysics: BouncingScrollPhysics(),
      ),
    );
  }
  void getTotalCount() async {
    try {
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var urlBookCount = "http://10.0.2.2:8080/getBookCount";

      String _urlBookCount = Uri.encodeFull(urlBookCount);
      http.Response responseCount = await http.get(_urlBookCount,
        headers: <String, String>{'authorization': basicAuth},);

      if (responseCount.statusCode == 200) {
        total = json.decode(responseCount.body);
        print(total);
      } else {
        print(responseCount.statusCode);
        throw Exception("Books are not retrieved!");
      }
    } catch (e) {
        print("SocketException");
        return null; // Exception("SocketException");
    }
  }

  Future<BooksData> sendBooksDataRequest(int page) async {
    try {
      getTotalCount();
      var url = "http://10.0.2.2:8080/allBooks/$page/5";
      print(url);
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String _url = Uri.encodeFull(url);
      http.Response response = await http.get(_url,
        headers: <String, String>{'authorization': basicAuth},);
      return BooksData.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return BooksData.withError("Please check your internet connection.");
      } else {
        print(e.toString());
        return BooksData.withError("Something went wrong.");
      }
    }
  }

  List<dynamic> listBooksGetter(BooksData booksData) {
    List<dynamic> bookNameList = [];
    List<int> isbnList = [];
   for (int i = 0; i < booksData.books.length; i++) {
     String val = "Book:\t" + booksData.books[i] + "\n" +
         "Author:\t" + booksData.authors[i] + "\n" +
         "Price:\t" + booksData.prices[i].toString();
     bookNameList.add(val);
   }
    return bookNameList;
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget listBookBuilder(value, int index) {
    // TODO BookView isbn should be changed with isbn
    return ListTile(
      leading: Text(index.toString()),
      title: Text(value),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => new BookView(isbn: isbnSet.elementAt(index).toString()),
        ));
      });
  }

  // TODO If there is no book in DB --> print an error message
  Widget errorWidgetMaker(BooksData booksData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(booksData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text("Retry"),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(BooksData booksData) {
    return Center(
      child: Text("No books in the list"),
    );
  }

  int totalPagesGetter(BooksData booksData) {
    // TODO This should be fixed
    return total;
  }

  bool pageErrorChecker(BooksData booksData) {
    return booksData.statusCode != 200;
  }
}

class BooksData {
  List<dynamic> books = new List<dynamic>();
  List<dynamic> authors = new List<dynamic>();
  List<dynamic> prices = new List<dynamic>();
  List<dynamic> isbn = new List<dynamic>();
  int statusCode;
  String errorMessage;
  int nItems;

  int bookId;
  String bookName;
  String author;
  String description;
  String category;
  String subCategory;
  int inHotList;
  int status;
  int quantity;
  String bookImage;
  DateTime releasedTime;
  List<double> priceList;

  BooksData.fromResponse(http.Response response) {
    this.statusCode = response.statusCode;
    List jsonData = json.decode(response.body);

    for (int i = 0 ; i < jsonData.length; i++) {

      books.add(jsonData[i]["bookName"]);
      authors.add(jsonData[i]["author"]);

      isbnSet.add(jsonData[i]["bookId"]);
      double lastPrice = 0;
      lastPrice += jsonData[i]["priceList"][0]["price"];
      bool moreThanOne = false;
      if (jsonData[i]["priceList"].length >= 2) {
        lastPrice += jsonData[i]["priceList"][1]["price"];
        moreThanOne = true;
      }
      if (moreThanOne) {
        lastPrice /= 2;
      }
      prices.add(lastPrice);
    }
    // TODO total should be considered
    // TODO nItems should be fixed
    nItems = books.length;
  }

  BooksData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}