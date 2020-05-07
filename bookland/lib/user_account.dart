import 'package:bookland/elements/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPageStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Account",
      home: AccountPageStateful(),
    );
  }
}

class AccountPageStateful extends StatefulWidget {
  AccountPageStateful({Key key}) : super(key: key);
  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPageStateful> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBar(
        pageTitle: "Account",
        back: false,
      ),
      body: Stack(
        children: <Widget>[
          nameWidget("Gökhan"),
        ],
      ),
    );
  }

  /// @param name represents user name
  /// @return Container widget
  Widget nameWidget(String name) {
    /// This function creates and returns text field
    /// that show user name and "Hello" message
    return Container(
      margin: const EdgeInsets.fromLTRB(100, 50, 100, 10),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(
        "Hello $name",
        textScaleFactor: 2,
      ),
    );
  }
}
