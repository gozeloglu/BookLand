import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'elements/appBar.dart';
import 'explore.dart';

class Search extends StatelessWidget {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  Widget openPage(BuildContext context) {
    print("sldcmsldkcnsdlkcnsd");
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Paginator.listView(
        key: paginatorGlobalKey,
        pageLoadFuture: searchBooksDataRequest,
        pageItemsGetter: listBooksGetter,
        listItemBuilder: listBookBuilder,
        //loadingWidgetBuilder: loadingWidgetMaker,
        //errorWidgetBuilder: errorWidgetMaker,
        //emptyListWidgetBuilder: emptyListWidgetMaker,
       // totalItemsGetter: totalPagesGetter,
        //pageErrorChecker: pageErrorChecker,
        scrollPhysics: BouncingScrollPhysics(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          paginatorGlobalKey.currentState.changeState(
              pageLoadFuture: searchBooksDataRequest, resetState: true);
        },
        child: Icon(Icons.refresh),
      ),


     // bottomNavigationBar: MyBottomNavigatorBar(),

    );
        },
    ));
  }/*
  Widget MySearch(){
    return TextField(
      onChanged: (value) {
        searchBooksDataRequest(1, value);
      },
      //controller: editingController,
      decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


  Future<BooksData> searchBooksDataRequest(int page) async {
    print("helloooooooo");

    try {
      getTotalCount("david");
      var url = "http://10.0.2.2:8080/Search/1/2/2?keyword=david";
      print(url);
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String _url = Uri.encodeFull(url);
      http.Response response = await http.get(
        _url,
        headers: <String, String>{'authorization': basicAuth},
      );
      print(response.body);
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
          booksData.prices[i].toString() +
          "|" +
          (booksData.img_list[i].toString()) +
          "|" +
          booksData.isbn_list[i].toString();
      // String img_val = (booksData.img_list[i].toString());
      bookNameList.add(val);
    }

    return bookNameList;
  }

    Widget listBookBuilder(value, int index) {
    // TODO BookView isbn should be changed with isbn
    print("VALUEEEE");
    var value_list = value.toString().split("|");
    String text_part = value_list[0];
    String img_part = value_list[1];
    String bookid_send = value_list[2];
    print("BOOKIDDD");
    print(bookid_send);
    print("VALUEEEE");
    return ListTile(
    //leading:  Image.network("https://dictionary.cambridge.org/tr/images/thumb/book_noun_001_01679.jpg?version=5.0.75"),
    leading:  Image.network(img_part),
    title: Text(text_part),
    onTap: () {
    /*Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    // new BookView(isbn: isbnSet.elementAt(index).toString()),
    new BookView(isbn: bookid_send),
    ));*/
    });
    }

  void getTotalCount(String keyword) async {
    try {
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var urlBookCount = "http://10.0.2.2:8080/searchCount?=${keyword}";

      String _urlBookCount = Uri.encodeFull(urlBookCount);
      http.Response responseCount = await http.get(
        _urlBookCount,
        headers: <String, String>{'authorization': basicAuth},
      );

      if (responseCount.statusCode == 200) {
        total = json.decode(responseCount.body);
        // print(total+ "*****");
      } else {
        print(responseCount.statusCode);
        throw Exception("Books are not retrieved!");
      }
    } catch (e) {
      print("SocketException");
      throw Exception(e);
    }
  }
}
class BooksData {
  List<dynamic> books = new List<dynamic>();
  List<dynamic> authors = new List<dynamic>();
  List<dynamic> prices = new List<dynamic>();
  List<dynamic> isbn = new List<dynamic>();
  List<dynamic> img_list = new List<dynamic>();
  List<dynamic> isbn_list = new List<dynamic>();

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

      prices.add(lastPrice);
      img_list.add(jsonData[i]["bookImage"]);
      isbn_list.add(jsonData[i]["bookId"]);

    }

    nItems = books.length;
  }

  BooksData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}

