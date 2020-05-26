import 'package:bookland/customerBookView.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/http_comment_vote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isCommentSend = false;
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

  /*Widget rateField() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Rate: ",
              style: TextStyle(fontSize: 20),
            ),
            SmoothStarRating(
                rating: rating,
                isReadOnly: false,
                size: 30,
                filledIconData: Icons.star,
                defaultIconData: Icons.star_border,
                starCount: 5,
                allowHalfRating: false,
                spacing: 2.0,
                onRated: (value) {
                  print('rating value --> $value');
                }),
          ],
        ));
  }*/

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
            String comment = commentTextController.text;
            bool isEmpty = false;
            if (comment == "") {
              isEmpty = true;
            }

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
              commentVote.sendComment(bookId, customerId, comment);
            }
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
            } else if (!isCommentSend) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error!"),
                      content: Text("Comment could not sent!"),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25)),
                      actions: [
                        new FlatButton(onPressed: () {}, child: Text("Close")),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
