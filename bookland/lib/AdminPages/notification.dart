import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationStateless extends StatelessWidget {
  final String _couponCode;
  final String _couponDiscount;
  final String _campaignName;
  final String _endDate;

  NotificationStateless(this._couponCode, this._couponDiscount,
      this._campaignName, this._endDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        pageTitle: "Notification",
        loginIcon: false,
        back: false,
        filter_list: false,
        search: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: new Stack(
          children: [
            notificationPage(),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigatorBar(),
    );
  }

  Widget notificationPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 10,
          child: campaignInfo(),
        ),
        /*Expanded(
          flex: 2,
          child: notificationTitle(),
        ),
        Expanded(
          flex: 3,
          child: notificationMessage(),
        ),
        Expanded(
          flex: 1,
          child: sendNotificationButton(),
        )*/
      ],
    );
  }

  Widget campaignInfo() {
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.more),
            title: const Text("Coupon Code"),
            subtitle: Text(_couponCode), // TODO Will be dynamic
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.trending_down),
            title: const Text("Discount"),
            subtitle: Text(_couponDiscount + "%"), // TODO Will be dynamic
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.category),
            title: const Text("Campaign"),
            subtitle: Text(
                _campaignName), // TODO Will be dynamic
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.date_range),
            title: const Text("Date"),
            subtitle: Text(_endDate), // TODO Will be dynamic
          ),
        ),
        notificationTitle(),
        notificationMessage(),
        sendNotificationButton(),
      ],
    );
  }

  Widget notificationTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: TextFormField(
        controller: null, // TODO This will be changed with controller
        maxLines: 1,
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
          //hintText: "Notification Title",
          labelText: "Notification Title",
          border: OutlineInputBorder(),
          icon: Icon(Icons.title),
        ),
      ),
    );
  }

  Widget notificationMessage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: TextFormField(
        controller: null,
        maxLines: 3,
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
          // hintText: "Notification Message"
          labelText: "Notification Message",
          border: OutlineInputBorder(),
          icon: Icon(Icons.message),
        ),
      ),
    );
  }

  Widget sendNotificationButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: RaisedButton(
        elevation: 5,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30)),
        color: Colors.green,
        child: new Text(
          "Send Notification",
          style: new TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }
}
