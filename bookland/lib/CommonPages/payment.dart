import 'dart:async';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:bookland/services/HTTP.dart';
import 'package:bookland/model/model_shippingcompany.dart';
import 'package:shared_preferences/shared_preferences.dart';

String nt_price = "";



class Payment extends StatelessWidget {
  static const String _title = 'Payment';
  final String totalcost;
  final String shippingcompany_id;
  final String customerid;
  final String addressid;
  Payment({Key key, @required this.totalcost , @required this.shippingcompany_id , @required  this.customerid , @required  this.addressid} ) {
    nt_price = totalcost;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body :PaymentStatefulWidget(totalcost,shippingcompany_id,customerid,addressid),
    );
  }
}

class PaymentStatefulWidget extends StatefulWidget {
  final String totalcost;
  final String shippingcompany_id;
  final String customerid;
  final String addressid;
  PaymentStatefulWidget(this.totalcost,this.shippingcompany_id,this.customerid,this.addressid);

  @override
  _PaymentPageState createState() => _PaymentPageState(totalcost,shippingcompany_id,customerid,addressid);
}

class _PaymentPageState extends State<PaymentStatefulWidget> {
  final String totalcost;
  final String shippingcompany_id;
  final String customerid;
  final String addressid;

  _PaymentPageState(this.totalcost , this.shippingcompany_id,this.customerid,this.addressid);


   final HTTPAll http_obj = HTTPAll();

  String cardnumber;
  String card_owner;
  String month = "MONTH";
  String year = "YEAR";
  String cvc = "-1";
  String promocode= "NoCoup";
  String installement = "1";

  double final_total_price  = double.parse(nt_price);

  TextEditingController cardnumberController = new TextEditingController();
  TextEditingController card_ownerController = new TextEditingController();
  TextEditingController cvcController = new TextEditingController();
  TextEditingController promocodeController = new TextEditingController();
  TextEditingController ifPromoNewPrice = new TextEditingController();



  //https://www.youtube.com/watch?v=FGfhnS6skMQ
  createAlertDialog(BuildContext context)  {
  return showDialog(context:context ,builder : (context) {
    return AlertDialog(
      title: Text("Promocode"),
      content: TextField(
        controller: promocodeController,
      ),
      actions: <Widget>[
        MaterialButton(
          elevation :5.0,
          child:Text("Control"),
          onPressed:() async {

            final String  result =  await http_obj.getPromoCode( promocodeController.text.toString(),totalcost);
            print(result);
            if (result == "0.00"){
              print("HEREEE");

              promocodeController.text = "";
              nt_price = nt_price;
              Navigator.pop(context);
              //Navigator.of(context).pop(promocodeController.text.toString());
            }else{
              final_total_price = double.parse(result);
              nt_price = final_total_price.toStringAsFixed(2);
              print(nt_price);
              //Navigator.of(context).pop(nt_price);
              Navigator.pop(context);
            }
          },
        ), MaterialButton(
          elevation :5.0,
          child:Text("Cancel"),
          onPressed:()  {
            promocodeController.text = "";
            promocode = "NoCoup";
            nt_price = totalcost;
            final_total_price = double.parse(nt_price);
             Navigator.of(context).pop();
          },
        )
      ],
    );
  });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: MyAppBar(
            pageTitle: "Payment",
            loginIcon: false,
            back: false,
            filter_list: false,
            search: false,
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: new Stack(
              children: <Widget>[_showForm(context,totalcost)],
            ),
          ),
        );
  }

  Widget _showForm(BuildContext context,String totalcost ) {
    return new Container(
      padding: EdgeInsets.all(1.0),
        //resizeToAvoidBottomPadding: false,
        child: new SingleChildScrollView(
        child: new Column(
          //shrinkWrap: true,
          children: <Widget>[
            //dropdown(context),
         showCardNumberInput(),
            showCardOwnerInput(),
            Text("\nValid Thru" ,style: TextStyle(fontWeight: FontWeight.bold), ),
            //Text("Month" ,style: TextStyle(fontWeight: FontWeight.bold), ),
            Row( children: <Widget>[
              Text("\t\t"),
               Icon(
                Icons.credit_card,
                color: Colors.green,
              ),dropdownMonth(context),
            ]),
            Row( children: <Widget>[
              Text("\t\t"),
               Icon(
                Icons.credit_card,
                color: Colors.green,
              ), dropYear(context),
            ]),

            showCVCInput(),

            Row( children: <Widget>[

              Text("\t\tTotal Cost:\$"+ final_total_price.toStringAsFixed(2) +"\t\t" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20), ),

              new RaisedButton(onPressed: () {

                  createAlertDialog(context);
                  print("NNNNTTTTT");

                },child: new Text("Use Promo-Code"),
                textColor: Colors.black,
                color: Colors.yellow,),

              Column(
                children: <Widget>[
                  Icon(
                    Icons.brightness_1,
                    color: Colors.red,
                  ),
                  Text("\tonly one coupon" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 9), ),
                  Text("can be used" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 9), ),

                ],
              )

            ]),
            Row( children: <Widget>[
              FlatButton( child: Text("Information Contract",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,decoration: TextDecoration.underline,color: Colors.indigo)), onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    // new BookView(isbn: isbnSet.elementAt(index).toString()),
                    new TextFull(),
                  ));}),
              FlatButton(child: Text("Sales Contract",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,decoration: TextDecoration.underline,color: Colors.indigo)), onPressed: () {   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    // new BookView(isbn: isbnSet.elementAt(index).toString()),
                    new TextFull(),
                  ));}),
              Column(
                  children: <Widget>[
                    Text("\nHire Purchase" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black)),
                    installment(context),
                  ]
              )

            ]),
            //installment(context),

            showPayButton(totalcost),
            Image.asset('assets/payment.jpg')
          ],
        ),
      ),
    );
  }


  Widget showCardNumberInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 0.0),
      child: new TextFormField(
        controller: cardnumberController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Card Number',
          icon: new Icon(
            Icons.credit_card,
            color: Colors.green,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
      ),
    );
  }
  Widget showCardOwnerInput() {

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 0.0),
      child: new TextFormField(
        controller: card_ownerController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Card Owner',
          icon: new Icon(
            Icons.person,
            color: Colors.black,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
      ),
    );
  }


  Widget showMonthInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 0.0),
      child: new TextFormField(
        //controller: monthController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Month',
          icon: new Icon(
            Icons.credit_card,
            color: Colors.green,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
      ),
    );
  }  Widget showYearInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 0.0),

      child: new TextFormField(
        //controller: yearController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Year',
          icon: new Icon(
            Icons.credit_card,
            color: Colors.green,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
      ),
    );
  }

  Widget showCVCInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 0.0),
      child: new TextFormField(
        controller: cvcController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'CVC',
          icon: new Icon(
            Icons.credit_card,
            color: Colors.green,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width:1.0),
          ),
        ),

      ),
    );
  }

  Widget dropYear(BuildContext context) {
    String dropdownValue = year;
    return Container(
        width: 300.0,
        height: 60,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal:30.0,

        ),
        decoration: ShapeDecoration(

        shape: RoundedRectangleBorder(

        side: BorderSide(width: 0.50, style: BorderStyle.solid,color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    ),

    child: DropdownButtonHideUnderline(
    child: ButtonTheme(

    alignedDropdown: true,
    child : DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 30,
      elevation: 25,
      style: TextStyle(color: Colors.black),

      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          year = newValue;}
        );
      },
      items: <String>['YEAR','2020', '2021', '2022', '2023','2024', '2025', '2026', '2027','2028', '2029', '2030', '2031','2032', '2033', '2034', '2035']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value ,style: TextStyle(fontWeight: FontWeight.bold), ) ,
        );
      }).toList(),
    ))));
  }
  Widget dropdownMonth(BuildContext context) {
    String dropdownValue = month;
    return Container(
        width: 300.0,
        height: 60,
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 30.0,
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, style: BorderStyle.solid,color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    ),
    child: DropdownButtonHideUnderline(
    child: ButtonTheme(
    alignedDropdown: true,
    child : DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 30,
      elevation: 25,
      style: TextStyle(color: Colors.black),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          month = newValue;}
        );
      },
      items: <String>['MONTH','01', '02 ', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value ,style: TextStyle(fontWeight: FontWeight.bold), ) ,
        );
      }).toList(),
    ))));
  }
  Widget dropdown(BuildContext context) {
    final HTTPAll http_obj = HTTPAll();
    String dropdownValue = "Shipping Company";

     Scaffold(
        appBar: MyAppBar(
          pageTitle: "Shipping Companies",
          back: true,
        ),
        body : FutureBuilder(
            future: http_obj.getCompanies(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Model_ShippingCompany> shippingCompList =  snapshot.data;
                List<String> printList = ['Shipping Company'];
                for(int i = 0; i<shippingCompList.length;i++){
                  printList.add(shippingCompList[i].companyName + "\t\$"+ shippingCompList[i].shippingPrice );
                }
                print(printList);

                return Container(
                    width: 300.0,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal:30.0,
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, style: BorderStyle.solid,color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child :DropdownButton<String>(

                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 30,
                              elevation: 25,
                              style: TextStyle(color: Colors.black),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                  //shipping_company = newValue;
                                }
                                );
                              },
                              items: printList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value ,style: TextStyle(fontWeight: FontWeight.bold), ) ,
                                );
                              }).toList(),
                            ))));
              } else if (snapshot.hasError) {
                print("Snapshot has error*");
                return Text("${snapshot.error}");
              } else {
                print("EROROOROR");
                return Center(child: CircularProgressIndicator());
              }
            }
        ));


  }


  Widget showPayButton(String totalCost) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(130, 10, 130, 10),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          color: Colors.red,
          disabledColor: Colors.redAccent,
          //add this to your code,
          child: new Text("Pay",
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
            //_formKey.currentState.validate();
/*
  final String totalcost;
  final String shippingcompany_id; yes
  final String customerid;  yes
  final String addressid;
 */
print("********");
            print(nt_price);
            print(shippingcompany_id);
            print(customerid);
            print(addressid);
print("********");
            cardnumber = cardnumberController.text;
            card_owner = card_ownerController.text;
            month = month; //monthController.text;
            year = year;//yearController.text;
            cvc = cvcController.text;
            print(promocode);
            if(promocodeController.text.length > 1){
              print(promocodeController.text);
              print("here i am ");
              promocode = promocodeController.text.toString();
              print(promocode);

            }

            print(promocode);
            var result = http_obj.Payment( customerid,cardnumber,card_owner,shippingcompany_id,nt_price,addressid,promocode,month,year,cvc);
            print(result);
            // print(result);
            //print("****" + errorControl.toString());
            Timer(Duration(seconds: 1), () {
              if (errorControl == false) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    deleteBasket();
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Payment"),
                      content: new Text("Payment is successful"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.push(  context, new MaterialPageRoute(builder: (context) => new MyApp()), );
                          },
                        ),
                      ],
                    );
                  },
                );


              }
              else {
                errorControl = false;
                Timer(Duration(seconds: 1), () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("Payment"),
                        content: new Text(errorMessage),
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
                });
              }
            });
          }),
    );
  }

  Widget applyPromo() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: new IconButton(
        icon: Icon(Icons.done_outline),
        tooltip: 'apply',
        onPressed: () {

        },
      ),
    );
  }///installment
  Widget installment(BuildContext context) {
    String dropdownValue = installement;
    return Container(
        width: 100,
        height: 30,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal:30,
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, style: BorderStyle.solid,color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),

        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child : DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.calendar_view_day),
                  iconSize: 20,
                  elevation: 20,
                  style: TextStyle(color: Colors.black),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      installement = dropdownValue;}
                    );
                  },
                  items: <String>['1','3', '6', '9', '12']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value ,style: TextStyle(fontWeight: FontWeight.bold), ) ,
                    );
                  }).toList(),
                ))));
  }
  Future<void> deleteBasket() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   // List<String> basketList = sharedPreferences.getStringList("customerId");
    List<String> emptyList =[];
    sharedPreferences.setStringList(customerID,emptyList);
    print(sharedPreferences.getStringList(customerID));
    }
}

class TextFull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = "This Distance Sales Contract has been prepared in accordance with the Law No. 6502 on Consumer Protection and the Regulation on Distance Contracts. The parties of this Agreement accept and declare that they know and understand their obligations and responsibilities arising from the Law and the Distance Contracts Regulation under this Agreement.Subject of this Agreement; From Buyer's website www.bookland.com  of Bookland Innovation Company (Bookland / Intermediary Service Provider), the goods or services of the Seller It establishes the determination of the rights and obligations of the parties in accordance with the provisions of the Law and Regulation on Distance Contracts regarding the sale and delivery of goods or services specified in the Contract, which are electronically ordered for their purchase.The conclusion of this Agreement will not prevent the performance of the provisions of the Website Membership Agreements signed between the parties and BOOKLAND separately, and the parties are not liable in any way to ensure that BOOKLAND is not a party to the sale of the goods or services subject to this Agreement and that the parties fulfill their obligations under the Agreement. they accept and declare that they have no responsibility or commitment.";
    text = text + "\n"+ text;
    return Scaffold(
      appBar: AppBar(
        leading: Text("\n"),
        title: Text("Contract Page"),
      ),
      body: Center(
        child: Text( text ),
    ));
  }
}


