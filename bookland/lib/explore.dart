import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bookland/bookview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:flutter_paginator/enums.dart';

class ExploreStateless extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
        title: Text("Explore Pagination Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: () {
              paginatorGlobalKey.currentState.changeState(
                listType: ListType.LIST_VIEW
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () {
              paginatorGlobalKey.currentState.changeState(
                listType: ListType.LIST_VIEW,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.library_books),
            onPressed: () {
              paginatorGlobalKey.currentState.changeState(
                listType: ListType.PAGE_VIEW
              );
            },
          ),
        ],
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

  Future<BooksData> sendBooksDataRequest(int page) async {
    try {
      /// var url = 'http://api.worldbank.org/v2/country?page=$page&format=json';
      var url = "http://10.0.2.2:8080/allBooks/$page/5";
      //String _page = page.toString();
      /*url += _page;
      url += "/5/";*/
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
    List<String> list = [];
   for (int i = 0; i < booksData.books.length; i++) {
     list.add(booksData.books[i]);
   }
    return list;
    ///return list;
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget listBookBuilder(value, int index) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Container(
          height: 50,
          child: Center(child: value),
        )
      ],
    );
    /*return ListTile(
      leading: Text(index.toString()),
      title: Text(value),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => new BookView(isbn: index.toString()),
        ));
      });*/
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
    return booksData.total;
    //return 20;
  }

  bool pageErrorChecker(BooksData booksData) {
    return booksData.statusCode != 200;
  }
}

class BooksData {
  ///Map<String, dynamic> books;
  List<dynamic> books = new List<dynamic>();
  int statusCode;
  String errorMessage;
  int total = 32;
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
    print("Status Code : $statusCode");
    print("BODY-1 : $response.body");
    List jsonData = json.decode(response.body);
    print("Status Code-2 : $statusCode");
    print("BODY :");
    print(response.body);
    print(jsonData.runtimeType);
    print(json.decode(response.body).runtimeType);
    /// books = jsonData[1];
    for (int i = 0 ; i < jsonData.length; i++) {
      print(jsonData[i]);
      print(jsonData[i].runtimeType);
      books.add(jsonData[i]["bookName"]);
    }
    // TODO total should be considered
    // TODO nItems should be fixed
    /// total = jsonData[0]['total'];
    print("******BOOKS : $books");
    nItems = books.length;
  }

  BooksData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}

/***
const int threshold  = 5;
const int totalItems = 20;
int pageNum = 0;

class ExploreStateless extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      body: PaginatedListWidget(
        progressWidget: Center(
          child: Text("Loading..."),
        ),
        itemListCallback: OnScrollCallback(),
      ),
    );
  }
}

class OnScrollCallBack<T extends Widget> extends ItemListCallback {
  int availableItems = 0;

  @override
  Future<EventModel> getItemList() {
    return Future.delayed(Duration(seconds: 3), () async {
      List<T> itemList = List();
      var url = "http://10.0.2.2:8080/allBooks/";

      // TODO update pageNum
      String page = pageNum.toString();
      url += page;
      url += "/5/";
      print(url);
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print("Before GET");
      final response = await http.get(url,
        headers: <String, String>{'authorization': basicAuth},);

      if (response.statusCode == 200) {
        List itemResponse = jsonDecode(response.body);
        List<Book> books = body.map((String item) => Book.fromJson(item),).toList();
      } else {
        throw Exception("Books are not retrieved!");
      }

      if (availableItems < totalItems) {
        for (int i = availableItems; i < availableItems + threshold; i++) {
          Widget widget;
          if (i % 5 == 0) {
            widget = TitleWidget(i);
          } else {
            widget = ListItemWidget(ItemModel("Title $i", "Subtitle $i"));
          }
          itemList.add(widget);
        }
        availableItems += threshold;
        return EventModel(progress: false, data: itemList, error: null);
      } else {
        for (int i = availableItems; i < availableItems + 3; i++) {
          Widget widget = ListItemWidget(ItemModel("Title $i", "Subtitle $i"));
          itemList.add(widget);
        }
        availableItems += 3;
        return EventModel(progress: false, data: itemList, error: null, stopLoading: true);
      }
    });
  }
}

class TitleWidget extends StatelessWidget {
  final int i;
  TitleWidget(this.i);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
        border: Border.all(color: Colors.grey[400], width: 1.0),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            "Header $i",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final ItemModel itemModel;
  ListItemWidget(this.itemModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                itemModel.title,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                itemModel.subTitle,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  final String title;
  final String subTitle;

  ItemModel(this.title, this.subTitle);
}
***/
/*
class Explore extends StatefulWidget {
  Explore({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExplorePageState createState() => _ExplorePageState();*/
  /*
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books"),
      ),
      body: FutureBuilder(
        future: httpService.getBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.hasData) {
            print("snapshot has data");
            List<Book> books = snapshot.data;
            return ListView(
              children: books
                  .map(
                    (Book book) => ListTile(
                  title: Text(book.bookName),
                  subtitle: Text("${book.bookId}"),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => null
                    ),
                  ),
                ),
              )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}*/
/*
class _ExplorePageState extends State<Explore> {
  int page = 1;
  List<String> bookList = new List();
  bool isLoading = false;

  Future _loadBook() async {

    await new Future.delayed(new Duration(seconds: 3));
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get('http://10.0.2.2:8080/allBooks',
      headers: <String, String>{'authorization': basicAuth},);

    if (response.statusCode == 200) {
      /// TODO fill
      List<String> books = new List();
      List bookResponse = jsonDecode(response.body);
      for (int i = 0; i < bookResponse.length ; i++) {

      }
      setState(() {
        bookList.addAll(bookResponse);
        isLoading = false;
      });
    } else {
      throw Exception("Books are not retrieved!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!isLoading && scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                    _loadBook();
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                child: ListView.builder(
                    itemCount: bookList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${bookList[index]}'),
                      );
                    },
                    ),
              ),),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}*/
/*
var globalContext;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class Explore extends StatelessWidget {

  // HTTP object is created
  final HttpService httpService = HttpService();

  static const String _title = 'Explore';
  @override Widget build(BuildContext context) {
    globalContext = context;
    // TODO: implement build
    return MaterialApp(
      title: _title,
      home: ExploreStatefulWidget(),
    );
  }
}
//final items = List<String>.generate(10000, (i) => "Item $i");

class ExploreStatefulWidget extends StatefulWidget {
  ExploreStatefulWidget({Key key}) : super(key: key);

  @override
  _ExploreStatefulWidget createState() => _ExploreStatefulWidget();
}

class _ExploreStatefulWidget extends State<ExploreStatefulWidget> {

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
      () => 'Data Loaded',
  );
  ///ExploreStatelessWidget({Key key}) : super(key: key);
  //@override
  Widget build(BuildContext context) {
    return FutureBuilder<String> (
      future: _calculation,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsests(top: 16),
              child: Text('Result:, ${snapshot.data}'),
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget> [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
                padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );

    */
    /*return Scaffold(

      backgroundColor: Colors.white,
      key :_scaffoldKey ,
      appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.filter_list),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),
        title:  const Text('BookLand',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        actions: <Widget>[
          Container(

              child :IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                },
              ),width: 60.0, height: 30.0),
          //Text('PROFILE', style: new TextStyle(color: Colors.white)),

        ],
      ),
      body : GridView.count(

      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[

        Container(

          child : new FlatButton(
            //child: new Text('OK', style: new TextStyle(color: Colors.white)),
            child: new Image.asset('assets/booking/book1.jpg'),
            onPressed: () {},
            color: Colors.white,

          )
          ,width: 100.0, height: 200.0,),
        Container(
          child : new FlatButton(
            //child: new Text('OK', style: new TextStyle(color: Colors.white)),
            child: new Image.asset('assets/booking/book2.jpg'),
            onPressed: () {},
            color: Colors.white,

          )
          ,width: 400.0, height: 200.0,),
        Container(
          child : new FlatButton(
            //child: new Text('OK', style: new TextStyle(color: Colors.white)),
            child: new Image.asset('assets/booking/book3.jpg'),
            onPressed: () {},
            color: Colors.white,

          )
          ,width: 400.0, height: 200.0,),
        Container(
          child : new FlatButton(
            //child: new Text('OK', style: new TextStyle(color: Colors.white)),
            child: new Image.asset('assets/booking/book4.jpg'),
            onPressed: () {},
            color: Colors.white,

          )
          ,width: 400.0, height: 200.0,),
        Container(
          child : new FlatButton(
            //child: new Text('OK', style: new TextStyle(color: Colors.white)),
            child: new Image.asset('assets/booking/book5.jpg'),
            onPressed: () {},
            color: Colors.white,

          )
          ,width: 400.0, height: 200.0,),
        Container(
          child : new FlatButton(
            //child: new Text('OK', style: new TextStyle(color: Colors.white)),
            child: new Image.asset('assets/booking/book6.jpg'),
            onPressed: () {},
            color: Colors.white,

          )
          ,width: 400.0, height: 200.0,),
        Container(
          child : new FlatButton(
            //child: new Text('OK', style: new TextStyle(color: Colors.white)),
            child: new Image.asset('assets/booking/book7.jpg'),
            onPressed: () {},
            color: Colors.white,

          )
          ,width: 400.0, height: 200.0,)
      ],
    )
      ,
      drawer: Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new UserAccountsDrawerHeader(accountName: new  Text('FILTER', style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold )),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/filter_books.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(' Filter by Price',style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold )),
          CheckboxGroup(
            labels: <String>[
              "0TL - 25TL",
              "25TL - 50TL",
              "50TL - 100TL",
              "100TL - 250TL",
              "250TL -500TL",
              "500TL and up",
            ],
            /**disabled: [
              "Wednesday",
              "Friday"
            ],*/
            onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
            onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
          ),

          new Divider(),
          Text(' Filter by Category',style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold )),
          CheckboxGroup(
            labels: <String>[
              "Novel",
              "History",
              "Self-Improvement",
              "Child",
              "Biography",
              "Poetry",
              "Literature",
              "Philosophy"
            ],
            /**disabled: [
                "Wednesday",
                "Friday"
                ],*/
            onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
            onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
          ),

]))
       , bottomNavigationBar: BottomAppBar(
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
                    Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => new Explore()),
                    );
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

  }
}
*/

