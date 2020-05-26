import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookland/comment_write.dart';

class CommentVote {
  Future<String> sendComment(
      String bookId, String customerId, String comment) async {
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        "http://10.0.2.2:8080/makeComment/$bookId/$customerId",
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"commentText": comment}));
    if (response.statusCode < 400) {
      print("Successful!");
      isCommentSend = true;
      return "Successful! Comment is saved!";
    } else {
      print(response.statusCode);
      isCommentSend = false;
      throw Exception("Comment could not saved!");
    }
  }
}
