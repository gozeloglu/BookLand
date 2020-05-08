import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_auth/http_auth.dart' as http_auth;

Future<AddressModel> saveAddress(int userId, String addressLine, String city,
    String country, String postalCode, String addressTitle) async {
  String username = 'Daryl';
  String password = 'WalkingDead';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

  Response response = await post("http://10.0.2.2:8080/saveAddress/$userId",
      headers: <String, String>{
        'Authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        "AddressLine": addressLine,
        "AddressTitle": addressTitle,
        "PostalCodeCity": [
          {
            "PostalCode": postalCode,
            "city": [
              {
                "City": city,
                "Country": country,
              }
            ]
          }
        ]
      }));

  print("----------------");
  print(addressLine);
  print(city);
  print(country);
  print(postalCode);
  print(addressTitle);
  print("--------------------");
  print(response.body);
  print(response.statusCode);
  if (response.statusCode < 400) {
    return AddressModel.fromJson(json.decode(response.body));
  } else {
    print(response.statusCode);
    throw Exception("Failed to save address");
  }
}

class City {
  final String city;
  final String country;

  City({
    this.country,
    this.city,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      city: json["City"],
      country: json["Country"],
    );
  }
}

class PostalCodeCity {
  final String postalCode;
  final List<City> city;

  PostalCodeCity({
    this.city,
    this.postalCode,
  });

  factory PostalCodeCity.fromJson(Map<String, dynamic> json) {
    return PostalCodeCity(
      postalCode: json["PostalCode"],
      city: json["city"],
    );
  }
}

class AddressModel {
  final String addressLine;
  final String addressTitle;
  final List<PostalCodeCity> postalCode;

  AddressModel({
    this.addressTitle,
    this.postalCode,
    this.addressLine,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressLine: json["AddressLine"],
      addressTitle: json["AddressTitle"],
      postalCode: json["postalCode"],
    );
  }
}
