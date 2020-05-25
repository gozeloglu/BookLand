import 'package:http/http.dart' as http;
import 'dart:convert';

class BasketHttp {
  Future<List<dynamic>> getBasketBooks(List<String> bookIdList) async {
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post("http://10.0.2.2:8080/cartDetails",
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"BookIds": bookIdList}));

    if (response.statusCode < 400) {
      print("Successful");
      print(json.decode(response.body));
      List resultList = [];
      resultList.add(json.decode(response.body));
      return json.decode(response.body);
      /*print(resultList.runtimeType);
      print(json.decode(response.body).runtimeType);
      print(resultList[0]);
      return BasketModel.fromJson(response.body) as List;*/
      ////return (json.decode(response.body) as List);
      /*print(jsonDecode(response.body)[0]);
      print(jsonDecode(response.body).runtimeType);
      print(jsonDecode(response.body).length);
      List resultList = [];
      for (int i = 0; i < response.body.length; i++) {
        resultList.add(jsonDecode(response.body)[i]);
      }
      print(resultList);
      print(resultList.length);
      return resultList;*/
    } else {
      print("NOT SUCCESSFUL");
      throw Exception("Book cart could not fetched!");
    }
  }
}

class BasketModel {
  final String bookImage;
  final String bookName;
  final double price;

  BasketModel({
    this.bookImage,
    this.bookName,
    this.price,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) {
    return BasketModel(
      bookImage: json["bookImage"],
      bookName: json["bookName"],
      price: json["price"],
    );
  }
}
