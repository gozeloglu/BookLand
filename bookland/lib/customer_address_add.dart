import 'package:bookland/elements/appBar.dart';
import 'package:bookland/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerAddressAdd extends StatelessWidget {
  static const String _title = "Add Address";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: CustomerAddressAddStateful(),
    );
  }
}

class CustomerAddressAddStateful extends StatefulWidget {
  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<CustomerAddressAddStateful> {
  TextEditingController addressLineController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();
  TextEditingController addressTitleController = new TextEditingController();

  String addressLine;
  String postalCode;
  String addressTitle;

  String dropdownValue = "Home";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBar(
        pageTitle: "Add Address",
        back: true,
      ),
      body: Stack(
        children: <Widget>[_showForm()],
      ),
    );
  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showAddressLine(),
            showPostalCode(),
            //showAddressTitle(),
            showDropButton(),
            showSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget showAddressLine() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        controller: addressLineController,
        maxLines: 5,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          //hintText: "Your Address",
          labelText: "Your Address",
          icon: Icon(Icons.home),
        ),
        validator: (value) =>
            value.isEmpty ? "Address line cannot be empty" : null,
        onSaved: (value) => addressLine = value.trim(),
      ),
    );
  }

  Widget showPostalCode() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50, 0, 0),
      child: new TextFormField(
        controller: postalCodeController,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Postal Code",
          icon: Icon(Icons.local_post_office),
        ),
        validator: (value) =>
            value.isEmpty ? "Postal Code cannot be empty!" : null,
        onSaved: (value) => postalCode = value.trim(),
      ),
    );
  }

  Widget showAddressTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: new TextFormField(
        controller: addressTitleController,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Address Title",
          icon: Icon(Icons.format_list_bulleted),
        ),
        validator: (value) =>
            value.isEmpty ? "Address title cannot be empty!" : null,
        onSaved: (value) => addressTitle = value.trim(),
      ),
    );
  }

  Widget showDropButton() {


    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: DropdownButton<String>(
        value: dropdownValue,
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            fontSize: 24,
            color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            print(newValue);
            dropdownValue = newValue;
          });
        },
        items: <String>['Home', 'Office', 'School']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),/*DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            addressTitle = newValue;
            print(addressTitle);
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),*/

    );
  }

  Widget showSaveButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30)),
          color: Colors.green,
          child: new Text(
            "Save Address",
            style: new TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {
            // TODO Save address
            addressLine = addressLineController.text;
            postalCode = postalCodeController.text;
            addressTitle = dropdownValue;
            /// addressTitle = addressTitleController.text;
          }),
    );
  }
}
