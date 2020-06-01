import 'package:bookland/elements/appBar.dart';
import 'package:flutter/material.dart';
import 'package:bookland/services/http_admin.dart';

class adminCampaign extends StatelessWidget {
  static const String _title = 'Create Campaign';

  final HttpAdmin httpAdmin = HttpAdmin();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String campaingId;
  String couponCode;
  String couponDiscount;
  String campaignName;
  String endDate;
  String participantQuantity;


  TextEditingController campaignIdController = new TextEditingController();
  TextEditingController couponCodeController = new TextEditingController();
  TextEditingController couponDiscountController = new TextEditingController();
  TextEditingController campaignNameController =
  new TextEditingController();
  TextEditingController endDateController = new TextEditingController();
  TextEditingController participantQuantityController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: MyAppBar(
        pageTitle: "Create Campaign",
        loginIcon: false,
        back: false,
        filter_list: false,
        search: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: new Stack(
          children: <Widget>[_showForm()],
        ),
      ),
    );
  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(1.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            //showIdInput(),
            showCouponCodeInput(),
            showCouponDiscount(),
            showCampaignNameInput(),
            showDateInput(),
            showQuantityInput(),
            CreateCampaignButton()
          ],
        ),
      ),
    );
  }

  Widget showQuantityInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
      child: new TextFormField(
        controller: participantQuantityController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'How many people can take advantage? ',
          icon: new Icon(
            Icons.person_add,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        //validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }


  //Kupon kodu min - 8 max 16 olmalı
  Widget showCouponCodeInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
      child: new TextFormField(
        controller: couponCodeController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Coupon Code',
          icon: new Icon(
            Icons.more,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        //validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showCouponDiscount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: couponDiscountController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Discount',
          icon: new Icon(
            Icons.expand_more,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) =>
        value.isEmpty ? 'Book Link cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showCampaignNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: campaignNameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Why this campaign?',
          icon: new Icon(
            Icons.category,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) => value.isEmpty ? 'Category cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showDateInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: endDateController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Due Date (YYYY-MM-DD)',
          icon: new Icon(
            Icons.date_range,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        validator: (value) =>
        value.isEmpty ? 'Due Date cannot be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }


  Widget CreateCampaignButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          color: Colors.green,
          disabledColor: Colors.redAccent,
          //add this to your code,
          child: new Text("Create This Campaign!",
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
            //_formKey.currentState.validate();
            campaingId = campaignIdController.text;
            couponCode = couponCodeController.text;
            couponDiscount = couponDiscountController.text;
            campaignName = campaignNameController.text;
            endDate = endDateController.text;
            participantQuantity = participantQuantityController.text;

            //print(isbn book_name,book_category,book_sub_category,book_author,book_img,book_description ,book_price);

            var result = httpAdmin.adminMakeCampaign(
                couponCode,
                couponDiscount,
                campaignName,
                endDate,
                participantQuantity );

            print(result);
            //print("****" + errorControl.toString());
            /* Timer(Duration(seconds: 1), () {
              if (errorControl == false) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Add Book"),
                      content: new Text("Adding book is successful"),
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


              }
              else {
                errorControl = false;
                Timer(Duration(seconds: 1), () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("Add Book"),
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
            });  */
            //TODO kullanıcya mesaj döndürülmeli

            /*Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new MyApp(),
            )
            );*/
          }),
    );
  }
}
