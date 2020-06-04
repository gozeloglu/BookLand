import 'package:bookland/elements/bottomNavigatorBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'elements/appBar.dart';

class Manual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: MyAppBar(
        pageTitle: "Manual",
        loginIcon: true,
        back: false,
        filter_list: false,
        search: false,
    ),
      body: new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bookland__pp.png"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop)
            ),
          ),
        padding: EdgeInsets.only(left: 20, right: 20),
        //color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("\nHello!\nWelcome to BookLand!",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                Text("\nYou can find lots of books in this application. To buy these books, you should register to BookLand. "
                    "After the registration, only thing to do is searching a book! Afterwards, you can add them to your wishlist or buy them directly."
                    "\nWe hope, you will enjoy this.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text("\n\nIf you have a problem, let us to know!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text("\nTeam NEF-GB\nnef-gb@bookland.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),


              ],
            )
          ],
        )
      ),
      bottomNavigationBar: MyBottomNavigatorBar(),
    );
  }


}