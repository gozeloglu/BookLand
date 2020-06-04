import 'package:bookland/AdminPages/notification.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationHttp {
  /// @param notificationTitle represents title of the notification
  /// @param notificationMessage represents message body of the notification
  /// This function sends notification to all users and updates the
  /// notificationSent variable
  Future<String> sendNotification(
      String notificationTitle, String notificationMessage) async {
    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('MTUwNDdkMmItMmZlZS00NDJjLThlY2EtNzAxMjZlZWQwMWVl'));

    http.Response response =
        await http.post("https://onesignal.com/api/v1/notifications",
            headers: <String, String>{
              'Authorization':
                  'Basic MTUwNDdkMmItMmZlZS00NDJjLThlY2EtNzAxMjZlZWQwMWVl',
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(<String, dynamic>{
              "app_id": "0ecd191c-68ae-4386-ad78-9ca1d677a390",
              "headings": {"en": notificationTitle},
              "contents": {"en": notificationMessage},
              "included_segments": ["Active Users"]
            }));
    print(response.statusCode);

    if (response.statusCode < 400) {
      print("Notification is sent!");
      notificationSent = true;
      return "Successful!";
    } else {
      print("Could not send notification");
      notificationSent = false;
      throw Exception("Could not send notification!");
    }
  }
}
