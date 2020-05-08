import 'dart:convert';
import 'package:http/http.dart';

class Address {
  Future<bool> saveAddress(
      int userId, String addressLine, String postalCode, String addressTitle) async {
    String username = 'Daryl';
    String password = 'WalkingDead';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response response;

    if (addressLine == null) {
      return false;
    }
    if (postalCode == null) {
      return false;
    }
    if (addressTitle == null) {
      return false;
    }

    return true;
  }
}
