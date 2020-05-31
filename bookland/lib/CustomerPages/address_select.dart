import 'package:bookland/CustomerPages/basket.dart';
import 'package:bookland/CustomerPages/customer_address_add.dart';
import 'package:bookland/services/http_address.dart';
import 'package:flutter/material.dart';
import 'package:bookland/main.dart';
import 'package:bookland/CommonPages/ShippingCompany.dart';


class AddressSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Address Selection",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Address Selection"),
        ),
        body: AddressSelectLayout(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new CustomerAddressAdd(true)),
            );
          },
        ),
      ),
    );
  }
}

class AddressSelectLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddressSelectLayoutState();
}

class AddressSelectLayoutState extends State<AddressSelectLayout> {
  Address _address = new Address();
  int _userId = int.parse(customerID);

  @override
  Widget build(BuildContext context) {
    return _addressListView(context);
  }

  /// This function builds a list view for listing
  /// addresses on the screen
  Widget _addressListView(BuildContext context) {
    print("TOTAL PRICE");
    print(totalBasketPrice);
    print("---------------------");
    return Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<dynamic>>(
            future: _address.getAddresses(_userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<String> addressIdList = List();
                List<String> addressLineList = List();
                List<String> cityCountryList = List();
                List<Icon> iconList = List();
                for (int i = 0; i < snapshot.data.length; i++) {
                  addressIdList.add(snapshot.data[i]["addressId"].toString());
                  addressLineList.add(snapshot.data[i]["addressLine"]);
                  String cityCountry =
                      snapshot.data[i]["postalCodeCity"]["city"]["city"];
                  cityCountry += ", ";
                  cityCountry +=
                      snapshot.data[i]["postalCodeCity"]["city"]["country"];
                  cityCountryList.add(cityCountry);
                  if (snapshot.data[i]["addressTitle"] == "School") {
                    iconList.add(Icon(Icons.school));
                  } else if (snapshot.data[i]["addressTitle"] == "Home") {
                    iconList.add(Icon(Icons.home));
                  } else if (snapshot.data[i]["addressTitle"] == "Office") {
                    iconList.add(Icon(Icons.work));
                  } else {
                    iconList.add(Icon(Icons.local_post_office));
                  }
                }
                return ListView.builder(
                    itemCount: addressLineList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15)),
                        elevation: 5,
                        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: ListTile(
                          leading: iconList[index],
                          trailing: Icon(Icons.arrow_right),
                          subtitle: Text(cityCountryList[index]),
                          title: Text(addressLineList[index]),
                          onTap: () {
                            // TODO Call address page
                            // TODO Alert dialog can be opened
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new ShippingCompany(
                                      customerID, addressIdList[index])),
                            );
                          },
                        ),
                      );
                    });
              } else if (snapshot.data == null) {
                // TODO This part should be fixed
                print("NO DATA");
                noDataMessage();
              }
              return Container(
                alignment: Alignment.center,
                height: 160.0,
                child: CircularProgressIndicator(),
              );
            }));
  }

  Widget noDataMessage() {
    return Center(
      child: Text(
        "There is no address for this user!",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
