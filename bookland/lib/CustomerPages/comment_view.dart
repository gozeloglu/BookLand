import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookland/services/http_comment_vote.dart';

int commentCount = 0;

class CommentView extends StatefulWidget {
  final String bookId;

  CommentView(this.bookId);

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  int page = 1;
  CommentVote commentVote = new CommentVote();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          pageTitle: "Comments",
          loginIcon: false,
          back: false,
          search: false,
          filter_list: false,
        ),
        body: commentPage(),
    bottomNavigationBar: MyBottomNavigatorBar(),);
  }

  Widget commentPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: comment(),
        ),
        Expanded(
          flex: 1,
          child: commentCount > 0 ? buttons() : Row(),
        )
      ],
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [backButton(), nextButton()],
    );
  }

  Widget comment() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: FutureBuilder<List<dynamic>>(
        future: commentVote.getComments(widget.bookId, page),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              noComment();
            } else {
              List<String> commentList = [];
              List<String> commenterList = [];

              for (int i = 0; i < snapshot.data.length; i++) {
                commentList.add(snapshot.data[i]["commentText"]);
                commenterList.add(snapshot.data[i]["commenterName"] +
                    " " +
                    snapshot.data[i]["commenterSurname"]);
              }

              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    // TODO Card can be changed
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                          title: Text(commenterList[index]),
                          subtitle: Text(commentList[index])),
                    );
                  });
            }
          } else if (!snapshot.hasData) {
            noComment();
          }
          return Center(
            child: Text(
              "There is no comment for this book!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          );
        },
      ),
    );
  }

  Widget backButton() {
    return RaisedButton(
      child: Text(
        "Back",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      disabledColor: Colors.grey,
      disabledTextColor: Colors.white,
      // If we do not reach beginning page, enable the back button
      // Otherwise, disable back button
      onPressed: page > 1
          ? () {
              setState(() {
                page--;
              });
            }
          : null,
    );
  }

  Widget nextButton() {
    return RaisedButton(
        child: Text(
          "Next",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        disabledColor: Colors.grey,
        disabledTextColor: Colors.white,
        // If total page is not bigger than current page, increment page by 1
        // If we reach final page, disable the button
        onPressed: (page < (commentCount / 5))
            ? () {
                setState(() {
                  page++;
                });
              }
            : null);
  }

  Widget noComment() {
    return Center(
      child: Text(
        "There is no comment for this book!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
