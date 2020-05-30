import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookland/comment_write.dart';
import 'package:bookland/comment_view.dart';

class CommentVote {
  /// @param bookId represents the book that we want to write comment
  /// @param customerId represents the user who wants to write comment
  /// @param comment is a string that we want to save on database
  /// This function saves the comment on the database
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

  /// @param bookId represents the id of the book that we want to retrieve comments
  /// @param pageNo represents the pagination page
  /// @return Comment list
  /// This function retrieves and returns the comments five-by-five
  Future<List<dynamic>> getComments(String bookId, int pageNo) async {
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get(
        "http://10.0.2.2:8080/getBookComments/$pageNo/5/$bookId",
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode < 400) {
      return json.decode(response.body);
    } else {
      throw Exception("No comment!");
    }
  }

  /// @param bookId represents the book id that we want to retrieve comments
  /// This function fetches the total comment number
  Future<int> getCommentCount(String bookId) async {
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.get(
        "http://10.0.2.2:8080/getBookComments/$bookId",
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (response.statusCode < 400) {
      return json.decode(response.body);
    } else {
      throw Exception("Comment count could not retrieved!");
    }
  }

  /// @param customerId represents the id of the customer who wants to give rating
  /// @param bookId represents the id of the book that we want to give rating
  /// @param rating is customer's rating for the book
  /// @return Average rating
  /// This function saves the customer's rating on the database
  Future<double> giveRating(
      String customerId, String bookId, int rating) async {
    String username = 'Daryl';
    String password = 'WalkingDead';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post("http://10.0.2.2:8080/voteBook",
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "customerId": int.parse(customerId),
          "isbn": int.parse(bookId),
          "voteNumber": rating
        }));
    if (response.statusCode < 400) {
      return json.decode(response.body);
    } else {
      print("No vote!");
      throw Exception("Vote is unsuccessful!");
    }
  }
}
