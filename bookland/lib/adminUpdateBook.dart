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
  final AsyncSnapshot book ;
  adminUpdateBook({Key key, @required this.book}) : super(key: key);

  //final AsyncSnapshot book ;
  //_AdminUpdateBookPageState({Key key, @required this.book}) : super(key: key);

  final HttpAdmin httpAdmin = HttpAdmin();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String isbn ;
  String book_name;
  String book_category;
  String book_sub_category;
  String book_author;
  String book_img;
  String book_description;
  String book_price;
  String book_hotlist;
  String book_quantity ;

  TextEditingController isbnController = new TextEditingController();
  TextEditingController book_nameController = new TextEditingController();
  TextEditingController book_categoryController = new TextEditingController();
  TextEditingController book_sub_categoryController = new TextEditingController();
  TextEditingController book_authorController = new TextEditingController();
  TextEditingController book_imgController = new TextEditingController();
  TextEditingController book_descriptionController = new TextEditingController();
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
                _showForm(book,context)
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
                      context, new MaterialPageRoute(builder: (context) => new adminUpdateBook()),
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
  Widget _showForm(AsyncSnapshot book,BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(1.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            //showISBNInput(book),
            showNameInput(book.data.bookName.toString()),
            showAuthorInput(book.data.author.toString()),
            showCategoryInput(book.data.category.toString()),
            showSubcategoryInput(book.data.subCategory.toString()),
            showImageInput(book.data.bookImage.toString()),
            showPriceInput(book.data.price.toString()),
            showStockInput(book.data.quantity.toString()),
            showHotlistInput(book.data.inHotList.toString()),
            showDescriptionInput(book.data.description.toString()),
            showUpdateBookButton(book.data.bookId.toString(),context)
          ],
        ),
      ),
    );
  }



  Widget showISBNInput(AsyncSnapshot book) {
    print("***xxxx");
    print(book.hasData);
    print("***xxx");
    try{
      if (book.hasData != null) {

      }
    }
    on Exception catch (exception){
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
          value.isEmpty
              ? 'Book ISBN cannot be empty'
              : null,
          //onSaved: (value) => _email = value.trim(),
        ),
      );
  }

  }

  Widget showNameInput(String bookName){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_nameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: bookName,
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

  Widget showAuthorInput(String author){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_authorController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: author,
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

  Widget showCategoryInput(String category){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_categoryController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: category,
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

  Widget showSubcategoryInput(String subCategory){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_sub_categoryController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: subCategory,
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

  Widget showImageInput(String bookImage){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_imgController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: bookImage,
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

  Widget showHotlistInput(String inHotList){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_hotlistController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: inHotList,
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

  Widget showPriceInput(String price){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_priceController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: price,
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

  Widget showStockInput(String quantity) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_quantityController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: quantity,
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

  Widget showDescriptionInput(String description){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: book_descriptionController,
        maxLines: 10,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: description,
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

  Widget showUpdateBookButton(String bookId,BuildContext context) {
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
            if (book_quantity == null) {

            }
            var result =  httpAdmin.adminUpdateBook(isbn, book_name, book_author, book_category, book_sub_category,
                book_img, book_hotlist, book_quantity,  book_price, book_description);
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
