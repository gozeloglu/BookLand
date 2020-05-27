import 'package:bookland/elements/appBar.dart';
import 'package:bookland/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookland/http_address.dart';
import 'package:bookland/address_list.dart';
import 'dart:async';

/// This variable is responsible for informing
/// that saving operation's status
bool isUpdated;
int _userId;
int _addressId;
String _addressTitle;
String _addressLine;
String _city;
String _country;
String _postalCode;

class CustomerAddressUpdate extends StatelessWidget {
  /// @param addressMap is a map which stores address information of the user
  /// @param userId represents user's id that is used for updating
  /// @param isUpdated is a variable that tracks the update operation
  /// This function is a constructor to assign text field variables
  CustomerAddressUpdate(
      Map<String, dynamic> addressMap, int userId, bool _isUpdated) {
    _userId = userId;
    _addressId = addressMap["addressId"];
    _addressTitle = addressMap["addressTitle"];
    _addressLine = addressMap["addressLine"];
    _city = addressMap["postalCodeCity"]["city"]["city"];
    _country = addressMap["postalCodeCity"]["city"]["country"];
    _postalCode = addressMap["postalCodeCity"]["postalCode"];
    isUpdated = _isUpdated;
  }
  static const String _title = "Update Address";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: CustomerAddressUpdateStateful(),
    );
  }
}

class CustomerAddressUpdateStateful extends StatefulWidget {
  @override
  _AddressUpdatePageState createState() => _AddressUpdatePageState();
}

class _AddressUpdatePageState extends State<CustomerAddressUpdateStateful> {
  Address address = new Address();

  /// Default text are put into text fields
  TextEditingController addressLineController =
      new TextEditingController(text: _addressLine);
  TextEditingController cityController = new TextEditingController(text: _city);
  TextEditingController countryController =
      new TextEditingController(text: _country);
  TextEditingController postalCodeController =
      new TextEditingController(text: _postalCode);

  String addressLine = _addressLine;
  String city = _city;
  String country = _country;
  String postalCode = _postalCode;
  String addressTitle = _addressTitle;
  String dropdownValue = _addressTitle;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBar(
        pageTitle: "Update Address",
        back: true,
      ),
      body: Stack(
        children: <Widget>[_showUpdateForm()],
      ),
    );
  }

  /// This function builds a widget that shows the form to update address
  /// Calls other widgets sequentially and put on the page
  Widget _showUpdateForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showAddressLine(),
            showCity(),
            showCountry(),
            showPostalCode(),
            showDropButton(),
            showUpdateButton(),
          ],
        ),
      ),
    );
  }

  /// This function builds a text field to get address from user
  Widget showAddressLine() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        controller: addressLineController,
        maxLines: 5,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Your Address",
          icon: Icon(Icons.home),
        ),
        validator: (value) =>
            value.isEmpty ? "Address line cannot be empty" : null,
        onSaved: (value) => addressLine = value.trim(),
      ),
    );
  }

  /// This function builds a text field to get city from user
  Widget showCity() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50, 0, 0),
      child: new TextFormField(
        controller: cityController,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          labelText: "City",
          icon: Icon(Icons.location_city),
        ),
        validator: (value) => value.isEmpty ? "City cannot be empty!" : null,
        onSaved: (value) => city = value.trim(),
      ),
    );
  }

  /// This function builds a text field to get country from user
  Widget showCountry() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50, 0, 0),
      child: new TextFormField(
        controller: countryController,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Country",
          icon: Icon(Icons.flight),
        ),
        validator: (value) => value.isEmpty ? "Country cannot be empty!" : null,
        onSaved: (value) => country = value.trim(),
      ),
    );
  }

  /// This function builds text field to get postal code from user
  Widget showPostalCode() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50, 0, 0),
      child: new TextFormField(
        controller: postalCodeController,
        maxLines: 1,
        autofocus: false,
        keyboardType: TextInputType.number,
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

  /// This function builds a drop button
  /// User can choose one the proper address title
  /// Address titles : Home, Office, School, Other
  /// Users last selection is put on the default value
  Widget showDropButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: DropdownButton<String>(
        value: dropdownValue,
        iconSize: 24,
        elevation: 16,
        style: TextStyle(fontSize: 24, color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Home', 'Office', 'School', 'Other']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  /// This function build a button to update address
  /// Calls PUT method
  /// Alert dialog controls are handled in this function
  Widget showUpdateButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30)),
          color: Colors.green,
          child: new Text(
            "Update Address",
            style: new TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {
            // Inputs are retrieved by controller
            addressLine = addressLineController.text;
            city = cityController.text;
            country = countryController.text;
            postalCode = postalCodeController.text;
            addressTitle = dropdownValue;

            // Fields are controlled
            // If one of the fields is empty
            // Alert dialog is showed up
            String errorMessage = " cannot be empty!";
            String fieldName = "";
            bool error = false;
            if (addressLine == "") {
              fieldName = "Address";
              error = true;
            } else if (city == "") {
              fieldName = "City";
              error = true;
            } else if (country == "") {
              fieldName = "Country";
              error = true;
            } else if (postalCode == "") {
              fieldName = "Postal code";
              error = true;
            } else if (addressTitle == "") {
              fieldName = "Address title";
              error = true;
            }

            // If one of the fields is empty
            // Show up the alert dialog
            if (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error!"),
                      content: Text(fieldName + errorMessage),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25)),
                    );
                  });
            } else {
              // Update address
              // Call HTTP.PUT method
              address.updateAddress(_userId, _addressId, addressLine, city,
                  country, postalCode, addressTitle);
            }

            // Timer is added for showing up alert dialog
            Timer(Duration(seconds: 1), () {
              // Show up alert dialogs
              // If address is updated successfully, show up successful message
              // If address is not updated successfully, show up error message
              if (isUpdated) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Updated!"),
                        content: Text("Address is updated  successfully!"),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25)),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new MyAddresses()));
                            },
                          )
                        ],
                      );
                    });
              }
              // If address could not updated and there is a empty field
              // Show up this alert dialog
              else if (isUpdated != true && error == false) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error!"),
                        content: Text("Address could not updated!"),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25)),
                      );
                    });
              }
            });
          }),
    );
  }
}
