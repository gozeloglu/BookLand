import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

var globalContext;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class Explore extends StatelessWidget {
  static const String _title = 'Explore';
  @override Widget build(BuildContext context) {
    globalContext = context;
    // TODO: implement build
    return MaterialApp(
      title: _title,
      home: ExploreStatelessWidget(),
    );
  }
}
//final items = List<String>.generate(10000, (i) => "Item $i");

class ExploreStatelessWidget extends StatelessWidget {

  ExploreStatelessWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      key :_scaffoldKey ,
      appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.filter_list),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),
        title:  const Text('BookLand', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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


