import 'package:bookland/services/http_customer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../elements/appBar.dart';
import '../elements/bottomNavigatorBar.dart';


class CustomerProfileUpdate extends StatelessWidget {
  final AsyncSnapshot snapshot ;
  CustomerProfileUpdate({Key key, @required this.snapshot}) : super(key: key);

  HttpCustomer httpCustomer = new HttpCustomer();

  String customerId;
  String firstname;
  String surname;
  String email;
  //String password;
  String DoB;
  String phone;

  TextEditingController customerIdContoller = new TextEditingController();
  TextEditingController customerFirstnameController = new TextEditingController();
  TextEditingController customerSurnameController = new TextEditingController();
  TextEditingController customerEmailController = new TextEditingController();
  //TextEditingController customerPasswordController = new TextEditingController();
  TextEditingController customerDobController = new TextEditingController();
  TextEditingController customerPhoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: MyAppBar(
            pageTitle: "Update Profile",
            back: true,
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: new Stack(
              children: <Widget>[_showForm(snapshot, context)],
            ),
          ),
          bottomNavigationBar: MyBottomNavigatorBar(),
        )
    );
  }

  Widget _showForm(AsyncSnapshot snapshot, BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(1.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            //showISBNInput(book),
            showFirstnameInput(snapshot == null ? "FirstName" : snapshot.data.FirstName.toString()),
            showSurnameInput(snapshot == null ? null : snapshot.data.customerSurname.toString()),
            showEmailInput(snapshot == null ? null : snapshot.data.customerEmail.toString()),
            //showPasswordInput(snapshot == null ? null : snapshot.data.Password.toString()),
            showPhoneInput(snapshot == null ? null : snapshot.data.customerPhone.toString()),
            showDateofBirthInput(snapshot == null ? null : snapshot.data.customerDoB.toString()),
            showUpdateProfileButton(snapshot.data.CustomerId.toString(), context)
          ],
        ),
      ),
    );
  }


  Widget showFirstnameInput(String customerName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        //  initialValue: "meraba",//bookName == null ? "Book Name" : bookName,
        controller: customerFirstnameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: customerName,
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

  Widget showSurnameInput(String customerSurname) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: customerSurnameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: customerSurname,
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

  Widget showEmailInput(String customerEmail) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: customerEmailController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: customerEmail,
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

  //Bu Widget Password değişimi eklememiz halinde gerekli olabilir, silmeyin.
  /* Widget showPasswordInput(String customerPassword) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        //  initialValue: "meraba",//bookName == null ? "Book Name" : bookName,
        controller: customerPasswordController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: customerPassword,
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
  } */

  Widget showPhoneInput(String customerPhone) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        //  initialValue: "meraba",//bookName == null ? "Book Name" : bookName,
        controller: customerPhoneController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: customerPhone,
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

  Widget showDateofBirthInput(String customerDoB) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        //  initialValue: "meraba",//bookName == null ? "Book Name" : bookName,
        controller: customerDobController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: customerDoB,
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

  Widget showUpdateProfileButton(String customerIDs, BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          color: Colors.blue,
          disabledColor: Colors.redAccent,
          //add this to your code,
          child: new Text("Update Profile!",
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
            //_formKey.currentState.validate();

            customerId = customerIDs;

            firstname = customerFirstnameController.text;
            surname = customerSurnameController.text;
            email = customerEmailController.text;
            //password = customerPasswordController.text;
            DoB = customerDobController.text;
            phone = customerPhoneController.text;

            var result = httpCustomer.updateCustomerProfile(
              customerId,
              firstname.isEmpty == true ? null : firstname,
              surname.isEmpty == true ? null : surname,
              //password.isEmpty == true ? null : password,
              DoB.isEmpty == true ? null : DoB,
              phone.isEmpty == true ? null : phone,
              email.isEmpty == true ? null : email,
            );

            /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new customerPersonalInfo(customerId: customerID),
                )); */

          }),
    );
  }
}

