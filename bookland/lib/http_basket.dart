import 'package:http/http.dart' as http;
import 'dart:convert';

class BasketHttp {
  Future<List<String>> getBasketBooks(List<String> bookIdList) async {
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
      return jsonDecode(response.body);
    } else {
      print("NOT SUCCESSFUL");
      throw Exception("Book cart could not fetched!");
    }
  }
}
