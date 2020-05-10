import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressDetails extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return _addressDetailView(context);
  }

  Widget _addressDetailView(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.all(32),
        child: new Column(
            //mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new ListTile(
                leading: Icon(Icons.format_list_bulleted),
                title: const Text("Address Type"),
                subtitle: const Text("Home"),
              ),
              new ListTile(
                leading: Icon(Icons.local_post_office),
                title: const Text("Address Line"),
                subtitle: const Text("Fatih Mahallesi 3389 Sokak No:14"),
              ),
              new ListTile(
                leading: Icon(Icons.location_city),
                title: const Text("City"),
                subtitle: const Text("Antalya"),
              ),
              new ListTile(
                leading: Icon(Icons.flight),
                title: const Text("Country"),
                subtitle: const Text("Turkey"),
              ),
              new ListTile(
                leading: Icon(Icons.local_post_office),
                title: const Text("Postal Code"),
                subtitle: const Text("0700"),
              ),
              Divider(
                height: 20.0,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: MaterialButton(
                      color: Colors.red,
                      height: 64,
                      padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20)
                      ),
                      onPressed: () => {},
                      child: Text("Delete", style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),),
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
                          borderRadius: new BorderRadius.circular(20)
                      ),
                      onPressed: () => {},
                      child: Text("Update", style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),),
                    ),
                  ),
                ),
              ]),
            ]));
    /*return Padding(
      padding: const EdgeInsets.all(32),
      child: Card(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20)
        ),
        elevation: 3,
        margin: const EdgeInsets.fromLTRB(10, 50, 10, 50),
        child: Text("DENEME"),
      ),
    );*/
  }
}
