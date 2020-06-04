//ignore: avoid_web_libraries_in_flutter
//import 'dart:html';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookland/services/http_admin.dart';



class DeletePage extends StatefulWidget {
  @override
  _DeletePageState createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpAdmin httpAdmin = HttpAdmin();
  String isbn;
  TextEditingController isbnController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(pageTitle: "Delete Book",
        loginIcon: true,
        back: false,
        filter_list: false,
        search: true,
      ),
      body: Container(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: isbnController,
              onChanged: (value) {},
              decoration: InputDecoration(
                  labelText: "ISBN",
                  hintText: "Enter the ISBN",
                  prefixIcon: Icon(Icons.delete),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: FlatButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.red,
              onPressed: () {
                isbn = isbnController.text;
                var result = httpAdmin.adminDeleteBook(isbn);
                print(result);
              },
              child: Text("Delete", style: TextStyle(fontSize: 22)),
            ),
          )
        ]),
      ),

      bottomNavigationBar: MyBottomNavigatorBar(),
    );
  }
}
