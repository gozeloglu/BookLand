import 'dart:convert';
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
      //print(response.body);

      // Error msg = Error.fromJson(json.decode(response.body));
      // print(msg.errors[0].toString());
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

    //print(response.statusCode);
    // print(response.body);
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
    print("HERE!!!!");
    if (response.statusCode == 200) {
      String text = response.body;
      print(text);
      return text;
    } else {
      throw "Can't get books.";
    }
  }


  Future<String> Payment(String customerid, String cardNumber ,String cardOwner,String card_month,String card_year,String card_CVC ,String shippingCompid) async {

    var client = http.Client();
    var url = "http://10.0.2.2:8080";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    http.Response response;

    response = await http.post('http://10.0.2.2:8080/createOrder/${customerid}/${shippingCompid}', //TODO paramtere yap
      headers: <String, String>{'Authorization': basicAuth,'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "cardNo": cardNumber,
        "ownerName": cardOwner,
        "ownerSurname": cardOwner,
        "customerCardList": [],
        "orderList": "",
      }),
    );

    if (response.statusCode < 400) {
      return "PERFECT";
    } else {
      Error msg = Error.fromJson(json.decode(response.body));
      errorControl = true;
      errorMessage = msg.errors[0].toString();
      print(response.body);
      print(msg.errors[0].toString());
      //throw Exception('Failed to load album');
      print("-----" + errorControl.toString());
      return "SORRRY";
    }
  }

  Future<List<Model_ShippingCompany>> getCompanies() async {
    var url = "http://10.0.2.2:8080/getCompanies";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("Before GET");

    final response = await http.get(
      url,
      headers: <String, String>{'authorization': basicAuth},
    );

    //http.Response responseJSON = json.decode(response.body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print("just after if");
      Iterable l = json.decode(response.body);
      List<Model_ShippingCompany> myModels =
          (json.decode(response.body) as List)
              .map((i) => Model_ShippingCompany.fromJson(i))
              .toList();
      ;
      print("*****LİSTEMMM");
      print(myModels);
      print("*****LİSTEMMM");

      print("dönüyoruzzz");
      print(myModels[0].companyName);
      return myModels;
    } else {
      throw Exception("Can't get books.");
    }
  }
  Future<Model_Order_Details> getOrder(String orderid) async {
    var url = "http://10.0.2.2:8080/orderDetails/$orderid";
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("Before GET");

    final response = await http.get(
      url,
      headers: <String, String>{'authorization': basicAuth},
    );

    //http.Response responseJSON = json.decode(response.body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print("just after if");

      Model_Order_Details obj = Model_Order_Details.fromJson(json.decode(response.body));
      print(obj.orderAdressline);
      print(obj.bookList[0].author);
      return obj;

    } else {
      throw Exception("Can't get books.");
    }
  }
  Future<String> getPromoCode(String promocode , String totalcost) async {
    print(promocode);
    print(totalcost);
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    http.Response response;

    response = await http.post('http://10.0.2.2:8080/couponCheck', //TODO paramtere yap
      headers: <String, String>{'Authorization': basicAuth,'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "${promocode}": 126,
      }),
    );
    print("HERE!!!!");
    if (response.statusCode == 200) {
      String text = response.body;
      print(response.body.toString());
      print(text);
      return text;
    } else {
      throw "Can't get books.";
    }
  }
}
