import 'package:flutter/material.dart';
import 'package:bookland/signUp.dart';
import 'package:bookland/http_login.dart';

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
  final HttpLogin httpLogin = HttpLogin();
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
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(globalContext),
        ),
        title: new Text('Login'),
        centerTitle: true,
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
              print(_email);
              _password = passwordController.text;
              print(_password);
              httpLogin.getUser(_email, _password);

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