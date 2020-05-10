import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookland/http_address.dart';
import 'package:bookland/main.dart';

int _addressId;
String _addressTitle;
String _addressLine;
String _city;
String _country;
String _postalCode;

class AddressDetails extends StatelessWidget {
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
