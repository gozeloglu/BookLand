import 'package:flutter/material.dart';
import 'package:bookland/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookland/customerBookView.dart';

// This is meaningless comment line

class Basket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Basket",
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Basket"),
        ),
        body: BasketLayout(),
      ),
    );
  }
}

class BasketLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BasketLayoutState();
}

enum WhyFarther { delete, quantity }

class BasketLayoutState extends State<BasketLayout> {
  OrderHttp _orderHttp = new OrderHttp();
  // This is the type used by the popup menu below.

  List aa = [];
  @override
  Widget build(BuildContext context) {
    return _basketListView(context);
  }

  var _selection;
  int _quantity = 1;
  String quantityValue = "1";
  String _selectedId;

  Widget _basketListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<dynamic>>(
          future: _orderHttp.getOrders(customerID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> bookList = List();
              List<String> quantityList = List();

              for (int i = 0; i < snapshot.data.length; i += 2) {
                bookList.add(snapshot.data[i]);
                quantityList.add(snapshot.data[i + 1]);
              }
              return ListView.builder(
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      elevation: 5,
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: ListTile(
                        leading: Icon(Icons.book),
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
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Yes"),
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
                                     initialValue: _selectedId,
                                   )
                                   /* builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        title: Text("Change Book Quantity"),
                                        content: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 0, 50, 0),
                                          child: DropdownButton<String>(
                                            value: quantityValue,
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
                                                quantityValue = newValue;
                                              });
                                            },
                                            items: <String>[
                                              '1',
                                              '2',
                                              '3',
                                              '4',
                                              '5',
                                              '6',
                                              '7',
                                              '8',
                                              '9',
                                              '10'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              // TODO Cancel
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              // TODO Save
                                            },
                                            color: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text("Save"),
                                          )
                                        ],
                                      );
                                    }*/
                                    );
                              }
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<WhyFarther>>[
                            const PopupMenuItem<WhyFarther>(
                              value: WhyFarther.delete,
                              child: Text('Delete'),
                            ),
                            const PopupMenuItem<WhyFarther>(
                              value: WhyFarther.quantity,
                              child: Text('Quantity'),
                            ),
                          ],
                        ),

                        /*GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15)),
                                  title: new Text("Delete Order"),
                                  content:
                                      new Text("Are you sure to delete order?"),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    new FlatButton(
                                      child: new Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Yes"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            alignment: Alignment.center,
                            child: Icon(Icons.more_horiz),
                          ),
                        ),*/
                        subtitle: Text(quantityList[index]),
                        title: Text(bookList[index]),
                        onTap: () {},
                      ),
                    );
                  });
            } else if (snapshot.data == null) {
              // TODO This part should be fixed
              print("NO DATA");
            }
            return Container(
              alignment: Alignment.center,
              height: 160.0,
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  void increment() {
    setState(() {
      _quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({this.onValueChange, this.initialValue});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
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
            padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
            child: new DropdownButton<String>(
              hint: const Text("Pick a thing"),
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
              items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            )),
      actions: <Widget>[
        FlatButton(
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          onPressed: () {
            // TODO Cancel
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        FlatButton(
          onPressed: () {
            // TODO Save
            print("QUANTITY $_selectedId");
          },
          color: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15)),
          child: Text("Save"),
        )
      ],
    );
  }
}

/*
* kitap ismi- quantity - image
* shared = {customer_id_1: [b1, q1, b2, q2, b5, q5],cus_2:[ cus_3   }
* http:url.com/cus/book/
* key: customer
* book: list
* */
class OrderHttp {
  Future<List<dynamic>> getOrders(String _customerId) async {
    print("getOrders");
    print(_customerId);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List bookList = sharedPreferences.getStringList(_customerId);
    print(sharedPreferences.getStringList(_customerId));
    print("booklist");
    print(bookList);
    print(_customerId);
    return bookList;
  }
}
