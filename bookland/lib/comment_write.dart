import 'package:bookland/elements/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CommentWrite extends StatelessWidget {
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
  TextEditingController commentTextController = new TextEditingController();
  String comment;
  var rating = 0.0;

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
            rateField(),
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

  Widget rateField() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Rate: ", style: TextStyle(fontSize: 20),
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
          onPressed: () {}),
    );
  }
}
