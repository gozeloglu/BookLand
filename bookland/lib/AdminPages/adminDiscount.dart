import 'dart:async';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/elements/drawer.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/material.dart';
import '../elements/appBar.dart';
import 'package:bookland/services/http_admin.dart';
import 'package:bookland/AdminPages/bookview.dart';

// ignore: slash_for_doc_comments
/***class adminUpdateBook extends StatelessWidget{


    static const String _title = 'AdminUpdateBook';
    @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
    title: _title,
    home: createState() => _AdminUpdateBookPageState(book : book),
    );
    }

    }

    class adminUpdateBookStatefulWidget extends StatefulWidget{
    //adminUpdateBookStatefulWidget({Key key}) : super(key: key);
    //final String bookId;
    //adminUpdateBookStatefulWidget({Key key, @required this.bookId}) : super(key: key);

    @override
    _AdminUpdateBookPageState createState() => _AdminUpdateBookPageState();
    }**/

class adminDiscount extends StatelessWidget {
  static const String _title = 'AdminUpdateBook';
  final AsyncSnapshot book;

  adminDiscount({Key key, @required this.book}) : super(key: key);

  //final AsyncSnapshot book ;
  //_AdminUpdateBookPageState({Key key, @required this.book}) : super(key: key);

  final HttpAdmin httpAdmin = HttpAdmin();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String isbn;
  String percentage;

  //TextEditingController isbnController = new TextEditingController();
  TextEditingController percentageController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
          appBar: MyAppBar(
            pageTitle: "Discount Book",
            loginIcon: false,
            back: false,
            filter_list: false,
            search: false,
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: new Stack(
              children: <Widget>[_showForm(book, context)],
            ),
          ),

          bottomNavigationBar: MyBottomNavigatorBar(),
        );
  }

  Widget _showForm(AsyncSnapshot book, BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(1.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            //showISBNInput(book),
            showPercentageInput(), //book == null ? null :
            showDiscountButton(context) //book == null ? null :
          ],
        ),
      ),
    );
  }

  Widget showPercentageInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: percentageController,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Percentage", //== null ? "Description" : description,
          icon: new Icon(
            Icons.trending_down,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        //validator: (value) => value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showDiscountButton(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          color: Colors.red,
          disabledColor: Colors.redAccent,
          //add this to your code,
          child: new Text("Apply Discount",
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
            //_formKey.currentState.validate();

            isbn = book.data.bookId.toString();
            percentage = percentageController.text;

            var result = httpAdmin.adminDiscountBook(isbn, percentage);

            Timer(Duration(seconds: 1), () {
              if (errorControl == false) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Discount Book"),
                      content: new Text("Discount operation is Successful!"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                errorControl = false;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Discount Book"),
                      content: new Text(errorMessage),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            });
            //Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new BookView(isbn: isbn),
                ));
            /*Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new MyApp(),
                )
            );*/
          }),
    );
  }
}
