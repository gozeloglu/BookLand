import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget{
  final String pageTitle;
  MyAppBar({Key key, this.pageTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text( pageTitle,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
      //title: Text("Sign Up"),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}