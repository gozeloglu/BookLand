import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:bookland/books_model.dart';
import 'package:bookland/http_service.dart';

class Explore extends StatelessWidget {
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
}

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

