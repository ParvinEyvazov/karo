import 'package:flutter/material.dart';
import 'package:karo_app/ui/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _initialValues = {
    'studentId': '',
    'password': '',
  };

  final _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Student ID'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                initialValue: _initialValues['studentId'],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Student ID';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                focusNode: _passwordNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
