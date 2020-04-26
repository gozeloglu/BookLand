import 'dart:async';

import 'package:bookland/adminOrders.dart';
import 'package:bookland/main.dart';
import 'package:bookland/services/globalVariable.dart';
import 'package:flutter/material.dart';
import 'package:bookland/signUp.dart';
import 'package:bookland/services/HTTP.dart';

import 'elements/appBar.dart';

var globalContext;
class Login extends StatelessWidget {

  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    // TODO: implement build
    return MaterialApp(
      title: _title,
      home: LoginStatefulWidget(),
    );
  }
}

class LoginStatefulWidget extends StatefulWidget {
  LoginStatefulWidget({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginStatefulWidget> {
  // Note: These variables are about backend
  final HTTPAll loginUser = HTTPAll();
  String _email;
  String _password;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  bool _isLoginForm = true;
  bool passwordVisible;
  int _count = 0;

  @override
  // ignore: must_call_super
  void initState() {
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO this function will be filled
    return new Scaffold(
      appBar: MyAppBar(
        pageTitle: "Login", back: false,
      ),
      body: Stack(
        children: <Widget>[
          _showForm()
        ],
      ),
    );
  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showEmailInput(),
            showPasswordInput(),
            showLoginButton(),
            showForgotPasswordButton(),
            showSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        controller: emailController,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          )
        ),
        validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );

  }

  Widget showPasswordInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: new TextFormField(
          controller: passwordController,
          maxLines: 1,
          obscureText: passwordVisible,
          autofocus: false,
          decoration: new InputDecoration(
            hintText: 'Password',

            // Password visibility is added here
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible
                ? Icons.visibility
                      : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )
          ),
          validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
          onSaved: (value) => _password = value.trim(),
        ),
    );
  }

  Widget showLoginButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
            style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            // TODO onPressed should be updated
            onPressed: (){
              _email = emailController.text;
              _password = passwordController.text;
              loginUser.getUser(_email, _password);
              Timer(Duration(seconds: 3), () {
                if (isAnyUserLogin){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("LOGIN"),
                        content: new Text("Successful Login!!!"),
                        actions: <Widget>[
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
                  if(ISADMIN == 0){
                    Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => new MyApp()),
                    );

                  }else if(ISADMIN == 1){
                    Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => new adminOrders()),
                    );
                  }
                }else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("LOGIN"),
                        content: new Text("Invalid Username or Password!!!!"),
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

              });



            }),
    );
  }

  Widget showForgotPasswordButton() {
    return new FlatButton(
        onPressed: null,
        child: new Text(
          // WARNING _isLoginForm may not be true variable for this one
           'Forgot My Password',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
    );
  }

  Widget showSignUpButton() {
    return new FlatButton(
        onPressed: () {Navigator.push(
          context, new MaterialPageRoute(builder: (context) => new SignUp()),
        );},
        child: new Text(
          'Sign Up',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)
        )
    );
  }
}