import 'dart:convert';
import 'package:http/http.dart' as http;
import 'customer_address_add.dart';

class Address {
  /// @param: userId represents user's unique id to save in correct location in db
  /// @param: addressLine represents the whole address of the user
  /// @param: city represents the city of the address
  /// @param: country represents the country of the address
  /// @param: postalCode represents the postal code of the address
  /// @param: addressTitle represents which type of address
  /// This function saves the address of the user in database
  /// Sends POST request to backend with user id
  /// isSaved variable is updated
  Future<String> saveAddress(int userId, String addressLine, String city,
      String country, String postalCode, String addressTitle) async {
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    // Body attributes for POST
    Map<String, String> cityCountryMap = {"city": city, "country": country};
    Map<String, dynamic> postalCodeCityMap = {
      "postalCode": postalCode,
      "city": cityCountryMap
    };

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
      isSaved = true;
    } else {
      isSaved = false;
    }
    if (response.statusCode < 400) {
      return "Address is added";
    } else {
      print(response.statusCode);
      throw Exception("Failed to save address");
    }
  }

  /// @param userId represents the user id to retrieve data
  /// This function GETs the all addresses and returns to
  /// the "My Addresses" page
  Future<List<dynamic>> getAddresses(int userId) async {
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var url = "http://10.0.2.2:8080/myAddresses/$userId";
    String _url = Uri.encodeFull(url);
    http.Response response = await http.get(
      _url,
      headers: <String, String>{'authorization': basicAuth},
    );
    print(response.statusCode);
    if (response.statusCode < 400) {
      return (json.decode(response.body) as List);
    } else {
      throw Exception("Could ot get addresses!");
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
