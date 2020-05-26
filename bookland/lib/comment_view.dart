import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookland/http_comment_vote.dart';

String bookId;

class CommentView extends StatelessWidget {
  CommentView(String _bookId) {
    bookId = _bookId;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Comments",
      home: CommentViewStateful(),
    );
  }
}

class CommentViewStateful extends StatefulWidget {
  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentViewStateful> {
  CommentVote commentVote = new CommentVote();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Comments"),
        ),
        body: commentList());
  }

  Widget commentList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Expanded(child: comment())],
    );
  }

  Widget comment() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
      child: FutureBuilder<List<dynamic>>(
        future: commentVote.getComments(bookId, 1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("HAS DATA");
            List<String> commentList = [];
            List<String> commenterList = [];

            print("SNAPSHOT");
            print(snapshot.data);
            for (int i = 0; i < snapshot.data.length; i++) {
              commentList.add(snapshot.data[i]["commentText"]);
              commenterList.add(snapshot.data[i]["commenterName"] +
                  " " +
                  snapshot.data[i]["commenterSurname"]);
            }

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  // TODO Card can be changed
                  return Card(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10)),
                    elevation: 5,
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: ListTile(
                        title: Text(commenterList[index]),
                        subtitle: Text(commentList[index])),
                  );
                });
          } else if (!snapshot.hasData) {
            // TODO Not data
            print("No comment!");
            return Container(
              alignment: Alignment.center,
              height: 160.0,
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            alignment: Alignment.center,
            height: 160.0,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buttons() {
    return Row();
  }
}
