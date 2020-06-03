import 'dart:convert';
import 'package:bookland/CustomerPages/basket.dart';
import 'package:bookland/model/model_user.dart';
import 'package:bookland/model/model_order.dart';
import 'package:bookland/model/error.dart';
import 'package:http/http.dart' as http;
import 'package:bookland/main.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:bookland/model/model_shippingcompany.dart';

class HTTPAll {
  static String basicAuth =
      'Basic ' + base64Encode(utf8.encode('Daryl:WalkingDead'));

  Future getUser(String _email, String _password) async {
    http.Response response = await http.post(
      'http://10.0.2.2:8080/login',
      headers: <String, String>{
        'Authorization': HTTPAll.basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _email,
        'password': _password,
      }),
    );

    if (response.statusCode < 400) {
      User obj = User.fromJson(json.decode(response.body));
      CUSTOMERID = obj.CustomerId;

      ///FIRSTNAME = obj.FirstName;
      ///customerFirstName = FIRSTNAME;
      customerFirstName = obj.FirstName;
      ISADMIN = obj.IsAdmin;
      isAnyUserLogin = true;
      customerID = CUSTOMERID;
      print("********************************");
      print("CUSTOMER ID $CUSTOMERID");
      print("********************************");
    } else {

      isAnyUserLogin = false;
    }
  }

  Future<String> saveCustomer(String firstName, String surname, String email,
      String password, int isAdmin, String phoneNumber) async {
    http.Response response = await http.post(
      'http://10.0.2.2:8080/saveCustomer',
      headers: <String, String>{
        'Authorization': HTTPAll.basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "firstName": firstName,
        "surname": surname,
        "email": email,
        "password": password,
        "isAdmin": isAdmin,
        "dateOfBirth": null,
        "phoneNumber": phoneNumber,
      }),
    );


    if (response.statusCode < 400) {
    } else {
      Error msg = Error.fromJson(json.decode(response.body));
      errorControl == true;
      errorMessage = msg.errors[0].toString();
    }
  }

  Future<String> getCategories() async {
    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get('http://10.0.2.2:8080/getCategory',
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      String text = response.body;

      return text;
    } else {
      throw "Can't get books.";
    }
  }


  Future<String> Payment(String customerid, String cardNumber ,String cardOwner,String shippingCompid,String totalcost,String addressId,String promocode,String month,String year,String cvc) async {
    String finalval = finalOrders;
    totalcost = totalcost.replaceAll(",", ".");
    print("***---***");
    print(totalcost);

    if(month == "MONTH" || year == "YEAR" || cvc == ""){ //early control for if empty value come
      errorControl = true;
      errorMessage = "Please fill in the empty fields to pay.";
      return "EMPTY";
    }
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    http.Response response;

    response = await http.post('http://10.0.2.2:8080/createOrder/$customerid/$addressId/$shippingCompid', //TODO paramtere yap
      headers: <String, String>{'Authorization': basicAuth,'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "totalAmount" : totalcost.toString(),
        "cardNo": cardNumber.toString(),
        "cardOwner": cardOwner.toString(),
        "basketInfo": finalval.toString(),
        "couponCode": promocode.toString()
      }),
    );

    if (response.statusCode < 400) {
      String text = response.body;
      print(text);
      if(text =="-2"){    //Invalid payment information
        errorControl = true;
        errorMessage = 'Invalid payment information'.toString();
        return "SORRRY" ;
      }else if (text =="-1"){ //If customer dont have enough monety for pay
        errorControl = true;
        errorMessage = 'You do not have sufficient balance to make payment'.toString();
        return "SORRRY" ;
      }
      return "PERFECT";
    } else {
      Error msg = Error.fromJson(json.decode(response.body));
      errorControl = true;
      errorMessage = msg.errors[0].toString();
      //print(response.body);
      //print(msg.errors[0].toString());
     // print("-----" + errorControl.toString());
      return "SORRRY" ;
    }
  }

  Future<List<Model_ShippingCompany>> getCompanies() async {
    var url = "http://10.0.2.2:8080/getCompanies";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));


    final response = await http.get(
      url,
      headers: <String, String>{'authorization': basicAuth},
    );

    if (response.statusCode == 200) {

      Iterable l = json.decode(response.body);
      List<Model_ShippingCompany> myModels =
          (json.decode(response.body) as List)
              .map((i) => Model_ShippingCompany.fromJson(i))
              .toList();
      ;

      return myModels;
    } else {
      throw Exception("Can't get books.");
    }
  }
  Future<Model_Order_Details_Customer> getOrder(String orderid) async {
    var url = "http://10.0.2.2:8080/orderDetails/$orderid";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));


    final response = await http.get(
      url,
      headers: <String, String>{'authorization': basicAuth},
    );

    //http.Response responseJSON = json.decode(response.body);



    if (response.statusCode == 200) {


      Model_Order_Details_Customer obj = Model_Order_Details_Customer.fromJson(json.decode(response.body));

      return obj;

    } else {
      throw Exception("Can't get books.");
    }
  }
  Future<String> getPromoCode(String promocode , String totalcost) async {

    totalcost = totalcost.replaceAll(",", ".");
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    http.Response response;

    response = await http.post('http://10.0.2.2:8080/couponCheck', //TODO paramtere yap
      headers: <String, String>{'Authorization': basicAuth,'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "${promocode}": totalcost,
      }),
    );
    

    if (response.statusCode == 200) {
      String text = response.body;


      double newPrice = double.parse(text); //Convert to double the string price that comes from parameters
      text = newPrice.toStringAsFixed(2);
      text =text.toString();

      return text;
    } else {
      throw "Can't get books.";
    }
  }

  Future<Model_Order_Details> getOrderAdmin(String orderid) async {
    var url = "http://10.0.2.2:8080/showDetailOrderAdmin/$orderid";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));


    final response = await http.get(
      url,
      headers: <String, String>{'authorization': basicAuth},
    );

    //http.Response responseJSON = json.decode(response.body);


    if (response.statusCode == 200) {


      Model_Order_Details obj = Model_Order_Details.fromJson(json.decode(response.body));

      return obj;

    } else {
      throw Exception("Can't get books.");
    }
  }




  Future<String> adminApproveOrder(String orderid) async {
    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get('http://10.0.2.2:8080/confirmOrder/${orderid}',
      headers: <String, String>{'Authorization': basicAuth,'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode < 400) {
      return  "PERFECT";
    } else {
      errorControl = true;
      errorMessage = "Deleting Book has Failed";
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
      return "SORRRY" ;
    }
  }
  Future<String> adminDenyOrder(String orderid) async {
    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get('http://10.0.2.2:8080/rejectOrder/${orderid}',
      headers: <String, String>{'Authorization': basicAuth,'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode < 400) {
      return  "PERFECT";
    } else {
      errorControl = true;
      errorMessage = "Deleting Book has Failed";
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
      return "SORRRY" ;
    }
  }
}
