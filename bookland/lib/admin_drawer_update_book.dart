import 'package:bookland/AdminDeleteBook.dart';
import 'package:bookland/adminAddBook.dart';
import 'package:bookland/adminDiscount.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:io';
import 'dart:convert';

import 'package:bookland/http_admin.dart';

void openPage(BuildContext context) {

  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Search'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                  },
                  //controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('book'), //https://blog.usejournal.com/flutter-search-in-listview-1ffa40956685
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



class admin_drawer_update_book extends StatelessWidget {
  static const String _title = 'AdminUpdateBook';


  final HttpAdmin httpAdmin = HttpAdmin();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String isbn ;
  //String book_name;
  //String book_category;
  //String book_sub_category;
  //String book_author;
  //String book_img;
  String book_description;
  String book_price;
  String book_quantity ;

  TextEditingController isbnController = new TextEditingController();
  //TextEditingController book_nameController = new TextEditingController();
  //TextEditingController book_categoryController = new TextEditingController();
  //TextEditingController book_sub_categoryController = new TextEditingController();
  //TextEditingController book_authorController = new TextEditingController();
  //TextEditingController book_imgController = new TextEditingController();
  TextEditingController book_descriptionController = new TextEditingController();
  TextEditingController book_priceController = new TextEditingController();
  TextEditingController book_quantityController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('BookLand-Update Book',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            //title: Text("Sign Up"),
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: new Stack(
              children: <Widget>[
                _showForm()
              ],
            ),


          ),

          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: Text("Hello, Admin", style: TextStyle(fontSize: 35)),

                  decoration: new BoxDecoration(
                      color: Colors.red
                  ),
                  margin: const EdgeInsets.only(bottom: 10.0),
                ),


                InkWell(
                  onTap: (){
                    Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => new adminAddBook()),
                    );
                  },
                  child: ListTile(
                    title: Text("Add Book", style: TextStyle(fontSize: 18)), leading: Icon(Icons.add),

                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => new DeletePage()),
                    );
                  },
                  child: ListTile(
                    title: Text("Delete Book", style: TextStyle(fontSize: 18)), leading: Icon(Icons.delete),

                  ),
                ),

                InkWell(
                  onTap: (){Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new admin_drawer_update_book()),
                  );},
                  child: ListTile(
                    title: Text("Update Book", style: TextStyle(fontSize: 18)), leading: Icon(Icons.update),

                  ),
                ),

                InkWell(
                  onTap: (){Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => new adminDiscount()),
                  );},
                  child: ListTile(
                    title: Text("Discount", style: TextStyle(fontSize: 18)), leading: Icon(Icons.arrow_drop_down),

                  ),
                ),

                InkWell(
                  onTap: (){},
                  child: ListTile(
                    title: Text("Orders", style: TextStyle(fontSize: 18)), leading: Icon(Icons.check),

                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: FlatButton(
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(10.0),
                    splashColor: Colors.red,
                    onPressed: (){},
                    child: Text("Logout", style: TextStyle(fontSize: 22)),
                  ),
                )
              ],

            ),
          ),


          bottomNavigationBar: BottomAppBar(
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
                          icon : Icon(Icons.search),
                          onPressed :() {
                            openPage(context);
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
            color : Colors.red,
          ),

        )
    );





  }
  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(1.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showISBNInput(),
            showPriceInput(),
            showStockInput(),
            showDescriptionInput(),
            showUpdateBookButton()
          ],
        ),
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
          hintText: 'Book ID',
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
        validator: (value) => value.isEmpty ? 'Book ISBN cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }




  Widget showPriceInput( ){

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_priceController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Price",
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
        validator: (value) => value.isEmpty ? 'Book Price cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );

  }

  Widget showStockInput( ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_quantityController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Quantity",
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

  Widget showDescriptionInput( ){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_descriptionController,
        maxLines: 10,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Description",
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

  Widget showUpdateBookButton() {
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

            isbn = isbnController.text;
            book_quantity = book_quantityController.text;
            book_price = book_priceController.text;
            book_description = book_descriptionController.text;
            var result =  httpAdmin.adminUpdateBook(isbn,book_quantity,book_price,book_description);
            print(result);

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
