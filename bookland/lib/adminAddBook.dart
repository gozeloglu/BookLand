import 'dart:async';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/drawer.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:bookland/http_admin.dart';

class adminAddBook extends StatelessWidget {
  static const String _title = 'AdminAddBook';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: _title,
      home: adminAddBookStatefulWidget(),
    );
  }
}

class adminAddBookStatefulWidget extends StatefulWidget {
  adminAddBookStatefulWidget({Key key}) : super(key: key);

  @override
  _AdminAddBookPageState createState() => _AdminAddBookPageState();
}

class _AdminAddBookPageState extends State<adminAddBookStatefulWidget> {
  final HttpAdmin httpAdmin = HttpAdmin();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String isbn;
  String book_name;
  String book_category;
  String book_sub_category;
  String book_author;
  String book_quantity;
  String book_hotlist;
  String book_img;
  String book_description;
  String book_price;

  TextEditingController isbnController = new TextEditingController();
  TextEditingController book_nameController = new TextEditingController();
  TextEditingController book_categoryController = new TextEditingController();
  TextEditingController book_sub_categoryController =
      new TextEditingController();
  TextEditingController book_authorController = new TextEditingController();
  TextEditingController book_quantityController = new TextEditingController();
  TextEditingController book_hotlistController = new TextEditingController();
  TextEditingController book_imgController = new TextEditingController();
  TextEditingController book_descriptionController =
      new TextEditingController();
  TextEditingController book_priceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          appBar: MyAppBar(
            pageTitle: "Add Book",
            back: true,
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: new Stack(
              children: <Widget>[_showForm()],
            ),
          ),
        ));
  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(1.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showISBNInput(),
            showBookNameInput(),
            showAuthorInput(),
            showCategoryInput(),
            showSubcategoryInput(),
            showQuantityInput(),
            showHotlistInput(),
            showLinkInput(),
            showPriceInput(),
            showDescriptionInput(),
            showAddBookButton()
          ],
        ),
      ),
    );
  }

  Widget showQuantityInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
      child: new TextFormField(
        controller: book_quantityController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Book Quantity',
          icon: new Icon(
            Icons.format_list_numbered,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        //validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showHotlistInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
      child: new TextFormField(
        controller: book_hotlistController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'in Hotlist?',
          icon: new Icon(
            Icons.playlist_add_check,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        //validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showBookNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
      child: new TextFormField(
        controller: book_nameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Book Name',
          icon: new Icon(
            Icons.book,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        //validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showLinkInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_imgController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Link',
          icon: new Icon(
            Icons.link,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Book Link cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showCategoryInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_categoryController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Book Category',
          icon: new Icon(
            Icons.category,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) => value.isEmpty ? 'Category cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showSubcategoryInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_sub_categoryController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Book Sub-Category',
          icon: new Icon(
            Icons.category,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Subcategory cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showISBNInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: isbnController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Book ISBN',
          icon: new Icon(
            Icons.label_important,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Book ISBN cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showAuthorInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_authorController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Author',
          icon: new Icon(
            Icons.person,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Book author cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPriceInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_priceController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Price',
          icon: new Icon(
            Icons.attach_money,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showDescriptionInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_descriptionController,
        maxLines: 10,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Description',
          icon: new Icon(
            Icons.description,
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

  Widget showAddBookButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          color: Colors.red,
          disabledColor: Colors.redAccent,
          //add this to your code,
          child: new Text("Add This Book",
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
            //_formKey.currentState.validate();
            isbn = isbnController.text;
            book_name = book_nameController.text;
            book_category = book_categoryController.text;
            book_sub_category = book_sub_categoryController.text;
            book_author = book_authorController.text;
            book_img = book_imgController.text;
            book_description = book_descriptionController.text;
            book_price = book_priceController.text;
            book_quantity = book_quantityController.text;
            book_hotlist = book_hotlistController.text;
            //print(isbn book_name,book_category,book_sub_category,book_author,book_img,book_description ,book_price);

            var result = httpAdmin.adminAddBook(
                isbn,
                book_name,
                book_category,
                book_sub_category,
                book_author,
                book_quantity,
                book_hotlist,
                book_img,
                book_description,
                book_price);
            print(result);
            print("****" + errorControl.toString());
            Timer(Duration(seconds: 1), () {
            if (errorControl == false) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("Add Book"),
                    content: new Text("Adding book is successful"),
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
            else {
              errorControl = false;
              Timer(Duration(seconds: 1), () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Add Book"),
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
              });
            }
            });
            //TODO kullanıcya mesaj döndürülmeli

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
