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
  String _dateofbirth;
  String _email;
  String _password;
  String _passwordAgain;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(globalContext),
          ),
          title: const Text('BookLand-Sign Up',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          //title: Text("Sign Up"),
          centerTitle: true,
        ),
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
          /*  validator: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              showTooltipFirstname = true; //Toggles the tooltip
                            });
                            return "";
                          }
                          return "";
                        }*/
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
          //You can use your own custom tooltip widget over here in place of below Container
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
        keyboardType: TextInputType.phone,
        focusNode: textThirdFocusNode,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textFourthFocusNode);
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
            keyboardType: TextInputType.emailAddress,
            focusNode: textFourthFocusNode,
            onFieldSubmitted: (String value) {
              FocusScope.of(context).requestFocus(textFifthFocusNode);
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
          //You can use your own custom tooltip widget over here in place of below Container
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
          focusNode: textFifthFocusNode,
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(textSixthFocusNode);
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
      focusNode: textSixthFocusNode,
      decoration: new InputDecoration(
        hintText: "Password Again",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide()),
        hintStyle: new TextStyle(fontSize: 22.0),
        /*suffixIcon: IconButton(
                      icon: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          showTooltipPasswordAgain = !showTooltipPasswordAgain;
                        });
                      },
                    ),*/
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
            _formKey.currentState.validate();
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new MyStatelessWidget()),
            );
          }),
    );
  }
}
