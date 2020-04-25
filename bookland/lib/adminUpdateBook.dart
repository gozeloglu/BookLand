import 'package:bookland/AdminDeleteBook.dart';
import 'package:bookland/adminAddBook.dart';
import 'package:bookland/adminDiscount.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/elements/drawer.dart';
import 'package:flutter/material.dart';
import 'elements/appBar.dart';
import 'main.dart';
import 'dart:io';
import 'dart:convert';

import 'package:bookland/http_admin.dart';

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: MyAppBar( pageTitle:"Update Book"),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {},
                  //controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'book'), //https://blog.usejournal.com/flutter-search-in-listview-1ffa40956685
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  ));
}

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

class adminUpdateBook extends StatelessWidget {
  static const String _title = 'AdminUpdateBook';
  final AsyncSnapshot book;


  adminUpdateBook({Key key, @required this.book}) : super(key: key);

  //final AsyncSnapshot book ;
  //_AdminUpdateBookPageState({Key key, @required this.book}) : super(key: key);

  final HttpAdmin httpAdmin = HttpAdmin();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String isbn;
  String book_name;
  String book_category;
  String book_sub_category;
  String book_author;
  String book_img;
  String book_description;
  String book_price;
  String book_hotlist;
  String book_quantity;

  TextEditingController isbnController = new TextEditingController();
  TextEditingController book_nameController = new TextEditingController();
  TextEditingController book_categoryController = new TextEditingController();
  TextEditingController book_sub_categoryController =
      new TextEditingController();
  TextEditingController book_authorController = new TextEditingController();
  TextEditingController book_imgController = new TextEditingController();
  TextEditingController book_descriptionController =
      new TextEditingController();
  TextEditingController book_priceController = new TextEditingController();
  TextEditingController book_quantityController = new TextEditingController();
  TextEditingController book_hotlistController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          appBar: MyAppBar(pageTitle: "Update Book", back: true,),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: new Stack(

              children: <Widget>[_showForm(book, context)],

            ),
          ),
          drawer: MyDrawer(drawerHeader: "Hello Admin",),
          bottomNavigationBar: MyBottomNavigatorBar(),
        ));
  }


  
  
  Widget _showForm(AsyncSnapshot book, BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(1.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            //showISBNInput(book),
            showNameInput(book == null ? "BookName" :book.data.bookName.toString()), //book == null ? "BookName" :
            showAuthorInput(book == null ? null : book.data.author.toString()), //book == null ? null :
            showCategoryInput(book == null ? null :book.data.category.toString()), //book == null ? null :
            showSubcategoryInput(book == null ? null :book.data.subCategory.toString()), //book == null ? null :
            showImageInput(book == null ? null : book.data.bookImage.toString()), //book == null ? null :
            showPriceInput(book == null ? null :book.data.price.toString()), //book == null ? null :
            showStockInput(book == null ? null : book.data.quantity.toString()), //book == null ? null :
            showHotlistInput(book == null ? null : book.data.inHotList.toString()), //book == null ? null :
            showDescriptionInput(book == null ? null : book.data.description.toString()), //book == null ? null :
            showUpdateBookButton(book == null ? null :book.data.bookId.toString(), context) //book == null ? null :
          ],
        ),
      ),
    );
  }
/*
  Widget showISBNInput(AsyncSnapshot book) {
    print("***xxxx");
    print(book.hasData);
    print("***xxx");
    try {
      if (book.hasData != null) {}
    } on Exception catch (exception) {
      print("Catch itttt");
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new TextFormField(
          controller: isbnController,
          maxLines: 1,
          keyboardType: TextInputType.text,
          autofocus: false,
          /**decoration: new InputDecoration(
              hintText: isbn,
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
              ),*/
          validator: (value) =>
              value.isEmpty ? 'Book ISBN cannot be empty' : null,
          //onSaved: (value) => _email = value.trim(),
        ),
      );
    }
  }
*/ // Belki lazım olur silmeyin
  Widget showNameInput(String bookName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
      //  initialValue: "meraba",//bookName == null ? "Book Name" : bookName,
        controller: book_nameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText:bookName, // bookName == null ? "Book Name" :
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
        //validator: (value) => value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showAuthorInput(String author) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_authorController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: author, //author == null ? "Author" :
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
        //validator: (value) => value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showCategoryInput(String category) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_categoryController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: category, //category == null ? "Category" :
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
        //validator: (value) => value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showSubcategoryInput(String subCategory) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_sub_categoryController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText:subCategory, // subCategory == null ? "Sub Category" :
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
        //validator: (value) => value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showImageInput(String bookImage) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_imgController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText:  bookImage,// bookImage == null ? "Book Image Link" :
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
        //validator: (value) => value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showHotlistInput(String inHotList) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_hotlistController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText:  inHotList, //inHotList == null ? "In Hot List" :
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
        //validator: (value) => value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPriceInput(String price) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_priceController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: price ,//== null ? "Price" : price,
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

  Widget showStockInput(String quantity) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_quantityController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: quantity,// == null ? "Quantity" : quantity,
          icon: new Icon(
            Icons.confirmation_number,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
      ),
    );
  }

  Widget showDescriptionInput(String description) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_descriptionController,
        maxLines: 10,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: description ,//== null ? "Description" : description,
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

  Widget showUpdateBookButton(String bookId, BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          color: Colors.red,
          disabledColor: Colors.redAccent,
          //add this to your code,
          child: new Text("Update This Book",
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
            //_formKey.currentState.validate();

            // TODO SHOW DIALOG KONTROL EDİLMELİİİ!!
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Update Book"),
                  content: new Text("Updating Book is Succesful!"),
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

            // TODO KONTROL EDİLMELİİİİİİ

            isbn = bookId;
            print("******");
            print(bookId);
            print("******");

            book_hotlist = book_hotlistController.text;
            book_quantity = book_quantityController.text;
            book_price = book_priceController.text;
            book_description = book_descriptionController.text;
            book_name = book_nameController.text;
            book_author = book_authorController.text;
            book_category = book_categoryController.text;
            book_sub_category = book_sub_categoryController.text;
            book_img = book_imgController.text;
            print("------------------------------");
            print(book_price);
            print(book_quantity);
            print("-----------------------------");
            if (book_quantity == null) {}
            var result = httpAdmin.adminUpdateBook(
                isbn,
                book_name.isEmpty == true ? null : book_name ,
                book_author.isEmpty == true ? null : book_author ,
                book_category.isEmpty == true ? null : book_category ,
                book_sub_category.isEmpty == true ? null : book_sub_category ,
                book_img.isEmpty == true ? null : book_name ,
                book_hotlist,
                book_quantity,
                book_price,
                book_description);
            print(result);
            Navigator.pop(context);
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

