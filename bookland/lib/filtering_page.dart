import 'dart:async';

import 'package:bookland/elements/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class filtering extends StatelessWidget {
  static const String _title = 'Filter';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: _title,
      home: FilterStatefulWidget(),
    );
  }
}
class FilterStatefulWidget extends StatefulWidget {
  FilterStatefulWidget({Key key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}
class _FilterPageState extends State<FilterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
          appBar: MyAppBar(
            pageTitle: "Filter Book",
            back: true,
          ),

          body: Container(

            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
      child: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new Image.asset('assets/booking/bookback.jpg'),
                new FlatButton(
                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Text("AUTHOR",style: new TextStyle(color: Colors.white)),
                  color: Colors.green,
                  onPressed:() { Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new Category_Filter()),
                  );},
                ),
                new FlatButton(

                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Text("CATEGORY",style: new TextStyle(color: Colors.white)),
                  color: Colors.green,
                  onPressed:() { Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new Category_Filter()),
                  );},
                ),
                new FlatButton(

                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Text("PRICE" ,style: new TextStyle(color: Colors.white)),
                  color: Colors.green,
                  onPressed:() {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new Price_Filter()),
                    );
                  },
                ),
                new FlatButton(

                  //child: new Text('OK', style: new TextStyle(color: Colors.white)),
                  child: new Text("APPLY FILTERS" ,style: new TextStyle(color: Colors.white)),
                  color: Colors.purple,
                  onPressed:() { //TODO HTTPS CONNECTION SEND DATA PART
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        )));
  }

}


class Price_Filter extends StatefulWidget {
  @override
  Price_FilterState createState() => new Price_FilterState();
}
class Price_FilterState extends State<Price_Filter> {
  GlobalKey<Price_FilterState> paginatorGlobalKey = GlobalKey();
  List<String> selectedList = [];
  Map<String, bool> book_price_dictionary = {"0-10":false, "10-20":false,"20-30":false,"30-40":false};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Price Filter')),
      body: new ListView(
        children: book_price_dictionary.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text("\$"+ key),
            value: book_price_dictionary[key],
            onChanged: (bool value) {
              setState(() {
                book_price_dictionary[key] = value;
                if (value){
                  selectedList.add(key);
                  print(selectedList);
                }else{
                  selectedList.remove(key);
                  print(selectedList);
                }
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var price_list =["100","0"] ;

          for(int i=0;i<selectedList.length ; i++){
            var str_list =   selectedList[i].toString().split('-');
            if( int.parse(str_list[0]) <  int.parse(price_list[0])){
              //price_list.add( (str_list[0]));
              price_list.removeAt(0);
              price_list.insert(0, str_list[0]);
            } if( int.parse(str_list[1]) >  int.parse(price_list[1])){
              //price_list.add( (str_list[1]));
              price_list.removeAt(1);
              price_list.insert(1, str_list[1]);

            }
            print(price_list);
            String sendValue = "minPrice="+ price_list[0] +"&"+"maxPrice=" +price_list[1];
            print(sendValue);
          }
          Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new FilterStatefulWidget()),//TO
          );},
        child: Icon(Icons.done_outline),
      ),
    );
  }
}
class Category_Filter extends StatefulWidget {
  @override
  Category_FilterState createState() => new Category_FilterState();
}

class Category_FilterState extends State<Category_Filter> {
  GlobalKey<Category_FilterState> paginatorGlobalKey = GlobalKey();

  List<String> selectedList = [];
  Map<String, bool> book_dictionary = {
    "Classic Books": false," Crime": false,"Thriller": false,"Fiction": false,"Fantasy": false,"Horror": false,"Romance": false,"Sport": false,"Health": false,"Religion": false,"Biography": false,"Art": false,"Children": false,"Science Fiction": false,"History": false};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Category Filter')),
      body: new ListView(
        children: book_dictionary.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: book_dictionary[key],
            onChanged: (bool value) {
              setState(() {
                book_dictionary[key] = value;
                if (value){
                  selectedList.add(key);
                  print(selectedList);
                }else{
                  selectedList.remove(key);
                  print(selectedList);
                }
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         String sendValue = 'categories';
         for(int i=0;i<selectedList.length ; i++){
           sendValue = sendValue + selectedList[i].toLowerCase();
           print(sendValue);
         }
         Navigator.push(
           context, new MaterialPageRoute(builder: (context) => new FilterStatefulWidget()),//TO
         );
        },
        child: Icon(Icons.done_outline),
      ),
    );

  }
}



/* body: FutureBuilder(

          future: httpall.getCategories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.hasData) {

              print("snapshot has data");
              //Book returnedBook = snapshot.data;
              print(snapshot.data.toString());
              List<dynamic>  lists = json.decode(snapshot.data.toString());
              print(lists);
              int index = 0;
              my_dictionary = list_to_map(lists);
              //return Text(snapshot.data.bookName);
              return new ListView(
                  children: my_dictionary.keys.map((String key) {
                    return new CheckboxListTile(
                      title: new Text(key),
                      value: my_dictionary[key],
                      //controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value) {
                        setState(() {
                          my_dictionary[key] = value;
                        });
                      },
                    );
                  }).toList());

            } else if (snapshot.hasError) {
              print("Snapshot has error*");
              return Text("${snapshot.error}");
            } else {
              return Center(child: CircularProgressIndicator());*/