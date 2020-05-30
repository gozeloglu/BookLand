import 'dart:async';
import 'dart:ffi';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/drawer.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:bookland/services/HTTP.dart';
import 'package:bookland/model/model_shippingcompany.dart';
import 'package:bookland/basket.dart';

import 'package:bookland/payment.dart';

String customerId;
String addressId;
String totalPrice;
class ShippingCompany extends StatefulWidget {
  ShippingCompany(String _customerId, String _addressId) {
    customerId = _customerId;
    addressId = _addressId;
  }
  @override
  ShippingCompanyState createState() => new ShippingCompanyState();
}

class ShippingCompanyState extends State<ShippingCompany> {
  final HTTPAll http_obj = HTTPAll();
  String dropdownValue = "Shipping Company";
  String shipping_companyid = "-1";
  Map map = {};
  Map mapPrice = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          pageTitle: "Shipping Companies",
          back: true,
        ),
        body: FutureBuilder(
            future: http_obj.getCompanies(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print("HERE IMAMMMM");
              if (snapshot.hasData) {
                List<Model_ShippingCompany> shippingCompList = snapshot.data;
                List<String> printList = ['Shipping Company'];
                for (int i = 0; i < shippingCompList.length; i++) {
                  printList.add(shippingCompList[i].companyName +
                      "\t\$" +
                      shippingCompList[i].shippingPrice);
                }
                print(printList);
                //var map1 = Map.fromIterable(shippingCompList, key: (e) => e.shippingCompanyId.toString(), value: (e) => (e.companyName.toString() +"\t\$"+e.shippingPrice.toString() ) );
                map = Map.fromIterable(shippingCompList,
                    key: (e) => (e.companyName.toString() +
                        "\t\$" +
                        e.shippingPrice.toString()),
                    value: (e) => e.shippingCompanyId.toString());
                map['Shipping Company'] = "-1";
                print(map);
                mapPrice = Map.fromIterable(shippingCompList,
                    key: (e) => e.shippingCompanyId.toString(),
                    value: (e) => e.shippingPrice.toString());
                print(mapPrice);
                //print(snapshot.data.companyName.toString());
                print("snapshot has data");
                print("Here");
                return new Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                    //border: new Border.all(color: Colors.grey[500]),
                    //color: Colors.indigo,
                    image: DecorationImage(
                      image: AssetImage("assets/skyfall.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  padding: EdgeInsets.all(1.0),
                  //resizeToAvoidBottomPadding: false,
                  child: new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        Text("\n\n\n\n\n\n"),
                        Text("\n\n\n\n\n\n"),

                        Text("\n\n\n\n\n\n"),
                        // Image.asset('assets/skyfall.png'),
                        Container(
                            width: 300.0,
                            height: 60,
                            margin: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 30.0,
                            ),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50,
                                    style: BorderStyle.solid,
                                    color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: new SingleChildScrollView(
                                        child: DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 30,
                                      elevation: 25,
                                      style: TextStyle(color: Colors.black),
                                      onChanged: (String newValue) {
                                        print("chosed new one heyoo :");
                                        setState(() {
                                          dropdownValue = newValue;
                                          //shipping_company = newValue;
                                          shipping_companyid =
                                              map[dropdownValue.toString()];
                                          print(shipping_companyid);
                                        });
                                      },
                                      items: printList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }).toList(),
                                    ))))),
                        chooseShippingComp(),
                        //Image.asset('assets/shipping.png'),
                        Text("\n\n\n\n\n\n\t"),
                        Text("\n\n\n\n\n\n"),

                        Text("\n\n\n\n\n\n"),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print("Snapshot has error*");
                return Text("${snapshot.error}");
              } else {
                print("EROROOROR");
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget chooseShippingComp() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          color: Colors.yellow,
          disabledColor: Colors.orangeAccent,
          //add this to your code,
          child: new Text("Go On",
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
            if (shipping_companyid == "-1") {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("Select an Shipping Company"),
                    content: new Text(
                        "Please select a company from the drop-down menu to continue."),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              print("CHOSEN shipping");
              print(shipping_companyid); //TODO send this to Payment
              print(mapPrice[shipping_companyid]);
              String addrId = addressId;
              String customerid = customerId;
              String totalPrice = "19,99"; //TODO toplama işlemi
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Payment(
                          totalcost: totalPrice,
                          shippingcompany_id: shipping_companyid,
                          customerid: customerid,
                      addressid:addrId ,
                        )),
              );
            }
          }),
    );
  }
}
