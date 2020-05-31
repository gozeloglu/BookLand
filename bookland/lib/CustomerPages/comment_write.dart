import 'file:///C:/Users/User/Desktop/1/bbm384-project-spring2020-nef-gb/bookland/lib/CustomerPages/customerBookView.dart';
import 'package:bookland/elements/appBar.dart';
import 'file:///C:/Users/User/Desktop/1/bbm384-project-spring2020-nef-gb/bookland/lib/services/http_comment_vote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isCommentSend = false; // Controls the http request response
String bookId;
String customerId;

class CommentWrite extends StatelessWidget {
  CommentWrite(String _bookId, String _customerId) {
    bookId = _bookId;
    customerId = _customerId;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Write Comment",
      home: CommentWriteStateful(),
    );
  }
}

class CommentWriteStateful extends StatefulWidget {
  @override
  _CommentWriteState createState() => _CommentWriteState();
}

class _CommentWriteState extends State<CommentWriteStateful> {
  CommentVote commentVote = new CommentVote();
  TextEditingController commentTextController = new TextEditingController();
  String comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Write Comment"),
      ),
      body: Stack(
        children: [
          commentField(),
        ],
      ),
    );
  }

  Widget commentField() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: [
            commentTextField(),
            //rateField(),
            commentButton(),
          ],
        ),
      ),
    );
  }

  Widget commentTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: new TextFormField(
        controller: commentTextController,
        maxLines: 10,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Your Comment",
          icon: Icon(Icons.comment),
        ),
        validator: (value) => value.isEmpty ? "Comment cannot be empty!" : null,
        onSaved: (value) => comment = value.trim(),
      ),
    );
  }

  Widget commentButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          color: Colors.green,
          child: Text(
            "Send Comment",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {
            // Get comment from text controller
            String comment = commentTextController.text;
            bool isEmpty = false;

            // If comment is empty
            if (comment == "") {
              isEmpty = true;
            }

            // Show up alert dialog if comment field is empty
            if (isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error!"),
                      content: Text("Comment cannot be empty!"),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25)),
                    );
                  });
            } else {
              // Save on the database
              commentVote.sendComment(bookId, customerId, comment);
            }

            // If comment is send successfully, show up an alert dialog
            if (isCommentSend) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Successful!"),
                      content: Text("Comment is sent!"),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25)),
                      actions: [
                        new FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new CustomerBookView(isbn: bookId)));
                            },
                            child: Text("OK")),
                      ],
                    );
                  });
            } else if (!isCommentSend && !isEmpty) {
              // If comment could not saved and comment field is filled
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error!"),
                      content: Text("Comment could not sent!"),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25)),
                      actions: [
                        new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close")),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
