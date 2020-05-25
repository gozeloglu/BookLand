import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bookland/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookland/http_basket.dart';
import 'package:bookland/customerBookView.dart';

// This is meaningless comment line
List<String> bookIdList = [];
List<String> bookQuantityList = [];
enum WhyFarther { delete, quantity }

class Basket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getOrders(customerID);
    return MaterialApp(
      title: "My Basket",
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Basket"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh Page',
              onPressed: () {
                BasketLayoutState basketLayout = new BasketLayoutState();
                //basketLayout.getOrders(customerID);
                basketLayout.build(context);
              },
            ),
          ],
        ),
        body: BasketLayout(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          backgroundColor: Colors.green,
          onPressed: () {
            // TODO Next page
            /*Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new CustomerAddressAdd()),*/
            //);
          },
        ),
      ),
    );
  }

  void getOrders(String _customerId) async {
    print("getOrders");
    print(_customerId);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List tmpList = sharedPreferences.getStringList(_customerId);
    print("///////////////////////////////");
    print(tmpList);
    print(tmpList.length);
    bookIdList = [];
    bookQuantityList = [];
    for (int i = 0; i < tmpList.length; i += 2) {
      bookIdList.add(tmpList[i]);
      bookQuantityList.add(tmpList[i + 1]);
    }
    print(bookIdList);
    print(bookQuantityList);
    print("///////////////////////////////");
    print(sharedPreferences.getStringList(_customerId));
    print("booklist");
    print(bookIdList);
    print(_customerId);
  }
}

class BasketLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BasketLayoutState();
}

class BasketLayoutState extends State<BasketLayout> {
  BasketHttp basket = new BasketHttp();

  @override
  Widget build(BuildContext context) {
    getOrders(customerID);
    return _basketListView(context);
  }

  var _selection;
  String _selectedQuantity;

  Widget _basketListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<dynamic>>(
          future: basket.getBasketBooks(bookIdList),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              print("SNAPSHOT");
              List<String> bookNameList = List();
              List<String> quantityList = List();
              List<String> imageList = List();
              List<double> priceList = List();
              print("*-*-*-*-*-*-*-*-*-*-*-");
              print(snapshot.data.length);
              print(snapshot.data);
              print("*-*-*-*-*-*-*-*-*-*-*-");
              print(bookQuantityList);
              print(bookQuantityList.length);
              print(bookIdList);
              print(bookIdList.length);
              print(snapshot.data.length);
              print("========================");

              for (int i = 0; i < snapshot.data.length; i++) {
                print("NAME $snapshot.data[i]['bookName']");
                bookNameList.add(snapshot.data[i]["bookName"]);
                imageList.add(snapshot.data[i]["bookImage"]);
                priceList.add(snapshot.data[i]["price"]);
                quantityList.add(bookQuantityList[i]);
              }
              print("---------------------");
              print(bookNameList);
              print(imageList);
              print(priceList);
              print(quantityList);
              return ListView.builder(
                  itemCount: bookNameList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      elevation: 5,
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: ListTile(
                        //contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        //isThreeLine: true,
                        //leading: Icon(Icons.book),
                        leading: Image.network(imageList[index]),
                        trailing: PopupMenuButton<WhyFarther>(
                          onSelected: (WhyFarther result) {
                            setState(() {
                              _selection = result;
                              if (_selection == WhyFarther.delete) {
                                // TODO Delete operation
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15)),
                                      title: new Text("Delete Order"),
                                      content: new Text(
                                          "Are you sure to delete order?"),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("No"),
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          onPressed: () {
                                            // TODO Delete from shared pref
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                          // Confirm deletion
                                          child: Text("Yes"),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          color: Colors.green,
                                          onPressed: () {
                                            deleteBookFromSharedPref(
                                                customerID, index * 2);
                                            getOrders(customerID);
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        new Basket()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (_selection == WhyFarther.quantity) {
                                // TODO Quantity operation
                                showDialog(
                                    context: context,
                                    child: new MyDialog(
                                      onValueChange: _onValueChange,
                                      initialValue: quantityList[index],
                                      bookIndex: index.toString(),
                                      bookList: bookIdList,
                                      quantityList: quantityList,
                                    ));
                              }
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<WhyFarther>>[
                            const PopupMenuItem<WhyFarther>(
                              value: WhyFarther.delete,
                              child: Text('Delete Order'),
                            ),
                            const PopupMenuItem<WhyFarther>(
                              value: WhyFarther.quantity,
                              child: Text('Update Quantity'),
                            ),
                          ],
                        ),
                        title: Text(bookNameList[index] +
                            "\n" +
                            "\$" +
                            priceList[index].toString()),
                        subtitle: Text("Quantity: ${quantityList[index]}"),
                        onTap: () {},
                      ),
                    );
                  });
            } else if (snapshot.data == null) {
              // TODO This part should be fixed
              print("NO DATA");
              return Center(
                child: Text(
                  "Book basket is empty!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
            return Container(
              alignment: Alignment.center,
              height: 160.0,
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  void _onValueChange(String value) {
    setState(() {
      _selectedQuantity = value;
    });
  }

  void deleteBookFromSharedPref(String _customerId, int _bookId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> bookList = sharedPreferences.getStringList(_customerId);
    bookList.removeRange(_bookId, _bookId + 2);
    sharedPreferences.setStringList(_customerId, bookList);
  }

  void getOrders(String _customerId) async {
    print("getOrders");
    print(_customerId);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List tmpList = sharedPreferences.getStringList(_customerId);
    print("///////////////////////////////");
    print(tmpList);
    print(tmpList.length);
    bookIdList = [];
    bookQuantityList = [];
    for (int i = 0; i < tmpList.length; i += 2) {
      bookIdList.add(tmpList[i]);
      bookQuantityList.add(tmpList[i + 1]);
    }
    print(bookIdList);
    print(bookQuantityList);
    print("///////////////////////////////");
    print(sharedPreferences.getStringList(_customerId));
    print("booklist");
    print(bookIdList);
    print(_customerId);
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog(
      {this.onValueChange,
      this.initialValue,
      this.bookIndex,
      this.bookList,
      this.quantityList});

  final String initialValue;
  final void Function(String) onValueChange;
  final String bookIndex;
  final List bookList;
  final List quantityList;

  @override
  State createState() => new MyDialogState(quantityList, bookList, bookIndex);
}

class MyDialogState extends State<MyDialog> {
  List bookList;
  List quantityLst;
  String index;
  MyDialogState(List _quantityList, List _bookList, String _index) {
    bookList = _bookList;
    quantityLst = _quantityList;
    index = _index;
  }
  String _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialValue;
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Update Book Quantity"),
      content: new Padding(
          padding: const EdgeInsets.fromLTRB(50, 0.0, 50, 0),
          child: new DropdownButton<String>(
            value: _selectedId,
            style: TextStyle(fontSize: 24, color: Colors.deepPurple),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String value) {
              setState(() {
                _selectedId = value;
              });
              widget.onValueChange(value);
            },
            items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                .map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
          )),
      actions: <Widget>[
        FlatButton(
          color: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            // TODO Cancel
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        FlatButton(
          onPressed: () async {
            // TODO Save
            print("QUANTITY $_selectedId");
            quantityLst[int.parse(index)] = _selectedId;
            List<String> newList = [];
            for (int i = 0; i < quantityLst.length; i++) {
              newList.add(bookList[i]);
              newList.add(quantityLst[i]);
            }
            print(bookList);
            print(newList);
            print("-----------");
            SharedPreferences sharedPref =
                await SharedPreferences.getInstance();
            sharedPref.setStringList(customerID, newList);
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Basket()));
          },
          color: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Text("Save"),
        )
      ],
    );
  }
}
