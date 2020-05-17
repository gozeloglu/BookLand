import 'package:bookland/my_addresses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookland/http_address.dart';
import 'package:bookland/main.dart';

/// Given address' information to show up on the screen
int _addressId;
String _addressTitle;
String _addressLine;
String _city;
String _country;
String _postalCode;

class AddressDetails extends StatelessWidget {
  /// @param addressMap contains the information of the given address
  /// This is a constructor that gets the address map from list page
  /// addressMap contains addressId, address title, address line,
  /// postal code, city, country
  /// Assigns the information to global variables
  AddressDetails(Map<String, dynamic> addressMap) {
    _addressId = addressMap["addressId"];
    _addressTitle = addressMap["addressTitle"];
    _addressLine = addressMap["addressLine"];
    _city = addressMap["postalCodeCity"]["city"]["city"];
    _country = addressMap["postalCodeCity"]["city"]["country"];
    _postalCode = addressMap["postalCodeCity"]["postalCode"];
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Address Detail",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Address Detail"),
        ),
        body: AddressDetailsLayout(),
      ),
    );
  }
}

class AddressDetailsLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddressDetailsState();
}

class AddressDetailsState extends State<AddressDetailsLayout> {
  Address _address = new Address();
  int _userId = int.parse(customerID);

  @override
  Widget build(BuildContext context) {
    return _addressDetailView(context);
  }

  /// This function builds a page that shows the details of the address
  /// User can delete or update the address
  /// After address deleted alert dialog is showed up
  Widget _addressDetailView(BuildContext context) {
    print(_userId);
    print(_addressId);
    return new Padding(
        padding: const EdgeInsets.all(32),
        child: new Column(
            //mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new ListTile(
                leading: Icon(Icons.format_list_bulleted),
                title: const Text("Address Title"),
                subtitle: Text(_addressTitle),
              ),
              new ListTile(
                leading: Icon(Icons.local_post_office),
                title: const Text("Address Line"),
                subtitle: Text(_addressLine),
              ),
              new ListTile(
                leading: Icon(Icons.location_city),
                title: const Text("City"),
                subtitle: Text(_city),
              ),
              new ListTile(
                leading: Icon(Icons.flight),
                title: const Text("Country"),
                subtitle: Text(_country),
              ),
              new ListTile(
                leading: Icon(Icons.local_post_office),
                title: const Text("Postal Code"),
                subtitle: Text(_postalCode),
              ),
              Divider(
                height: 20.0,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomLeft,
                        child: MaterialButton(
                          color: Colors.red,
                          height: 64,
                          padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20)),
                          onPressed: () {
                            _address.deleteAddress(_userId, _addressId);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                return AlertDialog(
                                  title: new Text("Delete Book"),
                                  content:
                                      new Text("Book is deleted successfully!"),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    new FlatButton(
                                      child: new Text("Close"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new MyAddresses()));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: MaterialButton(
                          color: Colors.green,
                          height: 64,
                          padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20)),
                          onPressed: () => {},
                          child: Text(
                            "Update",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ]));
  }
}
