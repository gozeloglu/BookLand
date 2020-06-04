import 'dart:async';

import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/services/http_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool notificationSent = false;

class NotificationStateful extends StatefulWidget {
  final String _couponCode;
  final String _couponDiscount;
  final String _campaignName;
  final String _endDate;

  NotificationStateful(this._couponCode, this._couponDiscount,
      this._campaignName, this._endDate);

  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<NotificationStateful> {
  TextEditingController notificationTitleController =
      new TextEditingController();
  TextEditingController notificationMsgController = new TextEditingController();

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
            subtitle: Text(widget._couponCode), // TODO Will be dynamic
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.trending_down),
            title: const Text("Discount"),
            subtitle:
                Text(widget._couponDiscount + "%"), // TODO Will be dynamic
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.category),
            title: const Text("Campaign"),
            subtitle: Text(widget._campaignName), // TODO Will be dynamic
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.date_range),
            title: const Text("Date"),
            subtitle: Text(widget._endDate), // TODO Will be dynamic
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
        controller: notificationTitleController,
        // TODO This will be changed with controller
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
        controller: notificationMsgController,
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
        onPressed: () {
          String notificationTitle = notificationTitleController.text;
          String notificationMessage = notificationMsgController.text;
          String errorMessage = "";

          if (notificationTitle == "") {
            errorMessage += "Notification title is empty!";
          } else if (notificationMessage == "") {
            errorMessage += "Notification message is empty!";
          }

          if (errorMessage != "") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  title: new Text("Empty Field Warning"),
                  content: new Text(errorMessage),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.blue,
                      child: new Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            notificationMessage += "\n\n";
            notificationMessage += "Coupon Code: ";
            notificationMessage += widget._couponCode;
            notificationMessage += "\nDue Date: ";
            notificationMessage += widget._endDate;
            NotificationHttp notificationHttp = new NotificationHttp();
            notificationHttp.sendNotification(
                notificationTitle, notificationMessage);
            Timer(Duration(seconds: 1), () {
              if (notificationSent) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      title: new Text("Notification"),
                      content: new Text("Notification is sent!"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.blue,
                          child: new Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                if (notificationSent) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        title: new Text("Notification Error"),
                        content: new Text("Notification could not send!"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.blue,
                            child: new Text(
                              "Close",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            });
          }
        },
      ),
    );
  }
}
