import 'dart:io';

import 'package:bookland/address_select.dart';
import 'package:flutter/material.dart';
import 'package:bookland/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookland/http_basket.dart';

// These lists store book id and quantities
// finalOrders stores latest order in string format
List<String> bookIdList = [];
List<String> bookQuantityList = [];
String finalOrders = "";
enum WhyFarther { delete, quantity } // This is for popup menu items

class Basket extends StatelessWidget {
  SharedPrefBooks _sharedPrefBooks = new SharedPrefBooks();
  @override
  Widget build(BuildContext context) {
    _sharedPrefBooks.getOrdersFromSharedPref(customerID);
    return MaterialApp(
      title: "My Basket",
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Basket"),
          centerTitle: true,
        ),
        body: BasketLayout(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          backgroundColor: Colors.green,
          onPressed: () {
            // Latest order list is converted to string format
            finalOrders = "";
            for (int i = 0; i < bookIdList.length; i++) {
              finalOrders += bookIdList[i];
              finalOrders += ",";
              finalOrders += bookQuantityList[i];
              finalOrders += ",";
            }
            print(finalOrders);
            // Go to next page - Address select
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new AddressSelect()),
            );
          },
        ),
      ),
    );
  }
}

class BasketLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BasketLayoutState();
}

class BasketLayoutState extends State<BasketLayout> {
  BasketHttp basket = new BasketHttp();
  SharedPrefBooks _sharedPrefBooks = new SharedPrefBooks();

  @override
  Widget build(BuildContext context) {
    _sharedPrefBooks.getOrdersFromSharedPref(customerID);
    return _basketListView(context);
  }

  var _selection;
  String _selectedQuantity;

  /// This function builds basket page
  Widget _basketListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<dynamic>>(
          future: basket.getBasketBooks(bookIdList),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> bookNameList = List();
              List<String> quantityList = List();
              List<String> imageList = List();
              List<double> priceList = List();

              // Add book name, book image, price, and quantities on the lists
              for (int i = 0; i < snapshot.data.length; i++) {
                bookNameList.add(snapshot.data[i]["bookName"]);
                imageList.add(snapshot.data[i]["bookImage"]);
                priceList.add(snapshot.data[i]["price"]);
                quantityList.add(bookQuantityList[i]);
              }
              return ListView.builder(
                  itemCount: bookNameList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      elevation: 5,
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: ListTile(
                        leading: Image.network(imageList[index]),
                        trailing: PopupMenuButton<WhyFarther>(
                          onSelected: (WhyFarther result) {
                            setState(() {
                              _selection = result;

                              // If user wants to delete a book
                              if (_selection == WhyFarther.delete) {
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
                                        new FlatButton(
                                          child: new Text("No"),
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          onPressed: () {
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
                                            // Delete from shared preferences
                                            // Get books from shared preferences
                                            deleteBookFromSharedPref(
                                                customerID, index * 2);
                                            _sharedPrefBooks
                                                .getOrdersFromSharedPref(
                                                    customerID);
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
                                // This alert dialog is used for
                                // updating book quantity
                                showDialog(
                                    context: context,
                                    child: new UpdateDialog(
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
                      ),
                    );
                  });
            } else if (snapshot.data == null) {
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

  /// @param value represents the new changed value on dropdown menu
  /// This function sets the new updated state on dropdown menu
  void _onValueChange(String value) {
    setState(() {
      _selectedQuantity = value;
    });
  }

  /// @param _customerId represents the customer's id
  /// @param _bookId represents the book that we want to delete from shared pref
  /// Create a shared preferences object
  /// Read book list from shared preferences
  /// Remove book id and book quantity from list
  /// Update the shared preferences by writing back
  void deleteBookFromSharedPref(String _customerId, int _bookId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> bookList = sharedPreferences.getStringList(_customerId);
    bookList.removeRange(_bookId, _bookId + 2);
    sharedPreferences.setStringList(_customerId, bookList);
  }
}

class SharedPrefBooks {
  /// This class is using for accessing function from multiple places on the code

  /// @param _customerId represents the customer id that we want to get book
  /// This function is used for getting orders from shared preferences
  /// Creates a shared preferences object
  /// Gets book list from shared preferences
  /// Makes empty book id list and book quantity list if they are not empty
  /// Adds book ids and book quantities
  void getOrdersFromSharedPref(String _customerId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List tmpList = sharedPreferences.getStringList(_customerId);

    bookIdList = [];
    bookQuantityList = [];
    for (int i = 0; i < tmpList.length; i += 2) {
      bookIdList.add(tmpList[i]);
      bookQuantityList.add(tmpList[i + 1]);
    }
  }
}

class UpdateDialog extends StatefulWidget {
  /// This class is used for book update alert dialog
  const UpdateDialog(
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
  State createState() =>
      new UpdateDialogState(quantityList, bookList, bookIndex);
}

class UpdateDialogState extends State<UpdateDialog> {
  List bookList;
  List quantityLst;
  String index;
  UpdateDialogState(List _quantityList, List _bookList, String _index) {
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
            quantityLst[int.parse(index)] = _selectedId;
            List<String> newList = [];
            for (int i = 0; i < quantityLst.length; i++) {
              newList.add(bookList[i]);
              newList.add(quantityLst[i]);
            }
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
