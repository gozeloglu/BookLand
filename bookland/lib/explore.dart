import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:bookland/bookview.dart';
import 'package:bookland/customerBookView.dart';
import 'package:bookland/main.dart';
import 'package:bookland/adminOrders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_paginator/flutter_paginator.dart';
// TODO GlobalKey Duplicate must be fixed

int total = 0;
SplayTreeSet isbnSet = new SplayTreeSet();
var globalExploreContext;
int deletedBookId = -1;

void afterDelete(int bookId) {
  deletedBookId = bookId;
  ExploreState();
}

class ExploreStateless extends StatelessWidget {
  ExploreStateless(int bookId) {
    deletedBookId = bookId;
    if (isbnSet.contains(deletedBookId)) {
      isbnSet.remove(deletedBookId);
    }
  }

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
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        centerTitle: true,
        //leading: new IconButton(
        //  icon: Icon(Icons.arrow_back),
        //onPressed: () => Navigator.pop(globalExploreContext)),
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
            height: 50.0,
            child: Row(children: <Widget>[
              Text("           "),
              IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new MyApp()),
                    );
                    print("Icon home Pressed !!");
                  }),
              Text("           "),
              IconButton(
                  icon: Icon(Icons.category),
                  onPressed: () {
                    print("Icon category Pressed !!");
                  }),
              Text("           "),
              IconButton(
                  icon: Icon(Icons.explore),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ExploreStateless(-1)),
                    );
                  }),
              Text("           "),
              IconButton(
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new adminOrders()), //adminAddBook()
                    );
                    print("Icon shopping_basket Pressed !!");
                  }),
            ])),
        color: Colors.blue,
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
      http.Response responseCount = await http.get(
        _urlBookCount,
        headers: <String, String>{'authorization': basicAuth},
      );

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
      print("sıkıntı");
      http.Response response = await http.get(
        _url,
        headers: <String, String>{'authorization': basicAuth},
      );
      print("before return");
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
      String val = "Book:\t" +
          booksData.books[i] +
          "\n" +
          "Author:\t" +
          booksData.authors[i] +
          "\n" +
          "Price:\t" +
          booksData.prices[i].toString();
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
        title: Text(value),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    new BookView(isbn: isbnSet.elementAt(index).toString()),
              ));
        });
  }

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
    print(statusCode);
    List jsonData = json.decode(response.body);
    print(jsonData);

    // isbnSet.clear();
    if (isbnSet.contains(deletedBookId)) {
      isbnSet.remove(deletedBookId);
    }
    for (int i = 0; i < jsonData.length; i++) {
      books.add(jsonData[i]["bookName"]);
      authors.add(jsonData[i]["author"]);

      isbnSet.add(jsonData[i]["bookId"]);
      int priceListLen = jsonData[i]["priceList"].length;
      double lastPrice = 0;
      lastPrice += jsonData[i]["priceList"][priceListLen - 1]["price"];
      bool moreThanOne = false;
      if (jsonData[i]["priceList"].length >= 2) {
        lastPrice += jsonData[i]["priceList"][priceListLen - 2]["price"];
        moreThanOne = true;
      }
      if (moreThanOne) {
        lastPrice /= 2;
      }
      // TODO Last 2 price should be taken
      // TODO Add image
      prices.add(lastPrice);
    }
    print(isbnSet);
    print(books);
    // TODO total should be considered
    // TODO nItems should be fixed
    nItems = books.length;
  }

  BooksData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}
