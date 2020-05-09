import 'dart:convert';
import 'package:http/http.dart' as http;

class Address {
  Future<String> saveAddress(int userId, String addressLine, String city,
      String country, String postalCode, String addressTitle) async {

    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    // Body attributes for POST
    Map<String, String> cityCountryMap = {"city": city, "country": country};
    Map<String, dynamic> postalCodeCityMap = {"postalCode": postalCode, "city": cityCountryMap};

    http.Response response = await http.post(
        "http://10.0.2.2:8080/saveAddress/$userId",
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "addressLine": addressLine,
          "addressTitle": addressTitle,
          "postalCodeCity": postalCodeCityMap,
        }));
    if (response.statusCode < 400) {
      return "Address is added";
    } else {
      print(response.statusCode);
      throw Exception("Failed to save address");
    }
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
      city: json["city"],
      country: json["country"],
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
      postalCode: json["postalCode"],
      city: json["city"],
    );
  }
}

class AddressModel {
  final String addressLine;
  final String addressTitle;
  final List<PostalCodeCity> postalCodeCity;

  AddressModel({
    this.addressTitle,
    this.postalCodeCity,
    this.addressLine,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressLine: json["addressLine"],
      addressTitle: json["addressTitle"],
      postalCodeCity: json["postalCodeCity"],
    );
  }
}
