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

class BasketLayoutState extends State<BasketLayout> {
  OrderHttp _orderHttp = new OrderHttp();
  List aa = [];
  @override
  Widget build(BuildContext context) {
    return _basketListView(context);
  }

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
                        leading: Icon(Icons.bookmark_border),
                        trailing: GestureDetector(
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
                            child: Icon(Icons.delete),
                          ),
                        ),
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
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List bookList = pref.getStringList(_customerId);
    print(pref.getStringList(_customerId));
    print("booklist");
    print(bookList);
    print(_customerId);
    return bookList;
  }
}
