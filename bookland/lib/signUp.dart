import 'dart:async';

import 'package:bookland/elements/appBar.dart';
import 'package:bookland/services/HTTP.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'login.dart';
import 'main.dart';
var globalContext;

class SignUp extends StatelessWidget {

  static const String _title = 'Sign-Up';

  @override
  Widget build(BuildContext context) {
    globalContext = context;

    // TODO: implement build
    return MaterialApp(
      title: _title,
      home: SignUpStatefulWidget(),
    );
  }
}

class SignUpStatefulWidget extends StatefulWidget {
  SignUpStatefulWidget({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HTTPAll signUpUser = HTTPAll();
  bool _obscureText = true;
  bool showTooltipFirstname = false;
  bool showTooltipSurname = false;
  bool showTooltipEmail = false;
  bool showTooltipPassword = false;
  bool showTooltipPasswordAgain = false;

  FocusNode textSecondFocusNode = new FocusNode();
  FocusNode textThirdFocusNode = new FocusNode();
  FocusNode textFourthFocusNode = new FocusNode();
  FocusNode textFifthFocusNode = new FocusNode();
  FocusNode textSixthFocusNode = new FocusNode();
  FocusNode textSeventhFocusNode = new FocusNode();
  TextEditingController firstName_controller = new TextEditingController();
  TextEditingController surname_controller = new TextEditingController();
  TextEditingController dateOfBirth_controller = new TextEditingController();
  TextEditingController phoneNumber_controller = new TextEditingController();
  TextEditingController email_controller = new TextEditingController();
  TextEditingController password_controller = new TextEditingController();
  TextEditingController passwordAgain_controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: MyAppBar(pageTitle: "Sig Up", back: false,),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 50, bottom: 50),
        child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FirstnameArg(),
              surnameArg(),
              DateofBirthArg(),
              phoneNumberArg(),
              emailArg(),
              passwordArg(),
              PasswordAgainArg(),
              AlreadyHaveAccount(),
              showSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget FirstnameArg() {
    return new Stack(
      alignment: Alignment.topRight,
      overflow: Overflow.visible,
      children: <Widget>[
        new TextFormField(
          controller: firstName_controller,
          keyboardType: TextInputType.text,
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(textSecondFocusNode);
          },
          decoration: new InputDecoration(
            hintText: "Firstname",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(width: 5)),
            hintStyle: new TextStyle(fontSize: 22.0),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.error,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  showTooltipFirstname = !showTooltipFirstname;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 10,
          //You can use your own custom tooltip widget over here in place of below Container
          child: showTooltipFirstname
              ? Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                "Firstname field cannot be empty",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
              : Container(),
        ),
      ],
    );
  }

  Widget surnameArg() {
    return new Stack(
      alignment: Alignment.topRight,
      overflow: Overflow.visible,
      children: <Widget>[
        new TextFormField(
          controller: surname_controller,
            keyboardType: TextInputType.text,
            focusNode: textSecondFocusNode,
            onFieldSubmitted: (String value) {
              FocusScope.of(context).requestFocus(textThirdFocusNode);
            },
            decoration: new InputDecoration(
              hintText: "Surname",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide()),
              hintStyle: new TextStyle(fontSize: 22.0),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    showTooltipSurname = !showTooltipSurname;
                  });
                },
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                setState(() {
                  showTooltipSurname = true; //Toggles the tooltip
                });
                return "";
              }
              return "";
            }),
        Positioned(
          bottom: 50,
          right: 10,
          child: showTooltipSurname
              ? Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                "Surname field cannot be empty",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
              : Container(),
        ),
      ],
    );
  }

  Widget DateofBirthArg() {
    return new TextFormField(
      controller: dateOfBirth_controller,
        keyboardType: TextInputType.datetime,
        focusNode: textThirdFocusNode,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textFourthFocusNode);
        },
        decoration: new InputDecoration(
          hintText: "Date of Birth (MM/DD/YY)",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()),
          hintStyle: new TextStyle(fontSize: 22.0),
        ));
  }

  Widget phoneNumberArg() {
    return new TextFormField(
      controller: phoneNumber_controller,
        keyboardType: TextInputType.phone,
        focusNode: textFourthFocusNode,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textFifthFocusNode);
        },
        decoration: new InputDecoration(
          hintText: "Phone Number",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide()),
          hintStyle: new TextStyle(fontSize: 22.0),
        ));
  }

  Widget emailArg() {
    return new Stack(
      alignment: Alignment.topRight,
      overflow: Overflow.visible,
      children: <Widget>[
        new TextFormField(
          controller: email_controller,
            keyboardType: TextInputType.emailAddress,
            focusNode: textFifthFocusNode,
            onFieldSubmitted: (String value) {
              FocusScope.of(context).requestFocus(textSixthFocusNode);
            },
            decoration: new InputDecoration(
              hintText: "Email",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide()),
              hintStyle: new TextStyle(fontSize: 22.0),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    showTooltipEmail = !showTooltipEmail;
                  });
                },
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                setState(() {
                  showTooltipEmail = true; //Toggles the tooltip
                });
                return "";
              }
              return "";
            }),
        Positioned(
          bottom: 50,
          right: 10,
          child: showTooltipEmail
              ? Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                "Enter a Valid Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
              : Container(),
        ),
      ],
    );
  }

  Widget passwordArg() {
    return new Stack(
      alignment: Alignment.topRight,
      overflow: Overflow.visible,
      children: <Widget>[
        new TextFormField(
          controller: password_controller,
          focusNode: textSixthFocusNode,
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(textSeventhFocusNode);
          },
          decoration: new InputDecoration(
            hintText: "Password",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide()),
            hintStyle: new TextStyle(fontSize: 22.0),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.error,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  showTooltipPassword = !showTooltipPassword;
                });
              },
            ),
          ),
          obscureText: true,
          validator: (value) =>
          value.isEmpty ? 'Password cannot be blank' : null,
        ),
        Positioned(
          top: 55,
          right: 10,
          //You can use your own custom tooltip widget over here in place of below Container
          child: showTooltipPassword
              ? Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                "Password must at least 8 characters.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
              : Container(),
        ),
      ],
    );
  }

  Widget PasswordAgainArg() {
    return new TextFormField(
      controller: passwordAgain_controller,
      focusNode: textSeventhFocusNode,
      decoration: new InputDecoration(
        hintText: "Password Again",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide()),
        hintStyle: new TextStyle(fontSize: 22.0),
      ),
      obscureText: true,
      validator: (value) => value.isEmpty ? 'Password cannot be blank' : null,
    );
  }

  Widget AlreadyHaveAccount() {
    return new FlatButton(
        onPressed: () {
          Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Login()),
          );
          // TODO Login page will be here
        },
        child: new Text(
          // WARNING _isLoginForm may not be true variable for this one
            'Already Have Account?',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
    );
  }

  Widget showSignUpButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          color: Colors.blue,
          disabledColor: Colors.blue,
          //add this to your code,
          child: new Text("Sign Up",
              style: new TextStyle(fontSize: 20.0, color: Colors.black87)),
          // TODO onPressed should be updated
          onPressed: () {
           // _formKey.currentState.validate();
            if(password_controller.text != passwordAgain_controller.text){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("SignUp"),
                    content: new Text("Passwords must be equal!!!"),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );

            }
            else{
              signUpUser.saveCustomer(firstName_controller.text,
                  surname_controller.text,
                  email_controller.text,
                  password_controller.text,
                  0,
                  phoneNumber_controller.text);
              if(errorControl == false){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("SignUp"),
                      content: new Text("Succesfull SignUp!!!"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => new Login()),
                );
              }
              else {
                errorControl = false;
                Timer(Duration(seconds: 3), () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("SignUp"),
                        content: new Text(errorMessage),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              }
              }


          }),
    );
  }
}